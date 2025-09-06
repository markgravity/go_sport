<?php

namespace App\Http\Middleware;

use App\Enums\GroupPermission as Permission;
use App\Models\Group;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class GroupPermission
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     * @param  string  $permission The required permission
     */
    public function handle(Request $request, Closure $next, string $permission): Response
    {
        $user = Auth::user();
        
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Vui lòng đăng nhập để tiếp tục'
            ], 401);
        }

        // Get group ID from route parameters
        $groupId = $request->route('group') ?? $request->route('id');
        
        if (!$groupId) {
            return response()->json([
                'success' => false,
                'message' => 'Không tìm thấy thông tin nhóm'
            ], 400);
        }

        try {
            $group = Group::findOrFail($groupId);
            
            // Convert string permission to enum
            $requiredPermission = Permission::from($permission);
            
            // Check if user has the required permission
            if (!$group->userHasPermission($user, $requiredPermission)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Bạn không có quyền thực hiện hành động này',
                    'required_permission' => $requiredPermission->label()
                ], 403);
            }

            // Add group and user permission info to request for controllers
            $request->merge([
                'group' => $group,
                'user_role' => $group->getUserRole($user),
                'user_permissions' => $group->getUserPermissions($user)
            ]);

            return $next($request);
            
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không tìm thấy nhóm'
            ], 404);
        } catch (\ValueError $e) {
            return response()->json([
                'success' => false,
                'message' => 'Quyền không hợp lệ'
            ], 400);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Đã xảy ra lỗi khi kiểm tra quyền',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
