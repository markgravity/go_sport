import 'package:flutter/material.dart';
import '../models/group.dart';

/// Group Card Widget for displaying group information
/// 
/// Shows Vietnamese group details with cultural patterns and sports icons
class GroupCardWidget extends StatelessWidget {
  final Group group;
  final VoidCallback? onTap;
  final VoidCallback? onLeave;

  const GroupCardWidget({
    super.key,
    required this.group,
    this.onTap,
    this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
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
              // Header with group name and sport type
              Row(
                children: [
                  // Sport icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _getSportColor(group.sportType).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getSportIcon(group.sportType),
                      color: _getSportColor(group.sportType),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Group name and sport type
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          group.sportType,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _getSportColor(group.sportType),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // More options
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'leave' && onLeave != null) {
                        onLeave!();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'leave',
                        child: Row(
                          children: [
                            Icon(Icons.exit_to_app, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Rời nhóm', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    child: const Icon(
                      Icons.more_vert,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Description
              if (group.description != null && group.description!.isNotEmpty) ...[
                Text(
                  group.description!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],
              
              // Group stats
              Row(
                children: [
                  // Member count
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.people,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${group.currentMembers} thành viên',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Activity status
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getActivityColor(group.updatedAt).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: _getActivityColor(group.updatedAt),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getActivityText(group.updatedAt),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _getActivityColor(group.updatedAt),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Privacy indicator
                  Icon(
                    group.privacy == 'rieng_tu' ? Icons.lock : Icons.public,
                    size: 16,
                    color: const Color(0xFF64748B),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get sport-specific icon
  IconData _getSportIcon(String sportType) {
    switch (sportType.toLowerCase()) {
      case 'cầu lông':
      case 'badminton':
        return Icons.sports_tennis;
      case 'pickleball':
        return Icons.sports_tennis;
      case 'bóng đá':
      case 'football':
      case 'soccer':
        return Icons.sports_soccer;
      case 'bóng rổ':
      case 'basketball':
        return Icons.sports_basketball;
      case 'bóng chuyền':
      case 'volleyball':
        return Icons.sports_volleyball;
      case 'tennis':
        return Icons.sports_tennis;
      case 'chạy bộ':
      case 'running':
        return Icons.directions_run;
      case 'đạp xe':
      case 'cycling':
        return Icons.directions_bike;
      case 'bơi lội':
      case 'swimming':
        return Icons.pool;
      default:
        return Icons.sports;
    }
  }

  /// Get sport-specific color
  Color _getSportColor(String sportType) {
    switch (sportType.toLowerCase()) {
      case 'cầu lông':
      case 'badminton':
        return const Color(0xFF10B981); // Green
      case 'pickleball':
        return const Color(0xFF06B6D4); // Cyan
      case 'bóng đá':
      case 'football':
      case 'soccer':
        return const Color(0xFF3B82F6); // Blue
      case 'bóng rổ':
      case 'basketball':
        return const Color(0xFFEF4444); // Red
      case 'bóng chuyền':
      case 'volleyball':
        return const Color(0xFF8B5CF6); // Purple
      case 'tennis':
        return const Color(0xFFF59E0B); // Yellow
      case 'chạy bộ':
      case 'running':
        return const Color(0xFF84CC16); // Lime
      case 'đạp xe':
      case 'cycling':
        return const Color(0xFF06B6D4); // Cyan
      case 'bơi lội':
      case 'swimming':
        return const Color(0xFF0EA5E9); // Sky
      default:
        return const Color(0xFF64748B); // Gray
    }
  }

  /// Get activity status color
  Color _getActivityColor(DateTime lastActivity) {
    final now = DateTime.now();
    final difference = now.difference(lastActivity);
    
    if (difference.inDays <= 1) {
      return const Color(0xFF10B981); // Green - Active
    } else if (difference.inDays <= 7) {
      return const Color(0xFFF59E0B); // Yellow - Recent
    } else {
      return const Color(0xFF64748B); // Gray - Inactive
    }
  }

  /// Get activity status text in Vietnamese
  String _getActivityText(DateTime lastActivity) {
    final now = DateTime.now();
    final difference = now.difference(lastActivity);
    
    if (difference.inMinutes < 1) {
      return 'Vừa hoạt động';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays <= 7) {
      return '${difference.inDays} ngày trước';
    } else {
      final weeks = (difference.inDays / 7).floor();
      if (weeks == 1) {
        return '1 tuần trước';
      } else if (weeks < 4) {
        return '$weeks tuần trước';
      } else {
        final months = (difference.inDays / 30).floor();
        return '$months tháng trước';
      }
    }
  }
}