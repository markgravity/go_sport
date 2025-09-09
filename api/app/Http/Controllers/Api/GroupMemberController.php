<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Group;
use App\Models\User;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class GroupMemberController extends Controller
{
    use ApiResponseTrait;
    /**
     * Get group members
     */
    public function index(string $id): JsonResponse
    {
        try {
            $group = Group::findOrFail($id);
            $user = Auth::user();

            if (!$group->isMember($user) && $group->privacy === 'rieng_tu') {
                return $this->forbiddenResponse('Bạn không có quyền xem danh sách thành viên');
            }

            $members = $group->activeMembers()
                           ->withPivot(['role', 'joined_at', 'total_paid', 'attendance_count'])
                           ->get();

            return $this->successResponse($members);

        } catch (\Exception $e) {
            return $this->serverErrorResponse('Không thể lấy danh sách thành viên', $e);
        }
    }

    /**
     * Update member role
     */
    public function updateRole(Request $request, string $groupId, string $userId): JsonResponse
    {
        try {
            // The middleware has already verified permissions and added group to request
            $group = $request->group;
            
            $validated = $request->validate([
                'role' => 'required|in:admin,moderator,member,guest'
            ]);

            $targetUser = User::findOrFail($userId);
            $currentUser = Auth::user();

            // Check if target user is a member
            if (!$group->isMember($targetUser)) {
                return $this->errorResponse('Người dùng không phải là thành viên của nhóm');
            }

            // Can't change creator's role
            if ($targetUser->id === $group->creator_id && $validated['role'] !== 'admin') {
                return $this->errorResponse('Không thể thay đổi vai trò của người tạo nhóm');
            }

            $newRole = \App\Enums\GroupRole::from($validated['role']);
            
            if ($group->changeUserRole($targetUser, $newRole, $currentUser)) {
                $message = sprintf(
                    'Đã thay đổi vai trò của %s thành %s',
                    $targetUser->name,
                    $newRole->vietnamese()
                );
                $data = [
                    'user_id' => $targetUser->id,
                    'new_role' => $validated['role'],
                    'new_role_name' => $newRole->vietnamese()
                ];
                return $this->successResponse($data, $message);
            } else {
                return $this->errorResponse('Không thể thay đổi vai trò thành viên');
            }

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return $this->notFoundResponse('Không tìm thấy thông tin người dùng');
        } catch (\Exception $e) {
            return $this->serverErrorResponse('Không thể thay đổi vai trò thành viên', $e);
        }
    }

    /**
     * Remove member from group
     */
    public function destroy(Request $request, string $groupId, string $userId): JsonResponse
    {
        try {
            // The middleware has already verified permissions
            $group = $request->group;
            $targetUser = User::findOrFail($userId);
            $currentUser = Auth::user();

            if (!$group->isMember($targetUser)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Người dùng không phải là thành viên của nhóm'
                ], 400);
            }

            // Can't remove creator
            if ($targetUser->id === $group->creator_id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Không thể loại bỏ người tạo nhóm'
                ], 400);
            }

            // Can't remove yourself unless you're leaving
            if ($targetUser->id === $currentUser->id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Vui lòng sử dụng chức năng rời nhóm để tự rời khỏi nhóm'
                ], 400);
            }

            DB::beginTransaction();

            $group->memberships()->updateExistingPivot($targetUser->id, [
                'status' => 'bi_loai',
                'left_at' => now(),
                'member_notes' => ($group->memberships()->where('user_id', $targetUser->id)->first()->pivot->member_notes ?? '') . 
                    sprintf("\n[%s] Bị loại bỏ khỏi nhóm bởi %s", now()->format('Y-m-d H:i:s'), $currentUser->name)
            ]);

            $group->decrement('current_members');

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => sprintf('Đã loại bỏ %s khỏi nhóm', $targetUser->name)
            ]);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không tìm thấy thông tin người dùng'
            ], 404);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Không thể loại bỏ thành viên',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Add member directly by phone number (for moderators)
     */
    public function addByPhone(Request $request, string $groupId): JsonResponse
    {
        try {
            $group = Group::findOrFail($groupId);
            $currentUser = Auth::user();

            // Check if user can manage this group
            if (!$group->canManage($currentUser)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không có quyền thêm thành viên vào nhóm này',
                ], 403);
            }

            // Validate request
            $validatedData = $request->validate([
                'phone' => ['required', 'string', 'max:20'],
                'role' => ['nullable', Rule::in(['member', 'moderator'])],
            ]);

            $phone = $validatedData['phone'];
            $role = $validatedData['role'] ?? 'member';

            // Find user by phone number
            $targetUser = User::findByPhone($phone);
            
            if (!$targetUser) {
                return response()->json([
                    'success' => false,
                    'message' => 'Không tìm thấy người dùng với số điện thoại này',
                ], 404);
            }

            // Check if user is already a member
            if ($group->isMember($targetUser)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Người dùng đã là thành viên của nhóm',
                ], 400);
            }

            // Check group capacity
            if ($group->current_members >= ($group->max_members ?? 50)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Nhóm đã đạt số lượng thành viên tối đa',
                ], 400);
            }

            DB::beginTransaction();

            // Add user to group
            $group->memberships()->attach($targetUser->id, [
                'role' => $role,
                'status' => 'hoat_dong',
                'joined_at' => now(),
                'join_reason' => 'Được thêm bởi ' . $currentUser->name,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Increment member count
            $group->increment('current_members');

            DB::commit();

            // Load the user data for response
            $targetUser->pivot = (object)[
                'role' => $role,
                'status' => 'hoat_dong',
                'joined_at' => now(),
            ];

            return response()->json([
                'success' => true,
                'data' => [
                    'user' => [
                        'id' => $targetUser->id,
                        'name' => $targetUser->name,
                        'phone' => $targetUser->phone,
                        'role' => $role,
                    ],
                    'group' => [
                        'id' => $group->id,
                        'name' => $group->name,
                        'current_members' => $group->current_members,
                    ]
                ],
                'message' => "Đã thêm {$targetUser->name} vào nhóm với vai trò " . 
                            ($role === 'member' ? 'Thành viên' : 'Điều hành viên'),
            ], 201);
            
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $e->errors(),
            ], 422);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'success' => false,
                'message' => 'Không thể thêm thành viên: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Get user permissions in group
     */
    public function permissions(Request $request, string $groupId): JsonResponse
    {
        try {
            $group = Group::findOrFail($groupId);
            $user = Auth::user();

            $role = $group->getUserRole($user);
            $permissions = $group->getUserPermissions($user);

            return response()->json([
                'success' => true,
                'data' => [
                    'role' => $role?->value,
                    'role_name' => $role?->vietnamese(),
                    'permissions' => array_map(fn($p) => [
                        'value' => $p->value,
                        'label' => $p->label(),
                        'description' => $p->description()
                    ], $permissions)
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy thông tin quyền',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}