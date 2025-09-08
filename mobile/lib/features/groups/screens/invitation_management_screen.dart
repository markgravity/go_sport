import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get_it/get_it.dart';
import '../models/group_invitation.dart';
import '../services/invitation_service.dart';
import '../widgets/invitation_list_item.dart';
import '../widgets/create_invitation_dialog.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../core/widgets/error_message.dart';
import '../../../core/utils/date_formatter.dart';

class InvitationManagementScreen extends StatefulWidget {
  final int groupId;
  final String groupName;

  const InvitationManagementScreen({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  @override
  State<InvitationManagementScreen> createState() => _InvitationManagementScreenState();
}

class _InvitationManagementScreenState extends State<InvitationManagementScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late InvitationService _invitationService;
  
  List<GroupInvitation> _pendingInvitations = [];
  List<GroupInvitation> _usedInvitations = [];
  List<GroupInvitation> _expiredInvitations = [];
  
  bool _isLoading = true;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _invitationService = GetIt.instance.get<InvitationService>();
    _loadInvitations();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  Future<void> _loadInvitations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final invitations = await _invitationService.getGroupInvitations(widget.groupId);
      
      setState(() {
        _pendingInvitations = invitations
            .where((inv) => inv.status == 'pending')
            .toList();
        _usedInvitations = invitations
            .where((inv) => inv.status == 'used')
            .toList();
        _expiredInvitations = invitations
            .where((inv) => inv.status == 'expired' || inv.status == 'revoked')
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Không thể tải danh sách lời mời';
        _isLoading = false;
      });
    }
  }
  
  Future<void> _createInvitation() async {
    final result = await showDialog<GroupInvitation>(
      context: context,
      builder: (context) => CreateInvitationDialog(
        onCreateInvitation: (expirationDays) async {
          final navigator = Navigator.of(context);
          try {
            final invitation = await _invitationService.createInvitation(
              widget.groupId,
              expiresInDays: expirationDays,
            );
            navigator.pop(invitation);
          } catch (e) {
            navigator.pop();
            // Handle error
          }
        },
      ),
    );
    
    if (result != null) {
      _loadInvitations();
      _showInvitationCreated(result);
    }
  }
  
  void _showInvitationCreated(GroupInvitation invitation) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Lời mời đã được tạo!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (invitation.type == 'sms' && invitation.recipientPhone != null)
              Text(
                'SMS đã gửi đến ${invitation.recipientPhone}',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              SelectableText(
                invitation.invitationUrl,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                      text: invitation.invitationUrl,
                    ));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã sao chép link')),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Sao chép'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    SharePlus.instance.share(ShareParams(
                      text: 'Mời bạn tham gia nhóm ${widget.groupName} trên GoSport!\n\n'
                      '${invitation.invitationUrl}',
                    ));
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Chia sẻ'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _revokeInvitation(GroupInvitation invitation) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thu hồi lời mời?'),
        content: const Text('Lời mời này sẽ không còn hiệu lực'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Thu hồi'),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      try {
        await _invitationService.revokeInvitation(invitation.token);
        _loadInvitations();
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Đã thu hồi lời mời')),
        );
      } catch (e) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Không thể thu hồi lời mời')),
        );
      }
    }
  }
  
  Future<void> _resendSmsInvitation(GroupInvitation invitation) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      await _invitationService.resendSmsInvitation(
        widget.groupId,
        invitation.id,
      );
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Đã gửi lại SMS')),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Không thể gửi lại SMS')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý lời mời'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Đang chờ',
              icon: Badge(
                label: Text(_pendingInvitations.length.toString()),
                child: const Icon(Icons.pending),
              ),
            ),
            Tab(
              text: 'Đã dùng',
              icon: Badge(
                label: Text(_usedInvitations.length.toString()),
                child: const Icon(Icons.check_circle),
              ),
            ),
            Tab(
              text: 'Hết hạn',
              icon: Badge(
                label: Text(_expiredInvitations.length.toString()),
                child: const Icon(Icons.cancel),
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const LoadingOverlay()
          : _errorMessage != null
              ? ErrorMessage(
                  message: _errorMessage!,
                  onRetry: _loadInvitations,
                )
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildInvitationList(_pendingInvitations, true),
                    _buildInvitationList(_usedInvitations, false),
                    _buildInvitationList(_expiredInvitations, false),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createInvitation,
        icon: const Icon(Icons.add),
        label: const Text('Tạo lời mời'),
      ),
    );
  }
  
  Widget _buildInvitationList(List<GroupInvitation> invitations, bool canRevoke) {
    if (invitations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Không có lời mời nào',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }
    
    return RefreshIndicator(
      onRefresh: _loadInvitations,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: invitations.length,
        itemBuilder: (context, index) {
          final invitation = invitations[index];
          return InvitationListItem(
            invitation: invitation,
            onTap: () => _showInvitationDetails(invitation),
            onRevoke: canRevoke ? () => _revokeInvitation(invitation) : null,
            onResendSms: invitation.type == 'sms' && canRevoke
                ? () => _resendSmsInvitation(invitation)
                : null,
            onShare: () {
              SharePlus.instance.share(ShareParams(
                text: 'Mời bạn tham gia nhóm ${widget.groupName} trên GoSport!\n\n'
                '${invitation.invitationUrl}',
              ));
            },
          );
        },
      ),
    );
  }
  
  void _showInvitationDetails(GroupInvitation invitation) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getStatusColor(invitation.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getStatusIcon(invitation.status),
                    color: _getStatusColor(invitation.status),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        invitation.statusName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        invitation.typeName,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Người tạo:', invitation.creator?.displayName ?? 'N/A'),
            _buildDetailRow('Ngày tạo:', DateFormatter.formatDateTime(invitation.createdAt)),
            if (invitation.expiresAt != null)
              _buildDetailRow('Hết hạn:', DateFormatter.formatDateTime(invitation.expiresAt!)),
            if (invitation.usedAt != null)
              _buildDetailRow('Đã dùng:', DateFormatter.formatDateTime(invitation.usedAt!)),
            if (invitation.usedByUser != null)
              _buildDetailRow('Người dùng:', invitation.usedByUser!.displayName),
            if (invitation.recipientPhone != null)
              _buildDetailRow('Số điện thoại:', invitation.recipientPhone!),
            const SizedBox(height: 16),
            if (invitation.invitationUrl.isNotEmpty) ...[
              const Text(
                'Link lời mời:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  invitation.invitationUrl,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'used':
        return Colors.green;
      case 'expired':
        return Colors.grey;
      case 'revoked':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.pending;
      case 'used':
        return Icons.check_circle;
      case 'expired':
        return Icons.schedule;
      case 'revoked':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}