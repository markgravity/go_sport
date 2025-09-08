<?php

namespace App\Http\Controllers;

use App\Models\Group;
use App\Models\GroupJoinRequest;
use App\Models\GroupInvitation;
use App\Models\InvitationAnalytics;
use App\Notifications\JoinRequestApproved;
use App\Notifications\JoinRequestRejected;
use App\Notifications\NewJoinRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\RateLimiter;

class JoinRequestController extends Controller
{
    /**
     * Create a join request for a group
     * POST /api/join-requests
     */
    public function createJoinRequest(Request $request): JsonResponse
    {
        // Rate limiting
        $key = 'join-request:' . Auth::id();
        if (RateLimiter::tooManyAttempts($key, 5)) {
            return response()->json([
                'message' => 'Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau.',
                'error' => 'too_many_attempts'
            ], 429);
        }

        $validator = Validator::make($request->all(), [
            'group_id' => 'required|exists:groups,id',
            'message' => 'nullable|string|max:500',
            'invitation_token' => 'nullable|string',
            'source' => 'nullable|in:direct,invitation,search',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $validator->errors()
            ], 422);
        }

        $group = Group::findOrFail($request->group_id);
        $user = Auth::user();

        // Check if user is already a member
        $existingMembership = $group->memberships()
            ->where('user_id', $user->id)
            ->first();

        if ($existingMembership) {
            return response()->json([
                'message' => 'Bạn đã là thành viên của nhóm này',
                'error' => 'already_member'
            ], 422);
        }

        // Check for existing pending request
        $existingRequest = GroupJoinRequest::where('group_id', $group->id)
            ->where('user_id', $user->id)
            ->where('status', 'pending')
            ->first();

        if ($existingRequest) {
            return response()->json([
                'message' => 'Bạn đã có yêu cầu đang chờ duyệt cho nhóm này',
                'error' => 'request_exists',
                'request' => [
                    'id' => $existingRequest->id,
                    'created_at' => $existingRequest->created_at,
                ]
            ], 422);
        }

        // Handle invitation if provided
        $invitation = null;
        if ($request->invitation_token) {
            $invitation = GroupInvitation::where('token', $request->invitation_token)
                ->where('group_id', $group->id)
                ->first();

            if ($invitation && $invitation->isValid()) {
                // Direct approval for valid invitation
                return $this->handleInvitationJoin($group, $user, $invitation);
            }
        }

        // Create join request
        try {
            DB::beginTransaction();

            $joinRequest = GroupJoinRequest::create([
                'group_id' => $group->id,
                'user_id' => $user->id,
                'invitation_id' => $invitation?->id,
                'message' => $request->message,
                'source' => $request->source ?? 'direct',
                'status' => 'pending',
                'metadata' => [
                    'user_agent' => $request->header('User-Agent'),
                    'ip' => $request->ip(),
                ],
            ]);

            // Notify group admins
            $this->notifyGroupAdmins($group, $joinRequest);

            RateLimiter::hit($key);
            DB::commit();

            return response()->json([
                'message' => 'Yêu cầu tham gia đã được gửi',
                'request' => [
                    'id' => $joinRequest->id,
                    'status' => $joinRequest->status,
                    'status_name' => $joinRequest->status_name,
                    'created_at' => $joinRequest->created_at,
                ]
            ], 201);

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'message' => 'Có lỗi xảy ra khi gửi yêu cầu',
                'error' => 'server_error'
            ], 500);
        }
    }

    /**
     * Get join requests for a group (for admins)
     * GET /api/groups/{group}/join-requests
     */
    public function getGroupRequests(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);

        // Check if user can manage join requests
        if (!$this->canManageRequests(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền xem yêu cầu tham gia',
                'error' => 'forbidden'
            ], 403);
        }

        $query = GroupJoinRequest::with(['user', 'invitation', 'processedBy'])
            ->where('group_id', $groupId);

        // Filter by status
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        // Sort by created_at
        $query->orderBy('created_at', 'desc');

        $requests = $query->paginate($request->get('per_page', 15));

        $requests->through(function ($joinRequest) {
            return [
                'id' => $joinRequest->id,
                'user' => [
                    'id' => $joinRequest->user->id,
                    'display_name' => $joinRequest->user->display_name,
                    'phone_number' => $joinRequest->user->phone_number,
                    'avatar_url' => $joinRequest->user->avatar_url,
                ],
                'status' => $joinRequest->status,
                'status_name' => $joinRequest->status_name,
                'message' => $joinRequest->message,
                'rejection_reason' => $joinRequest->rejection_reason,
                'source' => $joinRequest->source,
                'source_name' => $joinRequest->source_name,
                'invitation' => $joinRequest->invitation ? [
                    'id' => $joinRequest->invitation->id,
                    'token' => $joinRequest->invitation->token,
                ] : null,
                'processed_by' => $joinRequest->processedBy ? [
                    'id' => $joinRequest->processedBy->id,
                    'display_name' => $joinRequest->processedBy->display_name,
                ] : null,
                'processed_at' => $joinRequest->processed_at,
                'created_at' => $joinRequest->created_at,
            ];
        });

        return response()->json($requests);
    }

    /**
     * Approve a join request
     * POST /api/groups/{group}/join-requests/{request}/approve
     */
    public function approveRequest(Request $request, int $groupId, int $requestId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        $joinRequest = GroupJoinRequest::where('group_id', $groupId)
            ->where('id', $requestId)
            ->firstOrFail();

        // Check permissions
        if (!$this->canManageRequests(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền duyệt yêu cầu tham gia',
                'error' => 'forbidden'
            ], 403);
        }

        if (!$joinRequest->canBeProcessed()) {
            return response()->json([
                'message' => 'Yêu cầu này đã được xử lý',
                'error' => 'already_processed',
                'status' => $joinRequest->status,
            ], 422);
        }

        // Validate role if provided
        $validator = Validator::make($request->all(), [
            'role' => 'nullable|in:member,moderator',
            'notification_message' => 'nullable|string|max:500',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $validator->errors()
            ], 422);
        }

        $role = $request->role ?? 'member';

        // Approve the request
        try {
            DB::beginTransaction();

            // Create membership
            $group->memberships()->create([
                'user_id' => $joinRequest->user_id,
                'role' => $role,
                'joined_at' => now(),
            ]);

            // Update join request
            $joinRequest->update([
                'status' => 'approved',
                'processed_by' => Auth::id(),
                'processed_at' => now(),
            ]);

            // Mark invitation as used if exists
            if ($joinRequest->invitation_id) {
                $invitation = GroupInvitation::find($joinRequest->invitation_id);
                if ($invitation) {
                    $invitation->markAsUsed($joinRequest->user_id);
                    InvitationAnalytics::track($invitation->id, 'used', [
                        'source' => 'join_request',
                    ]);
                }
            }

            // Send notification to user
            $this->notifyUserApproval($joinRequest, $request->notification_message);

            DB::commit();

            return response()->json([
                'message' => 'Yêu cầu đã được duyệt',
                'request' => [
                    'id' => $joinRequest->id,
                    'status' => $joinRequest->status,
                    'status_name' => $joinRequest->status_name,
                    'processed_at' => $joinRequest->processed_at,
                ]
            ]);

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'message' => 'Có lỗi xảy ra khi duyệt yêu cầu',
                'error' => 'server_error'
            ], 500);
        }
    }

    /**
     * Reject a join request
     * POST /api/groups/{group}/join-requests/{request}/reject
     */
    public function rejectRequest(Request $request, int $groupId, int $requestId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        $joinRequest = GroupJoinRequest::where('group_id', $groupId)
            ->where('id', $requestId)
            ->firstOrFail();

        // Check permissions
        if (!$this->canManageRequests(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền từ chối yêu cầu tham gia',
                'error' => 'forbidden'
            ], 403);
        }

        if (!$joinRequest->canBeProcessed()) {
            return response()->json([
                'message' => 'Yêu cầu này đã được xử lý',
                'error' => 'already_processed',
                'status' => $joinRequest->status,
            ], 422);
        }

        $validator = Validator::make($request->all(), [
            'reason' => 'nullable|string|max:500',
            'notify_user' => 'nullable|boolean',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $validator->errors()
            ], 422);
        }

        // Reject the request
        $joinRequest->update([
            'status' => 'rejected',
            'rejection_reason' => $request->reason,
            'processed_by' => Auth::id(),
            'processed_at' => now(),
        ]);

        // Track analytics if from invitation
        if ($joinRequest->invitation_id) {
            InvitationAnalytics::track($joinRequest->invitation_id, 'revoked', [
                'source' => 'join_request_rejected',
            ]);
        }

        // Send notification if requested
        if ($request->notify_user ?? true) {
            $this->notifyUserRejection($joinRequest, $request->reason);
        }

        return response()->json([
            'message' => 'Yêu cầu đã bị từ chối',
            'request' => [
                'id' => $joinRequest->id,
                'status' => $joinRequest->status,
                'status_name' => $joinRequest->status_name,
                'rejection_reason' => $joinRequest->rejection_reason,
                'processed_at' => $joinRequest->processed_at,
            ]
        ]);
    }

    /**
     * Get user's own join requests
     * GET /api/join-requests/my-requests
     */
    public function getMyRequests(Request $request): JsonResponse
    {
        $user = Auth::user();

        $query = GroupJoinRequest::with(['group', 'processedBy'])
            ->where('user_id', $user->id);

        // Filter by status
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        $query->orderBy('created_at', 'desc');

        $requests = $query->paginate($request->get('per_page', 15));

        $requests->through(function ($joinRequest) {
            return [
                'id' => $joinRequest->id,
                'group' => [
                    'id' => $joinRequest->group->id,
                    'name' => $joinRequest->group->name,
                    'sport_type' => $joinRequest->group->sport_type,
                    'sport_name' => $joinRequest->group->sport_name,
                    'location' => $joinRequest->group->location,
                    'avatar_url' => $joinRequest->group->avatar_url,
                ],
                'status' => $joinRequest->status,
                'status_name' => $joinRequest->status_name,
                'message' => $joinRequest->message,
                'rejection_reason' => $joinRequest->rejection_reason,
                'processed_by' => $joinRequest->processedBy ? [
                    'display_name' => $joinRequest->processedBy->display_name,
                ] : null,
                'processed_at' => $joinRequest->processed_at,
                'created_at' => $joinRequest->created_at,
            ];
        });

        return response()->json($requests);
    }

    /**
     * Cancel a pending join request
     * DELETE /api/join-requests/{request}
     */
    public function cancelRequest(int $requestId): JsonResponse
    {
        $joinRequest = GroupJoinRequest::where('id', $requestId)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        if ($joinRequest->status !== 'pending') {
            return response()->json([
                'message' => 'Chỉ có thể hủy yêu cầu đang chờ duyệt',
                'error' => 'cannot_cancel',
                'status' => $joinRequest->status,
            ], 422);
        }

        $joinRequest->delete();

        return response()->json([
            'message' => 'Yêu cầu tham gia đã được hủy',
        ]);
    }

    /**
     * Handle direct join via invitation
     */
    private function handleInvitationJoin(Group $group, $user, GroupInvitation $invitation): JsonResponse
    {
        try {
            DB::beginTransaction();

            // Create membership
            $group->memberships()->create([
                'user_id' => $user->id,
                'role' => 'member',
                'joined_at' => now(),
            ]);

            // Mark invitation as used
            $invitation->markAsUsed($user->id);

            // Track analytics
            InvitationAnalytics::track($invitation->id, 'used', [
                'source' => 'direct_join',
                'user_agent' => request()->header('User-Agent'),
                'ip_address' => request()->ip(),
            ]);

            DB::commit();

            return response()->json([
                'message' => 'Bạn đã tham gia nhóm thành công!',
                'group' => [
                    'id' => $group->id,
                    'name' => $group->name,
                ],
                'membership' => [
                    'role' => 'member',
                    'joined_at' => now(),
                ],
            ], 201);

        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'message' => 'Có lỗi xảy ra khi tham gia nhóm',
                'error' => 'server_error'
            ], 500);
        }
    }

    /**
     * Check if user can manage join requests
     */
    private function canManageRequests($user, Group $group): bool
    {
        $membership = $group->memberships()
            ->where('user_id', $user->id)
            ->first();

        return $membership && in_array($membership->role, ['creator', 'admin', 'moderator']);
    }

    /**
     * Notify group admins about new join request
     */
    private function notifyGroupAdmins(Group $group, GroupJoinRequest $joinRequest): void
    {
        // Get admins and moderators
        $admins = $group->memberships()
            ->whereIn('role', ['creator', 'admin', 'moderator'])
            ->with('user')
            ->get();

        foreach ($admins as $admin) {
            // Send notification (implement notification system)
            // $admin->user->notify(new NewJoinRequest($joinRequest));
        }
    }

    /**
     * Notify user about approval
     */
    private function notifyUserApproval(GroupJoinRequest $joinRequest, ?string $message = null): void
    {
        // Send notification to user
        // $joinRequest->user->notify(new JoinRequestApproved($joinRequest, $message));
    }

    /**
     * Notify user about rejection
     */
    private function notifyUserRejection(GroupJoinRequest $joinRequest, ?string $reason = null): void
    {
        // Send notification to user
        // $joinRequest->user->notify(new JoinRequestRejected($joinRequest, $reason));
    }
}