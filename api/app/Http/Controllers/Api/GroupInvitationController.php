<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Group;
use App\Models\GroupInvitation;
use App\Models\InvitationAnalytics;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class GroupInvitationController extends Controller
{
    /**
     * Display invitations for a specific group
     */
    public function index(Request $request, int $groupId): JsonResponse
    {
        try {
            $group = Group::findOrFail($groupId);
            $user = $request->user();

            // Check if user can manage this group
            if (!$this->canManageGroup($user, $group)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không có quyền xem lời mời của nhóm này',
                ], 403);
            }

            $invitations = $group->invitations()
                ->with(['creator', 'usedBy', 'analytics'])
                ->orderBy('created_at', 'desc')
                ->paginate(20);

            // Add analytics summary to each invitation
            $invitations->getCollection()->transform(function ($invitation) {
                $invitation->analytics_summary = InvitationAnalytics::getSummary($invitation->id);
                return $invitation;
            });

            return response()->json([
                'success' => true,
                'data' => $invitations,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể tải danh sách lời mời: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Create a new invitation for a group
     */
    public function store(Request $request, int $groupId): JsonResponse
    {
        try {
            $group = Group::findOrFail($groupId);
            $user = $request->user();

            // Check if user can manage this group
            if (!$this->canManageGroup($user, $group)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không có quyền tạo lời mời cho nhóm này',
                ], 403);
            }

            // Rate limiting: max 10 active invitations per group
            $activeInvitationsCount = $group->activeInvitations()->count();
            if ($activeInvitationsCount >= 10) {
                return response()->json([
                    'success' => false,
                    'message' => 'Nhóm đã đạt giới hạn 10 lời mời đang hoạt động',
                ], 422);
            }

            $validatedData = $request->validate([
                'type' => ['nullable', Rule::in(['link'])], // Only link invitations supported
                'expires_in_days' => ['nullable', 'integer', 'min:1', 'max:365'],
                'metadata' => ['nullable', 'array'],
            ]);

            // Create invitation (always link type)
            $invitation = $group->invitations()->create([
                'created_by' => $user->id,
                'type' => 'link',
                'expires_at' => $validatedData['expires_in_days'] ? 
                    now()->addDays($validatedData['expires_in_days']) : null,
                'metadata' => $validatedData['metadata'] ?? null,
            ]);

            // Track analytics
            InvitationAnalytics::track($invitation->id, 'sent', [
                'user_agent' => $request->userAgent(),
                'ip_address' => $request->ip(),
            ]);

            // Load relationships
            $invitation->load(['creator', 'group']);
            $invitation->invitation_url = $invitation->getInvitationUrl();

            return response()->json([
                'success' => true,
                'data' => $invitation,
                'message' => 'Tạo lời mời thành công',
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể tạo lời mời: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Display a specific invitation
     */
    public function show(Request $request, int $groupId, int $invitationId): JsonResponse
    {
        try {
            $group = Group::findOrFail($groupId);
            $user = $request->user();

            // Check if user can manage this group
            if (!$this->canManageGroup($user, $group)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không có quyền xem lời mời này',
                ], 403);
            }

            $invitation = $group->invitations()
                ->with(['creator', 'usedBy'])
                ->findOrFail($invitationId);

            // Add analytics summary
            $invitation->analytics_summary = InvitationAnalytics::getSummary($invitation->id);
            $invitation->invitation_url = $invitation->getInvitationUrl();

            return response()->json([
                'success' => true,
                'data' => $invitation,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể tải lời mời: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Revoke an invitation
     */
    public function destroy(Request $request, int $groupId, int $invitationId): JsonResponse
    {
        try {
            $group = Group::findOrFail($groupId);
            $user = $request->user();

            // Check if user can manage this group
            if (!$this->canManageGroup($user, $group)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không có quyền thu hồi lời mời này',
                ], 403);
            }

            $invitation = $group->invitations()->findOrFail($invitationId);

            // Only allow revoking pending invitations
            if ($invitation->status !== 'pending') {
                return response()->json([
                    'success' => false,
                    'message' => 'Chỉ có thể thu hồi lời mời đang chờ',
                ], 422);
            }

            // Revoke the invitation
            $invitation->revoke();

            return response()->json([
                'success' => true,
                'message' => 'Thu hồi lời mời thành công',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể thu hồi lời mời: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Validate an invitation token (public endpoint)
     */
    public function validateToken(string $token): JsonResponse
    {
        try {
            $invitation = GroupInvitation::where('token', $token)
                ->with(['group', 'creator'])
                ->first();

            if (!$invitation) {
                return response()->json([
                    'success' => false,
                    'message' => 'Lời mời không tồn tại',
                ], 404);
            }

            // Track click analytics
            InvitationAnalytics::track($invitation->id, 'clicked', [
                'user_agent' => request()->userAgent(),
                'ip_address' => request()->ip(),
                'referrer' => request()->headers->get('referer'),
            ]);

            // Check if invitation is valid
            if (!$invitation->isValid()) {
                $message = $invitation->isExpired() ? 'Lời mời đã hết hạn' : 'Lời mời không hợp lệ';
                return response()->json([
                    'success' => false,
                    'message' => $message,
                    'expired' => $invitation->isExpired(),
                ], 422);
            }

            // Return group preview data
            $group = $invitation->group;
            $groupData = [
                'id' => $group->id,
                'name' => $group->name,
                'sport_type' => $group->sport_type,
                'sport_name' => $group->sport_name,
                'location' => $group->location,
                'city' => $group->city,
                'current_members' => $group->current_members,
                'max_members' => $group->max_members ?? 50,
                'monthly_fee' => $group->monthly_fee,
                'privacy' => $group->privacy,
                'creator' => [
                    'id' => $group->creator->id ?? null,
                    'name' => $group->creator->name ?? 'Ẩn danh',
                ],
                'avatar' => $group->avatar,
            ];

            return response()->json([
                'success' => true,
                'data' => [
                    'invitation' => [
                        'id' => $invitation->id,
                        'type' => $invitation->type,
                        'created_at' => $invitation->created_at,
                        'expires_at' => $invitation->expires_at,
                    ],
                    'group' => $groupData,
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể xác thực lời mời: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Get group preview for invitation (public endpoint)
     */
    public function getGroupPreview(string $token): JsonResponse
    {
        return $this->validateToken($token);
    }

    /**
     * Check if user can manage the group (admin, moderator, or creator)
     */
    private function canManageGroup(User $user, Group $group): bool
    {
        return $user->id === $group->creator_id || $group->canManage($user);
    }
}
