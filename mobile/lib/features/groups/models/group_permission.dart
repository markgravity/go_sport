import 'group_role.dart';

class GroupPermission {
  final String value;
  final String label;
  final String description;

  const GroupPermission({
    required this.value,
    required this.label,
    required this.description,
  });

  factory GroupPermission.fromJson(Map<String, dynamic> json) {
    return GroupPermission(
      value: json['value'] as String,
      label: json['label'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
      'description': description,
    };
  }

  // Common permission constants
  static const String editGroup = 'edit_group';
  static const String deleteGroup = 'delete_group';
  static const String changeGroupSettings = 'change_group_settings';
  static const String uploadGroupAvatar = 'upload_group_avatar';

  static const String addMembers = 'add_members';
  static const String removeMembers = 'remove_members';
  static const String changeMemberRoles = 'change_member_roles';
  static const String viewMemberDetails = 'view_member_details';
  static const String approveMemberRequests = 'approve_member_requests';

  static const String createSessions = 'create_sessions';
  static const String editSessions = 'edit_sessions';
  static const String deleteSessions = 'delete_sessions';
  static const String manageAttendance = 'manage_attendance';

  static const String createPaymentRequests = 'create_payment_requests';
  static const String managePayments = 'manage_payments';
  static const String viewFinancialReports = 'view_financial_reports';

  static const String sendNotifications = 'send_notifications';
  static const String moderateDiscussions = 'moderate_discussions';

  static const String viewGroup = 'view_group';
  static const String joinSessions = 'join_sessions';
  static const String leaveGroup = 'leave_group';
  static const String viewBasicStats = 'view_basic_stats';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupPermission &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'GroupPermission(value: $value, label: $label)';
}

class UserPermissions {
  final String? role;
  final String? roleName;
  final List<GroupPermission> permissions;

  const UserPermissions({
    required this.role,
    required this.roleName,
    required this.permissions,
  });

  factory UserPermissions.fromJson(Map<String, dynamic> json) {
    return UserPermissions(
      role: json['role'] as String?,
      roleName: json['role_name'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((p) => GroupPermission.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Check if user has a specific permission
  bool hasPermission(String permission) {
    return permissions.any((p) => p.value == permission);
  }

  /// Check if user has any of the specified permissions
  bool hasAnyPermission(List<String> permissionList) {
    return permissionList.any((permission) => hasPermission(permission));
  }

  /// Check if user has all of the specified permissions
  bool hasAllPermissions(List<String> permissionList) {
    return permissionList.every((permission) => hasPermission(permission));
  }

  /// Get user's role as enum
  GroupRole? get roleEnum => GroupRole.fromValue(role);

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'role_name': roleName,
      'permissions': permissions.map((p) => p.toJson()).toList(),
    };
  }

  @override
  String toString() =>
      'UserPermissions(role: $role, roleName: $roleName, permissions: ${permissions.length})';
}
