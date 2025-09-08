import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../models/group.dart';
import '../../models/group_invitation.dart';
import 'invitation_management_view_model.dart';
import 'invitation_management_state.dart';
import '../../widgets/invitation_item_widget.dart';
import '../../widgets/join_request_item_widget.dart';
import '../../widgets/create_invitation_dialog.dart';

@RoutePage()
class InvitationManagementScreen extends StatelessWidget {
  final String groupId;

  const InvitationManagementScreen({
    super.key,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    // For now, create a mock group object with the groupId
    // In a real implementation, you would load the group data from the API
    final group = Group(
      id: int.parse(groupId),
      name: 'Loading...', // This will be updated once loaded
      sportType: 'unknown',
      skillLevel: 'unknown',
      location: 'unknown',
      city: 'unknown',
      maxMembers: 20,
      currentMembers: 0,
      membershipFee: 0,
      privacy: 'cong_khai',
      status: 'hoat_dong',
      creatorId: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    return BlocProvider(
      create: (context) => getIt<InvitationManagementViewModel>(param1: group)..init(),
      child: _InvitationManagementView(),
    );
  }
}

class _InvitationManagementView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvitationManagementViewModel, InvitationManagementState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<InvitationManagementViewModel>().clearMessages();
        }
        
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<InvitationManagementViewModel>().clearMessages();
        }
      },
      builder: (context, state) {
        final viewModel = context.read<InvitationManagementViewModel>();
        
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quản lý lời mời'),
                Text(
                  viewModel.group.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: SizedBox(
                height: 50,
                child: Row(
                  children: InvitationTab.values.map((tab) {
                    final isSelected = state.currentTab == tab;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => viewModel.switchTab(tab),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected ? Colors.white : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              tab.displayName,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white70,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => viewModel.refresh(),
            child: IndexedStack(
              index: state.currentTab.index,
              children: [
                _InvitationsTab(),
                _JoinRequestsTab(),
              ],
            ),
          ),
          floatingActionButton: state.currentTab == InvitationTab.invitations
              ? FloatingActionButton.extended(
                  onPressed: state.isCreatingInvitation 
                      ? null 
                      : () => _showCreateInvitationDialog(context),
                  icon: state.isCreatingInvitation 
                      ? const SizedBox(
                          width: 16, 
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add),
                  label: Text(
                    state.isCreatingInvitation ? 'Đang tạo...' : 'Tạo lời mời',
                  ),
                )
              : null,
        );
      },
    );
  }

  void _showCreateInvitationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreateInvitationDialog(
        onCreateInvitation: (expiresInDays) {
          context.read<InvitationManagementViewModel>()
              .createInvitation(expiresInDays: expiresInDays);
        },
      ),
    );
  }
}

class _InvitationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationManagementViewModel, InvitationManagementState>(
      builder: (context, state) {
        if (state.isLoadingInvitations) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.invitations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.link_off,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Chưa có lời mời nào',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tạo lời mời để mời người khác tham gia nhóm',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.invitations.length,
          itemBuilder: (context, index) {
            final invitation = state.invitations[index];
            return InvitationItemWidget(
              invitation: invitation,
              onShare: () => _shareInvitation(context, invitation),
              onCopy: () => _copyInvitationLink(context, invitation),
              onDelete: () => _deleteInvitation(context, invitation),
            );
          },
        );
      },
    );
  }

  void _shareInvitation(BuildContext context, GroupInvitation invitation) {
    // Implement share functionality
    final text = 'Tham gia nhóm ${context.read<InvitationManagementViewModel>().group.name}!\n\n${invitation.invitationUrl}';
    
    // For now, copy to clipboard
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã sao chép liên kết chia sẻ'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _copyInvitationLink(BuildContext context, GroupInvitation invitation) {
    Clipboard.setData(ClipboardData(text: invitation.invitationUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã sao chép liên kết lời mời'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteInvitation(BuildContext context, GroupInvitation invitation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa lời mời này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<InvitationManagementViewModel>()
                  .deleteInvitation(invitation);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _JoinRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationManagementViewModel, InvitationManagementState>(
      builder: (context, state) {
        if (state.isLoadingJoinRequests) {
          return const Center(child: CircularProgressIndicator());
        }

        final pendingRequests = state.joinRequests
            .where((req) => req.isPending)
            .toList();
        
        final processedRequests = state.joinRequests
            .where((req) => !req.isPending)
            .toList();

        if (state.joinRequests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_disabled,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Chưa có yêu cầu tham gia',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Các yêu cầu tham gia sẽ hiển thị ở đây',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (pendingRequests.isNotEmpty) ...[
              Text(
                'Đang chờ duyệt (${pendingRequests.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              ...pendingRequests.map((request) => JoinRequestItemWidget(
                joinRequest: request,
                onApprove: () => _approveRequest(context, request),
                onReject: () => _rejectRequest(context, request),
                isProcessing: state.isProcessingRequest,
              )),
              if (processedRequests.isNotEmpty) const SizedBox(height: 24),
            ],
            if (processedRequests.isNotEmpty) ...[
              Text(
                'Đã xử lý (${processedRequests.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              ...processedRequests.map((request) => JoinRequestItemWidget(
                joinRequest: request,
                onApprove: null,
                onReject: null,
                isProcessing: false,
              )),
            ],
          ],
        );
      },
    );
  }

  void _approveRequest(BuildContext context, GroupJoinRequest request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Duyệt yêu cầu tham gia'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Duyệt yêu cầu từ ${request.user?.name ?? 'Người dùng'}?'),
            if (request.message?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              Text(
                'Tin nhắn:',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(request.message!),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<InvitationManagementViewModel>()
                  .approveJoinRequest(request);
            },
            child: const Text('Duyệt'),
          ),
        ],
      ),
    );
  }

  void _rejectRequest(BuildContext context, GroupJoinRequest request) {
    final reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Từ chối yêu cầu tham gia'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Từ chối yêu cầu từ ${request.user?.name ?? 'Người dùng'}?'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Lý do từ chối (tuỳ chọn)',
                border: OutlineInputBorder(),
                hintText: 'Nhập lý do từ chối...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<InvitationManagementViewModel>()
                  .rejectJoinRequest(
                request,
                reason: reasonController.text.trim().isEmpty 
                    ? null 
                    : reasonController.text.trim(),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Từ chối', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}