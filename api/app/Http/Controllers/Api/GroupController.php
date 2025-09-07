<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Group;
use App\Models\GroupLevelRequirement;
use App\Models\User;
use App\Services\SportsConfigurationService;
use App\SportType;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class GroupController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        try {
            $user = Auth::user();
            $query = Group::query();

            // Filter by sport type
            if ($request->has('sport_type')) {
                $query->where('sport_type', $request->sport_type);
            }

            // Filter by city
            if ($request->has('city')) {
                $query->where('city', $request->city);
            }

            // Filter by privacy
            if ($request->has('privacy')) {
                $query->where('privacy', $request->privacy);
            } else {
                // Default to public groups only
                $query->where('privacy', 'cong_khai');
            }

            // Filter by status
            $query->where('status', 'hoat_dong');

            // Search by name
            if ($request->has('search')) {
                $query->where('name', 'like', '%' . $request->search . '%');
            }

            // Order by creation date
            $query->orderBy('created_at', 'desc');

            $groups = $query->with(['creator', 'activeMembers'])
                           ->paginate($request->get('per_page', 15));

            return response()->json([
                'success' => true,
                'data' => $groups
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy danh sách nhóm',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:255',
                'description' => 'nullable|string|max:1000',
                'sport_type' => [
                    'required',
                    Rule::in(['football', 'badminton', 'tennis', 'pickleball'])
                ],
                'location' => 'required|string|max:500',
                'city' => 'required|string|max:100',
                'district' => 'nullable|string|max:100',
                'latitude' => 'nullable|numeric|between:-90,90',
                'longitude' => 'nullable|numeric|between:-180,180',
                'schedule' => 'nullable|array',
                'monthly_fee' => 'nullable|numeric|min:0|max:10000000',
                'privacy' => [
                    'required',
                    Rule::in(['cong_khai', 'rieng_tu'])
                ],
                'avatar' => 'nullable|string|max:255',
                'rules' => 'nullable|array',
                'level_requirements' => 'nullable|array',
                'level_requirements.*.level_key' => [
                    'required_with:level_requirements',
                    Rule::in(['moi_bat_dau', 'so_cap', 'trung_cap', 'cao_cap', 'chuyen_nghiep'])
                ],
                'level_requirements.*.level_name' => 'required_with:level_requirements|string|max:255'
            ]);

            DB::beginTransaction();

            // Create the group
            $group = Group::create([
                'name' => $validated['name'],
                'description' => $validated['description'] ?? null,
                'sport_type' => $validated['sport_type'],
                'location' => $validated['location'],
                'city' => $validated['city'],
                'district' => $validated['district'] ?? null,
                'latitude' => $validated['latitude'] ?? null,
                'longitude' => $validated['longitude'] ?? null,
                'schedule' => $validated['schedule'] ?? null,
                'current_members' => 1, // Creator counts as first member
                'monthly_fee' => $validated['monthly_fee'] ?? 0,
                'privacy' => $validated['privacy'],
                'status' => 'hoat_dong',
                'avatar' => $validated['avatar'] ?? null,
                'rules' => $validated['rules'] ?? null,
                'creator_id' => Auth::id()
            ]);

            // Add level requirements if provided
            if (isset($validated['level_requirements']) && is_array($validated['level_requirements'])) {
                foreach ($validated['level_requirements'] as $requirement) {
                    // Validate that the level is valid for this sport
                    if (GroupLevelRequirement::isValidLevelForSport($validated['sport_type'], $requirement['level_key'])) {
                        $group->addLevelRequirement(
                            $requirement['level_key'],
                            $requirement['level_name'],
                            $requirement['level_description'] ?? null
                        );
                    }
                }
            }

            // Add creator as admin member automatically
            $group->assignCreatorAsAdmin();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Tạo nhóm thành công',
                'data' => $group->load(['creator', 'activeMembers', 'levelRequirements'])
            ], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Không thể tạo nhóm',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function show(string $id): JsonResponse
    {
        try {
            $group = Group::with(['creator', 'activeMembers', 'pendingMembers', 'levelRequirements'])
                          ->findOrFail($id);

            $user = Auth::user();
            $isMember = $group->isMember($user);
            $isAdmin = $group->isAdmin($user);
            $canManage = $group->canManage($user);

            return response()->json([
                'success' => true,
                'data' => array_merge($group->toArray(), [
                    'user_membership' => [
                        'is_member' => $isMember,
                        'is_admin' => $isAdmin,
                        'can_manage' => $canManage
                    ]
                ])
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không tìm thấy nhóm'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy thông tin nhóm',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request, string $id): JsonResponse
    {
        try {
            $group = Group::findOrFail($id);
            $user = Auth::user();

            if (!$group->canManage($user)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không có quyền chỉnh sửa nhóm này'
                ], 403);
            }

            $validated = $request->validate([
                'name' => 'sometimes|string|max:255',
                'description' => 'sometimes|nullable|string|max:1000',
                'skill_level' => [
                    'sometimes',
                    Rule::in(['moi_bat_dau', 'trung_binh', 'gioi', 'chuyen_nghiep'])
                ],
                'location' => 'sometimes|string|max:500',
                'city' => 'sometimes|string|max:100',
                'district' => 'sometimes|nullable|string|max:100',
                'latitude' => 'sometimes|nullable|numeric|between:-90,90',
                'longitude' => 'sometimes|nullable|numeric|between:-180,180',
                'schedule' => 'sometimes|nullable|array',
                'max_members' => 'sometimes|integer|min:1|max:100',
                'membership_fee' => 'sometimes|numeric|min:0|max:10000000',
                'privacy' => [
                    'sometimes',
                    Rule::in(['cong_khai', 'rieng_tu'])
                ],
                'status' => [
                    'sometimes',
                    Rule::in(['hoat_dong', 'tam_dung', 'dong_cua'])
                ],
                'avatar' => 'sometimes|nullable|string|max:255',
                'rules' => 'sometimes|nullable|array'
            ]);

            $group->update($validated);

            return response()->json([
                'success' => true,
                'message' => 'Cập nhật nhóm thành công',
                'data' => $group->load(['creator', 'activeMembers'])
            ]);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không tìm thấy nhóm'
            ], 404);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể cập nhật nhóm',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function destroy(string $id): JsonResponse
    {
        try {
            $group = Group::findOrFail($id);
            $user = Auth::user();

            if ($user->id !== $group->creator_id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Chỉ người tạo nhóm mới có thể xóa nhóm'
                ], 403);
            }

            $group->delete();

            return response()->json([
                'success' => true,
                'message' => 'Xóa nhóm thành công'
            ]);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không tìm thấy nhóm'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể xóa nhóm',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function join(Request $request, string $id): JsonResponse
    {
        try {
            $group = Group::findOrFail($id);
            $user = Auth::user();

            if ($group->isMember($user)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn đã là thành viên của nhóm này'
                ], 400);
            }

            if ($group->current_members >= $group->max_members) {
                return response()->json([
                    'success' => false,
                    'message' => 'Nhóm đã đủ số lượng thành viên'
                ], 400);
            }

            $validated = $request->validate([
                'join_reason' => 'nullable|string|max:500'
            ]);

            DB::beginTransaction();

            $role = $group->privacy === 'rieng_tu' ? 'pending' : 'member';
            $status = $group->privacy === 'rieng_tu' ? 'pending' : 'hoat_dong';

            $group->memberships()->attach($user->id, [
                'role' => $role,
                'status' => $status,
                'joined_at' => $status === 'hoat_dong' ? now() : null,
                'join_reason' => $validated['join_reason'] ?? null
            ]);

            if ($status === 'hoat_dong') {
                $group->increment('current_members');
            }

            DB::commit();

            $message = $status === 'hoat_dong' 
                ? 'Tham gia nhóm thành công' 
                : 'Yêu cầu tham gia đã được gửi, chờ phê duyệt';

            return response()->json([
                'success' => true,
                'message' => $message,
                'data' => [
                    'status' => $status,
                    'role' => $role
                ]
            ]);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không tìm thấy nhóm'
            ], 404);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Không thể tham gia nhóm',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function leave(string $id): JsonResponse
    {
        try {
            $group = Group::findOrFail($id);
            $user = Auth::user();

            if (!$group->isMember($user)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không phải là thành viên của nhóm này'
                ], 400);
            }

            if ($user->id === $group->creator_id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Người tạo nhóm không thể rời nhóm. Vui lòng chuyển quyền quản lý trước.'
                ], 400);
            }

            DB::beginTransaction();

            $group->memberships()->updateExistingPivot($user->id, [
                'status' => 'roi_nhom',
                'left_at' => now()
            ]);

            $group->decrement('current_members');

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Rời nhóm thành công'
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Không thể rời nhóm',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function members(string $id): JsonResponse
    {
        try {
            $group = Group::findOrFail($id);
            $user = Auth::user();

            if (!$group->isMember($user) && $group->privacy === 'rieng_tu') {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không có quyền xem danh sách thành viên'
                ], 403);
            }

            $members = $group->activeMembers()
                           ->withPivot(['role', 'joined_at', 'total_paid', 'attendance_count'])
                           ->get();

            return response()->json([
                'success' => true,
                'data' => $members
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy danh sách thành viên',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update member role
     */
    public function updateMemberRole(Request $request, string $groupId, string $userId): JsonResponse
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
                return response()->json([
                    'success' => false,
                    'message' => 'Người dùng không phải là thành viên của nhóm'
                ], 400);
            }

            // Can't change creator's role
            if ($targetUser->id === $group->creator_id && $validated['role'] !== 'admin') {
                return response()->json([
                    'success' => false,
                    'message' => 'Không thể thay đổi vai trò của người tạo nhóm'
                ], 400);
            }

            $newRole = \App\Enums\GroupRole::from($validated['role']);
            
            if ($group->changeUserRole($targetUser, $newRole, $currentUser)) {
                return response()->json([
                    'success' => true,
                    'message' => sprintf(
                        'Đã thay đổi vai trò của %s thành %s',
                        $targetUser->name,
                        $newRole->vietnamese()
                    ),
                    'data' => [
                        'user_id' => $targetUser->id,
                        'new_role' => $validated['role'],
                        'new_role_name' => $newRole->vietnamese()
                    ]
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Không thể thay đổi vai trò thành viên'
                ], 400);
            }

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không tìm thấy thông tin người dùng'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể thay đổi vai trò thành viên',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove member from group
     */
    public function removeMember(Request $request, string $groupId, string $userId): JsonResponse
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
     * Get user permissions in group
     */
    public function getUserPermissions(Request $request, string $groupId): JsonResponse
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

    /**
     * Get available sport level options for group creation
     */
    public function getSportLevels(string $sportType): JsonResponse
    {
        try {
            $levels = GroupLevelRequirement::getSportLevels($sportType);
            
            if (empty($levels)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Môn thể thao không được hỗ trợ'
                ], 400);
            }

            // Convert to array of objects for easier use in frontend
            $levelOptions = [];
            foreach ($levels as $key => $name) {
                $levelOptions[] = [
                    'level_key' => $key,
                    'level_name' => $name,
                    'sport_type' => $sportType
                ];
            }

            return response()->json([
                'success' => true,
                'data' => [
                    'sport_type' => $sportType,
                    'levels' => $levelOptions
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy thông tin cấp độ',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
