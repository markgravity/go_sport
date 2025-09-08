<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Group;
use App\Models\GroupJoinRequest;
use App\Models\GroupInvitation;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

class GroupJoinRequestController extends Controller
{
    /**
     * Get join requests for a specific group (for group admins/moderators)
     */
    public function index(Request $request, string $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        
        if (!$group->isAdmin(Auth::user()) && !$group->isModerator(Auth::user())) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền xem danh sách yêu cầu tham gia nhóm này',
            ], 403);
        }

        $requests = $group->joinRequests()
            ->with(['user', 'invitation', 'processedBy'])
            ->when($request->status, function ($query, $status) {
                return $query->where('status', $status);
            })
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $requests,
        ]);
    }

    /**
     * Create a join request
     */
    public function store(Request $request): JsonResponse
    {
        $validatedData = $request->validate([
            'group_id' => ['required', 'exists:groups,id'],
            'invitation_id' => ['nullable', 'exists:group_invitations,id'],
            'message' => ['nullable', 'string', 'max:500'],
            'source' => ['nullable', Rule::in(['direct', 'invitation', 'search'])],
        ]);

        $user = Auth::user();
        $group = Group::findOrFail($validatedData['group_id']);

        // Check if group allows join requests
        if ($group->join_policy === 'closed') {
            return response()->json([
                'success' => false,
                'message' => 'Nhóm này không cho phép yêu cầu tham gia',
            ], 403);
        }

        // Check if user is already a member
        if ($group->memberships()->where('user_id', $user->id)->exists()) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn đã là thành viên của nhóm này',
            ], 422);
        }

        // Check if user already has a pending request
        $existingRequest = GroupJoinRequest::where('group_id', $group->id)
            ->where('user_id', $user->id)
            ->where('status', 'pending')
            ->first();

        if ($existingRequest) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn đã có một yêu cầu tham gia đang chờ duyệt cho nhóm này',
            ], 422);
        }

        // Check group capacity
        if ($group->max_members && $group->current_members >= $group->max_members) {
            return response()->json([
                'success' => false,
                'message' => 'Nhóm đã đầy thành viên',
            ], 422);
        }

        // Validate invitation if provided
        if (isset($validatedData['invitation_id'])) {
            $invitation = GroupInvitation::find($validatedData['invitation_id']);
            if (!$invitation || !$invitation->isValid() || $invitation->group_id !== $group->id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Lời mời không hợp lệ hoặc đã hết hạn',
                ], 422);
            }
        }

        // Create join request
        $joinRequest = GroupJoinRequest::create([
            'group_id' => $group->id,
            'user_id' => $user->id,
            'invitation_id' => $validatedData['invitation_id'] ?? null,
            'message' => $validatedData['message'] ?? null,
            'source' => $validatedData['source'] ?? 'direct',
            'status' => 'pending',
        ]);

        // Auto-approve if group allows and from valid invitation
        if ($group->join_policy === 'open' || 
            ($group->join_policy === 'invitation' && isset($validatedData['invitation_id']))) {
            $joinRequest->approve($user);
            
            return response()->json([
                'success' => true,
                'message' => 'Bạn đã tham gia nhóm thành công',
                'data' => $joinRequest->load(['user', 'group']),
            ]);
        }

        return response()->json([
            'success' => true,
            'message' => 'Yêu cầu tham gia đã được gửi và đang chờ duyệt',
            'data' => $joinRequest->load(['user', 'group']),
        ]);
    }

    /**
     * Approve a join request
     */
    public function approve(Request $request, string $id): JsonResponse
    {
        $joinRequest = GroupJoinRequest::findOrFail($id);
        $user = Auth::user();

        if (!$joinRequest->group->isAdmin($user) && !$joinRequest->group->isModerator($user)) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền duyệt yêu cầu tham gia nhóm này',
            ], 403);
        }

        if (!$joinRequest->canBeProcessed()) {
            return response()->json([
                'success' => false,
                'message' => 'Yêu cầu này không thể được xử lý',
            ], 422);
        }

        $validatedData = $request->validate([
            'role' => ['nullable', Rule::in(['member', 'moderator'])],
        ]);

        $role = $validatedData['role'] ?? 'member';
        
        if ($joinRequest->approve($user, $role)) {
            return response()->json([
                'success' => true,
                'message' => 'Yêu cầu tham gia đã được duyệt thành công',
                'data' => $joinRequest->fresh()->load(['user', 'group', 'processedBy']),
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Không thể duyệt yêu cầu tham gia',
        ], 500);
    }

    /**
     * Reject a join request
     */
    public function reject(Request $request, string $id): JsonResponse
    {
        $joinRequest = GroupJoinRequest::findOrFail($id);
        $user = Auth::user();

        if (!$joinRequest->group->isAdmin($user) && !$joinRequest->group->isModerator($user)) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền từ chối yêu cầu tham gia nhóm này',
            ], 403);
        }

        if (!$joinRequest->canBeProcessed()) {
            return response()->json([
                'success' => false,
                'message' => 'Yêu cầu này không thể được xử lý',
            ], 422);
        }

        $validatedData = $request->validate([
            'reason' => ['nullable', 'string', 'max:500'],
        ]);

        if ($joinRequest->reject($user, $validatedData['reason'] ?? null)) {
            return response()->json([
                'success' => true,
                'message' => 'Yêu cầu tham gia đã được từ chối',
                'data' => $joinRequest->fresh()->load(['user', 'group', 'processedBy']),
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Không thể từ chối yêu cầu tham gia',
        ], 500);
    }

    /**
     * Get user's own join requests
     */
    public function myRequests(Request $request): JsonResponse
    {
        $user = Auth::user();

        $requests = GroupJoinRequest::where('user_id', $user->id)
            ->with(['group', 'invitation', 'processedBy'])
            ->when($request->status, function ($query, $status) {
                return $query->where('status', $status);
            })
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $requests,
        ]);
    }

    /**
     * Cancel a pending join request
     */
    public function destroy(string $id): JsonResponse
    {
        $joinRequest = GroupJoinRequest::findOrFail($id);
        $user = Auth::user();

        if ($joinRequest->user_id !== $user->id) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền hủy yêu cầu này',
            ], 403);
        }

        if ($joinRequest->status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Chỉ có thể hủy yêu cầu đang chờ duyệt',
            ], 422);
        }

        $joinRequest->delete();

        return response()->json([
            'success' => true,
            'message' => 'Yêu cầu tham gia đã được hủy',
        ]);
    }
}
