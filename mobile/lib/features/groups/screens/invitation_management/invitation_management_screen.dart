import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../models/group.dart';
import '../../models/group_invitation.dart';
import '../../services/groups_service.dart';
import 'invitation_management_view_model.dart';
import 'invitation_management_state.dart';
import '../../widgets/invitation_item_widget.dart';
import '../../widgets/join_request_item_widget.dart';
import '../../widgets/create_invitation_dialog.dart';
import '../../widgets/analytics_card_widget.dart';
import '../group_analytics/group_analytics_view_model.dart';

@RoutePage()
class InvitationManagementScreen extends StatelessWidget {
  final String groupId;

  const InvitationManagementScreen({
    super.key,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Group>(
      future: getIt<GroupsService>().getGroup(int.parse(groupId)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quản lý lời mời'),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Đang tải thông tin nhóm...'),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quản lý lời mời'),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Không thể tải thông tin nhóm',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vui lòng kiểm tra kết nối mạng và thử lại',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Force rebuild to retry
                      Navigator.of(context).pushReplacementNamed(
                        '/groups/invitation-management/$groupId',
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Thử lại'),
                  ),
                ],
              ),
            ),
          );
        }

        final group = snapshot.data!;
        return BlocProvider(
          create: (context) => getIt<InvitationManagementViewModel>(param1: group)..init(),
          child: _InvitationManagementView(),
        );
      },
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
                _AnalyticsTab(group: viewModel.group),
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

class _AnalyticsTab extends StatefulWidget {
  final Group group;

  const _AnalyticsTab({required this.group});

  @override
  State<_AnalyticsTab> createState() => _AnalyticsTabState();
}

class _AnalyticsTabState extends State<_AnalyticsTab> {
  late GroupAnalyticsViewModel _analyticsViewModel;

  @override
  void initState() {
    super.initState();
    _analyticsViewModel = getIt<GroupAnalyticsViewModel>();
    _analyticsViewModel.loadAnalytics(widget.group.id);
  }

  @override
  void dispose() {
    _analyticsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _analyticsViewModel,
      builder: (context, child) {
        if (_analyticsViewModel.isLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Đang tải thống kê...'),
              ],
            ),
          );
        }

        if (_analyticsViewModel.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(_analyticsViewModel.errorMessage ?? 'Có lỗi xảy ra'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _analyticsViewModel.loadAnalytics(widget.group.id),
                  child: Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        final analytics = _analyticsViewModel.groupAnalytics;
        final growth = _analyticsViewModel.memberGrowthAnalytics;

        if (analytics == null && growth == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.analytics_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Chưa có dữ liệu thống kê'),
                SizedBox(height: 8),
                Text(
                  'Tạo lời mời để bắt đầu thu thập thống kê',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Summary Cards
              if (analytics != null) ...[
                Text(
                  'Tổng quan lời mời',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AnalyticsCard(
                        title: 'Lời mời',
                        value: '${analytics.summary.totalInvitations}',
                        icon: Icons.link,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: AnalyticsCard(
                        title: 'Lượt nhấn',
                        value: '${analytics.summary.totalClicks}',
                        icon: Icons.mouse,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AnalyticsCard(
                        title: 'Tham gia',
                        value: '${analytics.summary.totalJoins}',
                        icon: Icons.person_add,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: AnalyticsCard(
                        title: 'Tỷ lệ chuyển đổi',
                        value: analytics.summary.conversionRate,
                        icon: Icons.trending_up,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],

              // Member Growth Summary
              if (growth != null) ...[
                Text(
                  'Tăng trưởng thành viên',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AnalyticsCard(
                        title: 'Thành viên mới',
                        value: '${growth.summary.newMembers}',
                        icon: Icons.person_add,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: AnalyticsCard(
                        title: 'Tỷ lệ tăng trưởng',
                        value: growth.summary.growthRate,
                        icon: Icons.trending_up,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                AnalyticsProgressCard(
                  title: 'Sử dụng công suất',
                  value: '${growth.summary.currentTotal}/${widget.group.maxMembers}',
                  progress: growth.summary.currentTotal / widget.group.maxMembers,
                  subtitle: 'thành viên',
                  color: Colors.deepPurple,
                ),
                SizedBox(height: 24),
              ],

              // Top Performing Invitations
              if (analytics != null && analytics.topPerformers.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lời mời hiệu quả nhất',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () => _showFullAnalytics(context),
                      child: Text('Xem tất cả'),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ...analytics.topPerformers.take(3).map((invitation) => Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.withValues(alpha: 0.1),
                      child: Icon(Icons.trending_up, color: Colors.green),
                    ),
                    title: Text('Tạo bởi: ${invitation.createdBy}'),
                    subtitle: Text('${invitation.clicks} lượt nhấn • ${invitation.joins} tham gia'),
                    trailing: Chip(
                      label: Text('${invitation.conversionRate.toStringAsFixed(1)}%'),
                      backgroundColor: _getConversionColor(invitation.conversionRate).withValues(alpha: 0.1),
                      labelStyle: TextStyle(
                        color: _getConversionColor(invitation.conversionRate),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
                SizedBox(height: 16),
              ],

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _analyticsViewModel.loadAnalytics(widget.group.id),
                      icon: Icon(Icons.refresh),
                      label: Text('Làm mới'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showFullAnalytics(context),
                      icon: Icon(Icons.analytics),
                      label: Text('Chi tiết'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getConversionColor(double rate) {
    if (rate >= 10) return Colors.green;
    if (rate >= 5) return Colors.orange;
    return Colors.red;
  }

  void _showFullAnalytics(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thống kê chi tiết sẽ được triển khai')),
    );
  }
}