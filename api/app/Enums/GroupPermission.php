<?php

namespace App\Enums;

enum GroupPermission: string
{
    // Group Management
    case EDIT_GROUP = 'edit_group';
    case DELETE_GROUP = 'delete_group';
    case CHANGE_GROUP_SETTINGS = 'change_group_settings';
    case UPLOAD_GROUP_AVATAR = 'upload_group_avatar';
    
    // Member Management
    case ADD_MEMBERS = 'add_members';
    case REMOVE_MEMBERS = 'remove_members';
    case CHANGE_MEMBER_ROLES = 'change_member_roles';
    case VIEW_MEMBER_DETAILS = 'view_member_details';
    case APPROVE_MEMBER_REQUESTS = 'approve_member_requests';
    
    // Content Management
    case CREATE_SESSIONS = 'create_sessions';
    case EDIT_SESSIONS = 'edit_sessions';
    case DELETE_SESSIONS = 'delete_sessions';
    case MANAGE_ATTENDANCE = 'manage_attendance';
    
    // Financial Management
    case CREATE_PAYMENT_REQUESTS = 'create_payment_requests';
    case MANAGE_PAYMENTS = 'manage_payments';
    case VIEW_FINANCIAL_REPORTS = 'view_financial_reports';
    
    // Communication
    case SEND_NOTIFICATIONS = 'send_notifications';
    case MODERATE_DISCUSSIONS = 'moderate_discussions';
    
    // Basic Access
    case VIEW_GROUP = 'view_group';
    case JOIN_SESSIONS = 'join_sessions';
    case LEAVE_GROUP = 'leave_group';
    case VIEW_BASIC_STATS = 'view_basic_stats';

    /**
     * Get permission label in Vietnamese
     */
    public function label(): string
    {
        return match($this) {
            self::EDIT_GROUP => 'Chỉnh sửa nhóm',
            self::DELETE_GROUP => 'Xóa nhóm',
            self::CHANGE_GROUP_SETTINGS => 'Thay đổi cài đặt nhóm',
            self::UPLOAD_GROUP_AVATAR => 'Tải ảnh đại diện nhóm',
            
            self::ADD_MEMBERS => 'Thêm thành viên',
            self::REMOVE_MEMBERS => 'Xóa thành viên',
            self::CHANGE_MEMBER_ROLES => 'Thay đổi vai trò thành viên',
            self::VIEW_MEMBER_DETAILS => 'Xem thông tin thành viên',
            self::APPROVE_MEMBER_REQUESTS => 'Phê duyệt yêu cầu tham gia',
            
            self::CREATE_SESSIONS => 'Tạo phiên tập/chơi',
            self::EDIT_SESSIONS => 'Chỉnh sửa phiên tập/chơi',
            self::DELETE_SESSIONS => 'Xóa phiên tập/chơi',
            self::MANAGE_ATTENDANCE => 'Quản lý điểm danh',
            
            self::CREATE_PAYMENT_REQUESTS => 'Tạo yêu cầu thanh toán',
            self::MANAGE_PAYMENTS => 'Quản lý thanh toán',
            self::VIEW_FINANCIAL_REPORTS => 'Xem báo cáo tài chính',
            
            self::SEND_NOTIFICATIONS => 'Gửi thông báo',
            self::MODERATE_DISCUSSIONS => 'Kiểm duyệt thảo luận',
            
            self::VIEW_GROUP => 'Xem nhóm',
            self::JOIN_SESSIONS => 'Tham gia phiên tập/chơi',
            self::LEAVE_GROUP => 'Rời khỏi nhóm',
            self::VIEW_BASIC_STATS => 'Xem thống kê cơ bản',
        };
    }

    /**
     * Get permission description
     */
    public function description(): string
    {
        return match($this) {
            self::EDIT_GROUP => 'Có thể chỉnh sửa thông tin cơ bản của nhóm',
            self::DELETE_GROUP => 'Có thể xóa nhóm (chỉ trưởng nhóm)',
            self::CHANGE_GROUP_SETTINGS => 'Có thể thay đổi cài đặt nhóm',
            self::UPLOAD_GROUP_AVATAR => 'Có thể tải lên và thay đổi ảnh đại diện nhóm',
            
            self::ADD_MEMBERS => 'Có thể mời và thêm thành viên mới',
            self::REMOVE_MEMBERS => 'Có thể loại bỏ thành viên khỏi nhóm',
            self::CHANGE_MEMBER_ROLES => 'Có thể thay đổi vai trò của thành viên',
            self::VIEW_MEMBER_DETAILS => 'Có thể xem thông tin chi tiết của thành viên',
            self::APPROVE_MEMBER_REQUESTS => 'Có thể phê duyệt yêu cầu tham gia nhóm',
            
            self::CREATE_SESSIONS => 'Có thể tạo phiên tập/chơi mới',
            self::EDIT_SESSIONS => 'Có thể chỉnh sửa thông tin phiên tập/chơi',
            self::DELETE_SESSIONS => 'Có thể xóa phiên tập/chơi',
            self::MANAGE_ATTENDANCE => 'Có thể quản lý điểm danh của thành viên',
            
            self::CREATE_PAYMENT_REQUESTS => 'Có thể tạo yêu cầu đóng phí',
            self::MANAGE_PAYMENTS => 'Có thể quản lý và xác nhận thanh toán',
            self::VIEW_FINANCIAL_REPORTS => 'Có thể xem báo cáo tài chính nhóm',
            
            self::SEND_NOTIFICATIONS => 'Có thể gửi thông báo cho thành viên',
            self::MODERATE_DISCUSSIONS => 'Có thể kiểm duyệt và quản lý thảo luận',
            
            self::VIEW_GROUP => 'Có thể xem thông tin nhóm',
            self::JOIN_SESSIONS => 'Có thể tham gia vào các phiên tập/chơi',
            self::LEAVE_GROUP => 'Có thể rời khỏi nhóm',
            self::VIEW_BASIC_STATS => 'Có thể xem thống kê cơ bản',
        };
    }
}