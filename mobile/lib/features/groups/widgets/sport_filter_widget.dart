import 'package:flutter/material.dart';

/// Sport Filter Widget for Vietnamese sports group filtering
/// 
/// Shows Vietnamese sport types with cultural patterns and icons
class SportFilterWidget extends StatelessWidget {
  final List<String> selectedSports;
  final Function(String) onSportToggle;
  final VoidCallback? onClearAll;

  const SportFilterWidget({
    super.key,
    required this.selectedSports,
    required this.onSportToggle,
    this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final vietnameseSports = [
      'cau_long',
      'bong_da',
      'bong_ro',
      'tennis',
      'bong_chuyen',
      'bong_ban',
      'chay_bo',
      'dap_xe',
      'boi_loi',
      'yoga',
      'gym',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lọc theo môn thể thao',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (selectedSports.isNotEmpty)
                TextButton(
                  onPressed: onClearAll,
                  child: const Text('Xóa tất cả'),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: vietnameseSports.map((sport) {
              final isSelected = selectedSports.contains(sport);
              return FilterChip(
                label: Text(_getSportName(sport)),
                selected: isSelected,
                onSelected: (_) => onSportToggle(sport),
                selectedColor: _getSportColor(sport).withValues(alpha: 0.2),
                checkmarkColor: _getSportColor(sport),
                avatar: Icon(
                  _getSportIcon(sport),
                  color: isSelected ? _getSportColor(sport) : const Color(0xFF64748B),
                  size: 16,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Get Vietnamese sport name
  String _getSportName(String sportType) {
    switch (sportType) {
      case 'cau_long':
        return 'Cầu lông';
      case 'bong_da':
        return 'Bóng đá';
      case 'bong_ro':
        return 'Bóng rổ';
      case 'tennis':
        return 'Tennis';
      case 'bong_chuyen':
        return 'Bóng chuyền';
      case 'bong_ban':
        return 'Bóng bàn';
      case 'chay_bo':
        return 'Chạy bộ';
      case 'dap_xe':
        return 'Đạp xe';
      case 'boi_loi':
        return 'Bơi lội';
      case 'yoga':
        return 'Yoga';
      case 'gym':
        return 'Gym';
      default:
        return sportType;
    }
  }

  /// Get sport-specific icon
  IconData _getSportIcon(String sportType) {
    switch (sportType) {
      case 'cau_long':
        return Icons.sports_tennis;
      case 'bong_da':
        return Icons.sports_soccer;
      case 'bong_ro':
        return Icons.sports_basketball;
      case 'tennis':
        return Icons.sports_tennis;
      case 'bong_chuyen':
        return Icons.sports_volleyball;
      case 'bong_ban':
        return Icons.sports_tennis;
      case 'chay_bo':
        return Icons.directions_run;
      case 'dap_xe':
        return Icons.directions_bike;
      case 'boi_loi':
        return Icons.pool;
      case 'yoga':
        return Icons.self_improvement;
      case 'gym':
        return Icons.fitness_center;
      default:
        return Icons.sports;
    }
  }

  /// Get sport-specific color
  Color _getSportColor(String sportType) {
    switch (sportType) {
      case 'cau_long':
        return const Color(0xFF10B981); // Green
      case 'bong_da':
        return const Color(0xFF3B82F6); // Blue
      case 'bong_ro':
        return const Color(0xFFEF4444); // Red
      case 'tennis':
        return const Color(0xFFF59E0B); // Yellow
      case 'bong_chuyen':
        return const Color(0xFF8B5CF6); // Purple
      case 'bong_ban':
        return const Color(0xFF06B6D4); // Cyan
      case 'chay_bo':
        return const Color(0xFF84CC16); // Lime
      case 'dap_xe':
        return const Color(0xFF06B6D4); // Cyan
      case 'boi_loi':
        return const Color(0xFF0EA5E9); // Sky
      case 'yoga':
        return const Color(0xFFEC4899); // Pink
      case 'gym':
        return const Color(0xFF6B7280); // Gray
      default:
        return const Color(0xFF64748B); // Gray
    }
  }
}