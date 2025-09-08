<?php

namespace App\Http\Controllers;

use App\Models\Group;
use App\Models\GroupInvitation;
use App\Models\InvitationAnalytics;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\RateLimiter;
use Carbon\Carbon;

class InvitationController extends Controller
{
    /**
     * Create a new invitation for a group
     * POST /api/groups/{id}/invitations
     */
    public function createInvitation(Request $request, int $groupId): JsonResponse
    {
        // Rate limiting check
        $key = 'create-invitation:' . Auth::id();
        if (RateLimiter::tooManyAttempts($key, 10)) {
            return response()->json([
                'message' => 'Bạn đã tạo quá nhiều lời mời. Vui lòng thử lại sau.',
                'error' => 'too_many_attempts'
            ], 429);
        }

        $validator = Validator::make($request->all(), [
            'type' => 'required|in:link,sms',
            'expires_in' => 'nullable|in:1d,1w,permanent',
            'recipient_phone' => 'nullable|string|max:20',
            'metadata' => 'nullable|array',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $validator->errors()
            ], 422);
        }

        // Check if user can create invitations for this group
        $group = Group::findOrFail($groupId);
        if (!$this->canCreateInvitation(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền tạo lời mời cho nhóm này',
                'error' => 'forbidden'
            ], 403);
        }

        // Check invitation limits
        $pendingCount = GroupInvitation::where('group_id', $groupId)
            ->where('creator_id', Auth::id())
            ->where('status', 'pending')
            ->count();

        if ($pendingCount >= 10) {
            return response()->json([
                'message' => 'Bạn đã đạt giới hạn 10 lời mời đang chờ. Vui lòng thu hồi hoặc chờ hết hạn.',
                'error' => 'invitation_limit_reached'
            ], 422);
        }

        // Calculate expiration
        $expiresAt = $this->calculateExpiration($request->expires_in);

        // Create invitation
        $invitation = GroupInvitation::create([
            'group_id' => $groupId,
            'creator_id' => Auth::id(),
            'type' => $request->type,
            'recipient_phone' => $request->recipient_phone,
            'expires_at' => $expiresAt,
            'metadata' => $request->metadata ?? [],
        ]);

        // Track creation event
        InvitationAnalytics::track($invitation->id, 'created', [
            'source' => $request->header('X-Source', 'api'),
            'user_agent' => $request->header('User-Agent'),
            'ip_address' => $request->ip(),
        ]);

        RateLimiter::hit($key);

        return response()->json([
            'message' => 'Lời mời được tạo thành công',
            'invitation' => [
                'id' => $invitation->id,
                'token' => $invitation->token,
                'type' => $invitation->type,
                'type_name' => $invitation->type_name,
                'status' => $invitation->status,
                'status_name' => $invitation->status_name,
                'expires_at' => $invitation->expires_at,
                'invitation_url' => $invitation->getInvitationUrl(),
                'created_at' => $invitation->created_at,
            ]
        ], 201);
    }

    /**
     * Get invitations for a group
     * GET /api/groups/{id}/invitations
     */
    public function getGroupInvitations(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        
        if (!$this->canViewInvitations(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền xem lời mời của nhóm này',
                'error' => 'forbidden'
            ], 403);
        }

        $query = GroupInvitation::with(['creator', 'usedBy'])
            ->where('group_id', $groupId);

        // Filter by status if provided
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        // Filter by creator if provided
        if ($request->has('creator_id')) {
            $query->where('creator_id', $request->creator_id);
        }

        $invitations = $query->orderBy('created_at', 'desc')
            ->paginate($request->get('per_page', 15));

        $invitations->through(function ($invitation) {
            return [
                'id' => $invitation->id,
                'token' => $invitation->token,
                'type' => $invitation->type,
                'type_name' => $invitation->type_name,
                'recipient_phone' => $invitation->recipient_phone,
                'status' => $invitation->status,
                'status_name' => $invitation->status_name,
                'expires_at' => $invitation->expires_at,
                'used_at' => $invitation->used_at,
                'creator' => [
                    'id' => $invitation->creator->id,
                    'display_name' => $invitation->creator->display_name,
                ],
                'used_by' => $invitation->usedBy ? [
                    'id' => $invitation->usedBy->id,
                    'display_name' => $invitation->usedBy->display_name,
                ] : null,
                'invitation_url' => $invitation->getInvitationUrl(),
                'created_at' => $invitation->created_at,
            ];
        });

        return response()->json($invitations);
    }

    /**
     * Validate an invitation token
     * GET /api/invitations/{token}/validate
     */
    public function validateInvitation(Request $request, string $token): JsonResponse
    {
        $invitation = GroupInvitation::with(['group', 'creator'])
            ->where('token', $token)
            ->first();

        if (!$invitation) {
            return response()->json([
                'message' => 'Lời mời không tồn tại',
                'error' => 'invitation_not_found'
            ], 404);
        }

        // Track click event
        InvitationAnalytics::track($invitation->id, 'clicked', [
            'source' => $request->header('X-Source', 'web'),
            'user_agent' => $request->header('User-Agent'),
            'ip_address' => $request->ip(),
        ]);

        // Check if invitation is valid
        if (!$invitation->isValid()) {
            $errorMessage = $invitation->isExpired() 
                ? 'Lời mời đã hết hạn' 
                : 'Lời mời không còn hợp lệ';

            return response()->json([
                'message' => $errorMessage,
                'error' => 'invitation_invalid',
                'invitation' => [
                    'status' => $invitation->status,
                    'status_name' => $invitation->status_name,
                    'expires_at' => $invitation->expires_at,
                ]
            ], 422);
        }

        return response()->json([
            'message' => 'Lời mời hợp lệ',
            'invitation' => [
                'id' => $invitation->id,
                'token' => $invitation->token,
                'type' => $invitation->type,
                'type_name' => $invitation->type_name,
                'status' => $invitation->status,
                'status_name' => $invitation->status_name,
                'expires_at' => $invitation->expires_at,
            ],
            'group' => [
                'id' => $invitation->group->id,
                'name' => $invitation->group->name,
                'sport_type' => $invitation->group->sport_type,
                'sport_name' => $invitation->group->sport_name,
                'location' => $invitation->group->location,
                'description' => $invitation->group->description,
                'member_count' => $invitation->group->memberships()->count(),
                'creator' => [
                    'id' => $invitation->creator->id,
                    'display_name' => $invitation->creator->display_name,
                ],
            ]
        ]);
    }

    /**
     * Revoke an invitation
     * DELETE /api/invitations/{token}
     */
    public function revokeInvitation(Request $request, string $token): JsonResponse
    {
        $invitation = GroupInvitation::where('token', $token)->first();

        if (!$invitation) {
            return response()->json([
                'message' => 'Lời mời không tồn tại',
                'error' => 'invitation_not_found'
            ], 404);
        }

        // Check permissions
        $group = $invitation->group;
        if (!$this->canRevokeInvitation(Auth::user(), $invitation, $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền thu hồi lời mời này',
                'error' => 'forbidden'
            ], 403);
        }

        // Revoke invitation
        $invitation->revoke();

        // Track revocation event
        InvitationAnalytics::track($invitation->id, 'revoked', [
            'source' => $request->header('X-Source', 'api'),
            'user_agent' => $request->header('User-Agent'),
            'ip_address' => $request->ip(),
        ]);

        return response()->json([
            'message' => 'Lời mời đã được thu hồi',
            'invitation' => [
                'id' => $invitation->id,
                'status' => $invitation->status,
                'status_name' => $invitation->status_name,
            ]
        ]);
    }

    /**
     * Get group preview for invitation (public endpoint)
     * GET /api/invitations/{token}/preview
     */
    public function getGroupPreview(string $token): JsonResponse
    {
        $invitation = GroupInvitation::with(['group.creator'])
            ->where('token', $token)
            ->first();

        if (!$invitation || !$invitation->isValid()) {
            return response()->json([
                'message' => 'Lời mời không tồn tại hoặc đã hết hạn',
                'error' => 'invitation_invalid'
            ], 404);
        }

        $group = $invitation->group;

        return response()->json([
            'group' => [
                'id' => $group->id,
                'name' => $group->name,
                'sport_type' => $group->sport_type,
                'sport_name' => $group->sport_name,
                'location' => $group->location,
                'description' => $group->description,
                'member_count' => $group->memberships()->count(),
                'creator' => [
                    'display_name' => $group->creator->display_name,
                ],
                'created_at' => $group->created_at,
            ],
            'invitation' => [
                'token' => $invitation->token,
                'expires_at' => $invitation->expires_at,
            ]
        ]);
    }

    /**
     * Check if user can create invitations for a group
     */
    private function canCreateInvitation($user, Group $group): bool
    {
        $membership = $group->memberships()
            ->where('user_id', $user->id)
            ->first();

        return $membership && in_array($membership->role, ['creator', 'admin', 'moderator']);
    }

    /**
     * Check if user can view invitations for a group
     */
    private function canViewInvitations($user, Group $group): bool
    {
        return $this->canCreateInvitation($user, $group);
    }

    /**
     * Check if user can revoke an invitation
     */
    private function canRevokeInvitation($user, GroupInvitation $invitation, Group $group): bool
    {
        // Creator can revoke their own invitations
        if ($invitation->creator_id === $user->id) {
            return true;
        }

        // Group admins can revoke any invitation
        $membership = $group->memberships()
            ->where('user_id', $user->id)
            ->first();

        return $membership && in_array($membership->role, ['creator', 'admin']);
    }

    /**
     * Calculate expiration date based on input
     */
    private function calculateExpiration(?string $expiresIn): ?Carbon
    {
        return match ($expiresIn) {
            '1d' => now()->addDay(),
            '1w' => now()->addWeek(),
            'permanent' => null,
            default => now()->addWeek(), // Default to 1 week
        };
    }
}