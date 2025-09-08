import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../app/auto_router.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../models/group_role.dart';
import 'group_details_state.dart';
import 'group_details_view_model.dart';

/// Group Details Screen for Vietnamese sports app
/// 
/// Shows detailed information about a group including members and management options
class GroupDetailsScreen extends StatelessWidget {
  final String groupId;
  
  const GroupDetailsScreen({
    super.key,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.createGroupDetailsViewModel()..initialize(groupId),
      child: const _GroupDetailsView(),
    );
  }
}

class _GroupDetailsView extends StatelessWidget {
  const _GroupDetailsView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupDetailsViewModel, GroupDetailsState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: (message) {},
          loaded: (group, members, currentUserRole) {},
          error: (message, errorCode) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          },
          roleAssigned: (message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          memberRemoved: (message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          invitationGenerated: (link, message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                ),
              );
            }
            // Show share options for invitation link
            _showInvitationOptions(context, link);
          },
          settingsUpdated: (message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          leftGroup: (message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                ),
              );
            }
            Navigator.of(context).pop();
          },
          groupDeleted: (message) {
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.green,
                ),
              );
            }
            Navigator.of(context).pop();
          },
          navigateToEditGroup: (groupId) {
            // TODO: Implement edit group screen route
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Chỉnh sửa nhóm - Coming soon!')),
            );
          },
          navigateToMemberProfile: (memberId) {
            // TODO: Implement member profile screen route
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Thông tin thành viên - Coming soon!')),
            );
          },
          navigateBack: () {
            Navigator.of(context).pop();
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Chi tiết nhóm'),
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: state.canEditGroup ? [
              PopupMenuButton<String>(
                onSelected: (value) {
                  final viewModel = context.read<GroupDetailsViewModel>();
                  switch (value) {
                    case 'edit':
                      viewModel.navigateToEditGroup(state.group?.id.toString() ?? '');
                      break;
                    case 'invite':
                      viewModel.generateInvitationLink(state.group?.id.toString() ?? '');
                      break;
                    case 'manage_invitations':
                      context.router.push(InvitationManagementRoute(
                        groupId: state.group?.id.toString() ?? '',
                      ));
                      break;
                    case 'settings':
                      _showGroupSettings(context, state, viewModel);
                      break;
                    case 'delete':
                      if (state.canDeleteGroup) {
                        _showDeleteConfirmation(context, viewModel);
                      }
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Chỉnh sửa nhóm'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'invite',
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        SizedBox(width: 8),
                        Text('Mời thành viên'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'manage_invitations',
                    child: Row(
                      children: [
                        Icon(Icons.link),
                        SizedBox(width: 8),
                        Text('Quản lý lời mời'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 8),
                        Text('Cài đặt nhóm'),
                      ],
                    ),
                  ),
                  if (state.canDeleteGroup)
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Xóa nhóm', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                ],
              ),
            ] : null,
          ),
          body: state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(message),
                  ],
                ],
              ),
            ),
            loaded: (group, members, currentUserRole) => RefreshIndicator(
              onRefresh: () => context.read<GroupDetailsViewModel>().refreshGroupDetails(group.id.toString()),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Group information card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.sports,
                                    color: Color(0xFF3B82F6),
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        group.sportName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (group.description != null && group.description!.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Text(
                                group.description!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                _InfoChip(
                                  icon: Icons.people,
                                  label: '${group.currentMembers}/${group.maxMembers} thành viên',
                                ),
                                const SizedBox(width: 8),
                                _InfoChip(
                                  icon: Icons.location_on,
                                  label: group.location,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Members section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Thành viên',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (state.canManageRoles)
                          TextButton.icon(
                            onPressed: () {
                              final viewModel = context.read<GroupDetailsViewModel>();
                              viewModel.generateInvitationLink(group.id.toString());
                            },
                            icon: const Icon(Icons.person_add),
                            label: const Text('Mời'),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Members list
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        final member = members[index];
                        return _MemberTile(
                          member: member,
                          currentUserRole: currentUserRole,
                          onRoleChanged: (newRole) {
                            final viewModel = context.read<GroupDetailsViewModel>();
                            viewModel.assignMemberRole(
                              groupId: group.id.toString(),
                              memberId: member.userId.toString(),
                              role: newRole,
                            );
                          },
                          onRemoveMember: () {
                            final viewModel = context.read<GroupDetailsViewModel>();
                            viewModel.removeMember(
                              groupId: group.id.toString(),
                              memberId: member.userId.toString(),
                              memberName: member.name,
                            );
                          },
                          onViewProfile: () {
                            final viewModel = context.read<GroupDetailsViewModel>();
                            viewModel.navigateToMemberProfile(member.userId.toString());
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            error: (message, errorCode) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final groupId = ModalRoute.of(context)?.settings.arguments as String?;
                      if (groupId != null) {
                        context.read<GroupDetailsViewModel>().loadGroupDetails(groupId);
                      }
                    },
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            ),
            roleAssigned: (message) => const Center(child: CircularProgressIndicator()),
            memberRemoved: (message) => const Center(child: CircularProgressIndicator()),
            invitationGenerated: (link, message) => const Center(child: CircularProgressIndicator()),
            settingsUpdated: (message) => const Center(child: CircularProgressIndicator()),
            leftGroup: (message) => const Center(child: CircularProgressIndicator()),
            groupDeleted: (message) => const Center(child: CircularProgressIndicator()),
            navigateToEditGroup: (groupId) => const Center(child: CircularProgressIndicator()),
            navigateToMemberProfile: (memberId) => const Center(child: CircularProgressIndicator()),
            navigateBack: () => const Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: state.isLoaded && !state.canDeleteGroup ? FloatingActionButton.extended(
            onPressed: () {
              _showLeaveConfirmation(context, context.read<GroupDetailsViewModel>());
            },
            backgroundColor: Colors.red,
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            label: const Text('Rời nhóm', style: TextStyle(color: Colors.white)),
          ) : null,
        );
      },
    );
  }

  void _showInvitationOptions(BuildContext context, String invitationLink) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Chia sẻ liên kết mời',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      invitationLink,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Copy to clipboard
                    },
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Share via system share
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Chia sẻ'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showGroupSettings(BuildContext context, GroupDetailsState state, GroupDetailsViewModel viewModel) {
    // Show group settings dialog
  }

  void _showDeleteConfirmation(BuildContext context, GroupDetailsViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa nhóm'),
        content: const Text('Bạn có chắc chắn muốn xóa nhóm này? Hành động này không thể hoàn tác.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              final groupId = ModalRoute.of(context)?.settings.arguments as String?;
              if (groupId != null) {
                viewModel.deleteGroup(groupId);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  void _showLeaveConfirmation(BuildContext context, GroupDetailsViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận rời nhóm'),
        content: const Text('Bạn có chắc chắn muốn rời khỏi nhóm này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              final groupId = ModalRoute.of(context)?.settings.arguments as String?;
              if (groupId != null) {
                viewModel.leaveGroup(groupId);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Rời nhóm'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final dynamic member; // GroupMember from the model
  final VietnameseGroupRole? currentUserRole;
  final Function(VietnameseGroupRole) onRoleChanged;
  final VoidCallback onRemoveMember;
  final VoidCallback onViewProfile;

  const _MemberTile({
    required this.member,
    required this.currentUserRole,
    required this.onRoleChanged,
    required this.onRemoveMember,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    final canManageRoles = currentUserRole == VietnameseGroupRole.leader ||
                          currentUserRole == VietnameseGroupRole.coLeader;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF3B82F6),
          child: Text(
            member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(member.name),
        subtitle: Text(_getRoleName(member.role)),
        trailing: canManageRoles ? PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'change_role':
                _showRoleChangeDialog(context);
                break;
              case 'remove':
                onRemoveMember();
                break;
              case 'view_profile':
                onViewProfile();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'change_role',
              child: Row(
                children: [
                  Icon(Icons.admin_panel_settings),
                  SizedBox(width: 8),
                  Text('Thay đổi vai trò'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'view_profile',
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('Xem hồ sơ'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'remove',
              child: Row(
                children: [
                  Icon(Icons.remove_circle, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Xóa khỏi nhóm', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ) : null,
        onTap: onViewProfile,
      ),
    );
  }

  String _getRoleName(String role) {
    // This should match the role mapping from Vietnamese group roles
    switch (role) {
      case 'leader':
        return 'Trưởng nhóm';
      case 'co_leader':
        return 'Phó nhóm';
      case 'member':
        return 'Thành viên';
      default:
        return role;
    }
  }

  void _showRoleChangeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thay đổi vai trò của ${member.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Thành viên'),
              onTap: () {
                Navigator.of(context).pop();
                onRoleChanged(VietnameseGroupRole.member);
              },
            ),
            ListTile(
              title: const Text('Phó nhóm'),
              onTap: () {
                Navigator.of(context).pop();
                onRoleChanged(VietnameseGroupRole.coLeader);
              },
            ),
            if (currentUserRole == VietnameseGroupRole.leader)
              ListTile(
                title: const Text('Trưởng nhóm'),
                onTap: () {
                  Navigator.of(context).pop();
                  onRoleChanged(VietnameseGroupRole.leader);
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
        ],
      ),
    );
  }
}