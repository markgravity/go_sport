import 'package:flutter/material.dart';
import '../models/group_role.dart';
import '../models/group_permission.dart';
import '../models/group.dart';
import '../services/group_role_service.dart';
import '../../../core/dependency_injection/injection_container.dart';

class RoleManagementWidget extends StatefulWidget {
  final Group group;
  final UserPermissions userPermissions;
  final VoidCallback? onMemberUpdated;

  const RoleManagementWidget({
    super.key,
    required this.group,
    required this.userPermissions,
    this.onMemberUpdated,
  });

  @override
  State<RoleManagementWidget> createState() => _RoleManagementWidgetState();
}

class _RoleManagementWidgetState extends State<RoleManagementWidget> {
  final GroupRoleService _groupRoleService = getIt<GroupRoleService>();
  bool _isLoading = false;

  /// Show role change dialog
  Future<void> _showRoleChangeDialog(GroupMember member) async {
    final currentRole = GroupRole.fromValue(member.role);
    final userRole = widget.userPermissions.roleEnum;
    
    if (currentRole == null || userRole == null) return;

    // Get roles that current user can assign
    final assignableRoles = userRole.assignableRoles;
    
    if (assignableRoles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn không có quyền thay đổi vai trò thành viên'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newRole = await showDialog<GroupRole>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thay đổi vai trò - ${member.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Vai trò hiện tại: ${currentRole.vietnamese}'),
              const SizedBox(height: 16),
              const Text('Chọn vai trò mới:'),
              const SizedBox(height: 8),
              ...assignableRoles.map((role) => RadioListTile<GroupRole>(
                title: Text(role.vietnamese),
                subtitle: Text(role.description),
                value: role,
                groupValue: currentRole,
                onChanged: (GroupRole? value) {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  }
                },
              )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
          ],
        );
      },
    );

    if (newRole != null && newRole != currentRole) {
      await _updateMemberRole(member, newRole);
    }
  }

  /// Update member role
  Future<void> _updateMemberRole(GroupMember member, GroupRole newRole) async {
    if (!widget.userPermissions.hasPermission(GroupPermission.changeMemberRoles)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn không có quyền thay đổi vai trò thành viên'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _groupRoleService.updateMemberRole(
        widget.group.id, 
        member.userId, 
        newRole
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã thay đổi vai trò của ${member.name} thành ${newRole.vietnamese}'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onMemberUpdated?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi thay đổi vai trò: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Show remove member confirmation
  Future<void> _showRemoveMemberDialog(GroupMember member) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận loại bỏ thành viên'),
          content: Text(
            'Bạn có chắc chắn muốn loại bỏ "${member.name}" khỏi nhóm không?\n\n'
            'Hành động này không thể hoàn tác.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Loại bỏ'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _removeMember(member);
    }
  }

  /// Remove member
  Future<void> _removeMember(GroupMember member) async {
    if (!widget.userPermissions.hasPermission(GroupPermission.removeMembers)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn không có quyền loại bỏ thành viên'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _groupRoleService.removeMember(widget.group.id, member.userId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã loại bỏ ${member.name} khỏi nhóm'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onMemberUpdated?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi loại bỏ thành viên: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final canManageRoles = widget.userPermissions.hasPermission(GroupPermission.changeMemberRoles);
    final canRemoveMembers = widget.userPermissions.hasPermission(GroupPermission.removeMembers);

    if (!canManageRoles && !canRemoveMembers) {
      return const SizedBox.shrink(); // Hide widget if no permissions
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.admin_panel_settings),
                const SizedBox(width: 8),
                Text(
                  'Quản lý vai trò',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.group.members?.length ?? 0,
                itemBuilder: (context, index) {
                  final member = widget.group.members![index];
                  final memberRole = GroupRole.fromValue(member.role);
                  final isCreator = member.userId == widget.group.creatorId;

                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(member.name[0].toUpperCase()),
                    ),
                    title: Text(member.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(memberRole?.vietnamese ?? 'Không xác định'),
                        if (isCreator)
                          const Text(
                            'Người tạo nhóm',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (canManageRoles && !isCreator)
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: () => _showRoleChangeDialog(member),
                            tooltip: 'Thay đổi vai trò',
                          ),
                        if (canRemoveMembers && !isCreator)
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _showRemoveMemberDialog(member),
                            color: Colors.red,
                            tooltip: 'Loại bỏ khỏi nhóm',
                          ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}