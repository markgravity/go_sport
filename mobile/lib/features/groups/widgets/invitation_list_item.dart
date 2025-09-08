import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/group_invitation.dart';
import '../../../core/utils/date_formatter.dart';

class InvitationListItem extends StatelessWidget {
  final GroupInvitation invitation;
  final VoidCallback? onTap;
  final VoidCallback? onRevoke;
  final VoidCallback? onResendSms;
  final VoidCallback? onShare;

  const InvitationListItem({
    Key? key,
    required this.invitation,
    this.onTap,
    this.onRevoke,
    this.onResendSms,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getTypeColor(invitation.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTypeIcon(invitation.type),
                      color: _getTypeColor(invitation.type),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              invitation.typeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(invitation.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                invitation.statusName,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor(invitation.status),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        if (invitation.recipientPhone != null)
                          Text(
                            invitation.recipientPhone!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          )
                        else
                          Text(
                            'Tạo ${DateFormatter.formatRelative(invitation.createdAt)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (invitation.status == 'pending')
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 'copy':
                            Clipboard.setData(ClipboardData(
                              text: invitation.invitationUrl ?? '',
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Đã sao chép link')),
                            );
                            break;
                          case 'share':
                            onShare?.call();
                            break;
                          case 'resend':
                            onResendSms?.call();
                            break;
                          case 'revoke':
                            onRevoke?.call();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        if (invitation.invitationUrl != null) ...[
                          const PopupMenuItem(
                            value: 'copy',
                            child: ListTile(
                              leading: Icon(Icons.copy),
                              title: Text('Sao chép link'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'share',
                            child: ListTile(
                              leading: Icon(Icons.share),
                              title: Text('Chia sẻ'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                        if (invitation.type == 'sms' && onResendSms != null)
                          const PopupMenuItem(
                            value: 'resend',
                            child: ListTile(
                              leading: Icon(Icons.refresh),
                              title: Text('Gửi lại SMS'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        if (onRevoke != null)
                          const PopupMenuItem(
                            value: 'revoke',
                            child: ListTile(
                              leading: Icon(Icons.cancel, color: Colors.red),
                              title: Text('Thu hồi', style: TextStyle(color: Colors.red)),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              if (invitation.expiresAt != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getExpiryColor(invitation).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: _getExpiryColor(invitation),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getExpiryText(invitation),
                        style: TextStyle(
                          fontSize: 13,
                          color: _getExpiryColor(invitation),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (invitation.usedBy != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.green[100],
                      child: Icon(
                        Icons.person,
                        size: 16,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Đã dùng bởi ${invitation.usedByUser?.displayName ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'link':
        return Colors.blue;
      case 'sms':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'link':
        return Icons.link;
      case 'sms':
        return Icons.message;
      default:
        return Icons.mail;
    }
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

  Color _getExpiryColor(GroupInvitation invitation) {
    if (invitation.status != 'pending' || invitation.expiresAt == null) {
      return Colors.grey;
    }

    final now = DateTime.now();
    final expiry = invitation.expiresAt!;
    final difference = expiry.difference(now);

    if (difference.isNegative) {
      return Colors.red;
    } else if (difference.inHours < 24) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String _getExpiryText(GroupInvitation invitation) {
    if (invitation.expiresAt == null) {
      return 'Vĩnh viễn';
    }

    final now = DateTime.now();
    final expiry = invitation.expiresAt!;
    final difference = expiry.difference(now);

    if (difference.isNegative) {
      return 'Đã hết hạn';
    } else if (difference.inDays > 0) {
      return 'Còn ${difference.inDays} ngày';
    } else if (difference.inHours > 0) {
      return 'Còn ${difference.inHours} giờ';
    } else {
      return 'Còn ${difference.inMinutes} phút';
    }
  }
}