<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreGroupRequest;
use App\Http\Requests\UpdateGroupRequest;
use App\Models\Group;
use App\Models\GroupLevelRequirement;
use App\Services\SportsConfigurationService;
use App\SportType;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

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

            // Transform the groups data to match Flutter expectations
            $transformedGroups = $groups->getCollection()->map(function ($group) {
                return [
                    'id' => $group->id,
                    'name' => $group->name,
                    'description' => $group->description,
                    'sport_type' => $group->sport_type,
                    'skill_level' => $group->skill_level,
                    'location' => $group->location,
                    'city' => $group->city,
                    'district' => $group->district,
                    'latitude' => $group->latitude,
                    'longitude' => $group->longitude,
                    'schedule' => $group->schedule,
                    'max_members' => $group->max_members,
                    'current_members' => $group->current_members,
                    'monthly_fee' => $group->monthly_fee,
                    'privacy' => $group->privacy,
                    'status' => $group->status,
                    'avatar' => $group->avatar,
                    'rules' => $group->rules,
                    'creator_id' => $group->creator_id,
                    'created_at' => $group->created_at->toISOString(),
                    'updated_at' => $group->updated_at->toISOString(),
                    'creator' => $group->creator ? [
                        'id' => $group->creator->id,
                        'name' => $group->creator->name,
                        'email' => $group->creator->email,
                        'avatar' => $group->creator->avatar,
                    ] : null,
                    'active_members' => $group->activeMembers->map(function ($user) {
                        return [
                            'id' => $user->id,
                            'name' => $user->name,
                            'email' => $user->email,
                            'avatar' => $user->avatar,
                        ];
                    }),
                ];
            });

            return response()->json([
                'success' => true,
                'data' => [
                    'current_page' => $groups->currentPage(),
                    'data' => $transformedGroups,
                    'first_page_url' => $groups->url(1),
                    'from' => $groups->firstItem(),
                    'last_page' => $groups->lastPage(),
                    'last_page_url' => $groups->url($groups->lastPage()),
                    'links' => $groups->linkCollection(),
                    'next_page_url' => $groups->nextPageUrl(),
                    'path' => $groups->path(),
                    'per_page' => $groups->perPage(),
                    'prev_page_url' => $groups->previousPageUrl(),
                    'to' => $groups->lastItem(),
                    'total' => $groups->total(),
                ]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể lấy danh sách nhóm',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function store(StoreGroupRequest $request): JsonResponse
    {
        try {
            $validated = $request->validated();

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

            // Load the group with relationships
            $group->load(['creator', 'activeMembers', 'levelRequirements']);
            
            return response()->json([
                'success' => true,
                'message' => 'Tạo nhóm thành công',
                'data' => [
                    'id' => $group->id,
                    'name' => $group->name,
                    'description' => $group->description,
                    'sport_type' => $group->sport_type,
                    'skill_level' => $group->skill_level,
                    'location' => $group->location,
                    'city' => $group->city,
                    'district' => $group->district,
                    'latitude' => $group->latitude,
                    'longitude' => $group->longitude,
                    'schedule' => $group->schedule,
                    'max_members' => $group->max_members,
                    'current_members' => $group->current_members,
                    'monthly_fee' => $group->monthly_fee,
                    'privacy' => $group->privacy,
                    'status' => $group->status,
                    'avatar' => $group->avatar,
                    'rules' => $group->rules,
                    'creator_id' => $group->creator_id,
                    'created_at' => $group->created_at->toISOString(),
                    'updated_at' => $group->updated_at->toISOString(),
                    'creator' => $group->creator ? [
                        'id' => $group->creator->id,
                        'name' => $group->creator->name,
                        'email' => $group->creator->email,
                        'avatar' => $group->creator->avatar,
                    ] : null,
                    'active_members' => $group->activeMembers->map(function ($user) {
                        return [
                            'id' => $user->id,
                            'name' => $user->name,
                            'email' => $user->email,
                            'avatar' => $user->avatar,
                        ];
                    }),
                    'level_requirements' => $group->levelRequirements->map(function ($req) {
                        return [
                            'level_key' => $req->level_key,
                            'level_name' => $req->level_name,
                        ];
                    }),
                ]
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

    public function update(UpdateGroupRequest $request, string $id): JsonResponse
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

            $validated = $request->validated();

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
