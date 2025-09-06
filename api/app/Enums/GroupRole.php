<?php

namespace App\Enums;

enum GroupRole: string
{
    case ADMIN = 'admin';           // Trưởng nhóm
    case MODERATOR = 'moderator';   // Phó nhóm
    case MEMBER = 'member';         // Thành viên
    case GUEST = 'guest';           // Khách

    /**
     * Get role name in Vietnamese
     */
    public function vietnamese(): string
    {
        return match($this) {
            self::ADMIN => 'Trưởng nhóm',
            self::MODERATOR => 'Phó nhóm',
            self::MEMBER => 'Thành viên',
            self::GUEST => 'Khách',
        };
    }

    /**
     * Get role description
     */
    public function description(): string
    {
        return match($this) {
            self::ADMIN => 'Người tạo và quản lý nhóm, có toàn quyền',
            self::MODERATOR => 'Hỗ trợ quản lý nhóm, có quyền hạn cao',
            self::MEMBER => 'Thành viên chính thức của nhóm',
            self::GUEST => 'Khách tham quan, quyền hạn hạn chế',
        };
    }

    /**
     * Get role hierarchy level (lower number = higher authority)
     */
    public function level(): int
    {
        return match($this) {
            self::ADMIN => 1,
            self::MODERATOR => 2,
            self::MEMBER => 3,
            self::GUEST => 4,
        };
    }

    /**
     * Get permissions for this role
     */
    public function permissions(): array
    {
        return match($this) {
            self::ADMIN => [
                // Full permissions - all permissions
                GroupPermission::EDIT_GROUP,
                GroupPermission::DELETE_GROUP,
                GroupPermission::CHANGE_GROUP_SETTINGS,
                GroupPermission::UPLOAD_GROUP_AVATAR,
                
                GroupPermission::ADD_MEMBERS,
                GroupPermission::REMOVE_MEMBERS,
                GroupPermission::CHANGE_MEMBER_ROLES,
                GroupPermission::VIEW_MEMBER_DETAILS,
                GroupPermission::APPROVE_MEMBER_REQUESTS,
                
                GroupPermission::CREATE_SESSIONS,
                GroupPermission::EDIT_SESSIONS,
                GroupPermission::DELETE_SESSIONS,
                GroupPermission::MANAGE_ATTENDANCE,
                
                GroupPermission::CREATE_PAYMENT_REQUESTS,
                GroupPermission::MANAGE_PAYMENTS,
                GroupPermission::VIEW_FINANCIAL_REPORTS,
                
                GroupPermission::SEND_NOTIFICATIONS,
                GroupPermission::MODERATE_DISCUSSIONS,
                
                GroupPermission::VIEW_GROUP,
                GroupPermission::JOIN_SESSIONS,
                GroupPermission::LEAVE_GROUP,
                GroupPermission::VIEW_BASIC_STATS,
            ],
            
            self::MODERATOR => [
                // Most management permissions except critical ones
                GroupPermission::EDIT_GROUP,
                GroupPermission::CHANGE_GROUP_SETTINGS,
                GroupPermission::UPLOAD_GROUP_AVATAR,
                
                GroupPermission::ADD_MEMBERS,
                GroupPermission::VIEW_MEMBER_DETAILS,
                GroupPermission::APPROVE_MEMBER_REQUESTS,
                
                GroupPermission::CREATE_SESSIONS,
                GroupPermission::EDIT_SESSIONS,
                GroupPermission::DELETE_SESSIONS,
                GroupPermission::MANAGE_ATTENDANCE,
                
                GroupPermission::CREATE_PAYMENT_REQUESTS,
                GroupPermission::VIEW_FINANCIAL_REPORTS,
                
                GroupPermission::SEND_NOTIFICATIONS,
                GroupPermission::MODERATE_DISCUSSIONS,
                
                GroupPermission::VIEW_GROUP,
                GroupPermission::JOIN_SESSIONS,
                GroupPermission::LEAVE_GROUP,
                GroupPermission::VIEW_BASIC_STATS,
            ],
            
            self::MEMBER => [
                // Basic member permissions
                GroupPermission::CREATE_SESSIONS,
                GroupPermission::EDIT_SESSIONS, // Only own sessions
                
                GroupPermission::VIEW_GROUP,
                GroupPermission::JOIN_SESSIONS,
                GroupPermission::LEAVE_GROUP,
                GroupPermission::VIEW_BASIC_STATS,
            ],
            
            self::GUEST => [
                // Very limited permissions
                GroupPermission::VIEW_GROUP,
                GroupPermission::LEAVE_GROUP,
            ],
        };
    }

    /**
     * Check if this role can manage another role
     */
    public function canManage(GroupRole $otherRole): bool
    {
        return $this->level() < $otherRole->level();
    }

    /**
     * Check if this role has a specific permission
     */
    public function hasPermission(GroupPermission $permission): bool
    {
        return in_array($permission, $this->permissions());
    }

    /**
     * Get all available roles
     */
    public static function all(): array
    {
        return [
            self::ADMIN,
            self::MODERATOR,
            self::MEMBER,
            self::GUEST,
        ];
    }

    /**
     * Get roles that can be assigned by this role
     */
    public function assignableRoles(): array
    {
        return match($this) {
            self::ADMIN => [self::MODERATOR, self::MEMBER, self::GUEST],
            self::MODERATOR => [self::MEMBER, self::GUEST],
            self::MEMBER => [],
            self::GUEST => [],
        };
    }
}