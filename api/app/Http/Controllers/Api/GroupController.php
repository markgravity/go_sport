<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Group;
use App\Models\User;
use App\Services\SportsConfigService;
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
                    Rule::in(['bong_da', 'bong_ro', 'cau_long', 'tennis', 'bong_chuyen', 'bong_ban', 'chay_bo', 'dap_xe', 'boi_loi', 'yoga', 'gym', 'khac'])
                ],
                'skill_level' => [
                    'required',
                    Rule::in(['moi_bat_dau', 'trung_binh', 'gioi', 'chuyen_nghiep'])
                ],
                'location' => 'required|string|max:500',
                'city' => 'required|string|max:100',
                'district' => 'nullable|string|max:100',
                'latitude' => 'nullable|numeric|between:-90,90',
                'longitude' => 'nullable|numeric|between:-180,180',
                'schedule' => 'nullable|array',
                'max_members' => 'nullable|integer|min:1|max:100',
                'membership_fee' => 'nullable|numeric|min:0|max:10000000',
                'privacy' => [
                    'required',
                    Rule::in(['cong_khai', 'rieng_tu'])
                ],
                'avatar' => 'nullable|string|max:255',
                'rules' => 'nullable|array'
            ]);

            // Get sport defaults for validation and fallbacks
            $sportDefaults = SportsConfigService::getSportDefaults($validated['sport_type']);
            
            // Apply sport-specific defaults if not provided
            if (!isset($validated['max_members'])) {
                $validated['max_members'] = $sportDefaults['max_members'] ?? 20;
            }

            DB::beginTransaction();

            $group = Group::create([
                'name' => $validated['name'],
                'description' => $validated['description'] ?? null,
                'sport_type' => $validated['sport_type'],
                'skill_level' => $validated['skill_level'],
                'location' => $validated['location'],
                'city' => $validated['city'],
                'district' => $validated['district'] ?? null,
                'latitude' => $validated['latitude'] ?? null,
                'longitude' => $validated['longitude'] ?? null,
                'schedule' => $validated['schedule'] ?? null,
                'max_members' => $validated['max_members'],
                'current_members' => 1, // Creator counts as first member
                'membership_fee' => $validated['membership_fee'] ?? 0,
                'privacy' => $validated['privacy'],
                'status' => 'hoat_dong',
                'avatar' => $validated['avatar'] ?? null,
                'rules' => $validated['rules'] ?? null,
                'creator_id' => Auth::id()
            ]);

            // Add creator as admin member
            $group->memberships()->attach(Auth::id(), [
                'role' => 'admin',
                'status' => 'hoat_dong',
                'joined_at' => now(),
                'join_reason' => 'Người tạo nhóm'
            ]);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Tạo nhóm thành công',
                'data' => $group->load(['creator', 'activeMembers'])
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
            $group = Group::with(['creator', 'activeMembers', 'pendingMembers'])
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
}
