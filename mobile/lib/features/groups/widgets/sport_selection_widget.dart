import 'package:flutter/material.dart';
import '../models/sport.dart';

class SportSelectionWidget extends StatelessWidget {
  final List<Sport> sports;
  final Sport? selectedSport;
  final Function(Sport) onSportSelected;

  const SportSelectionWidget({
    super.key,
    required this.sports,
    required this.selectedSport,
    required this.onSportSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (sports.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Popular sports that should appear first
    final popularSports = ['cau_long', 'bong_da', 'bong_ro', 'tennis'];
    final popular = sports.where((sport) => popularSports.contains(sport.key)).toList();
    final others = sports.where((sport) => !popularSports.contains(sport.key)).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (popular.isNotEmpty) ...[
            Text(
              'Phổ biến',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: popular.length,
              itemBuilder: (context, index) => _buildSportCard(context, popular[index]),
            ),
            const SizedBox(height: 24),
          ],

          if (others.isNotEmpty) ...[
            Text(
              'Tất cả môn thể thao',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: others.length,
              itemBuilder: (context, index) => _buildSportCard(context, others[index]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSportCard(BuildContext context, Sport sport) {
    final isSelected = selectedSport?.key == sport.key;
    final theme = Theme.of(context);

    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? theme.colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: () => onSportSelected(sport),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Icon(
                  _getSportIcon(sport.key),
                  size: 24,
                  color: isSelected 
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Flexible(
                child: Text(
                  sport.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected 
                      ? theme.colorScheme.onPrimaryContainer
                      : null,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Chọn',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getSportIcon(String sportKey) {
    switch (sportKey) {
      case 'cau_long':
        return Icons.sports_tennis; // Badminton approximation
      case 'bong_da':
        return Icons.sports_soccer;
      case 'bong_ro':
        return Icons.sports_basketball;
      case 'tennis':
        return Icons.sports_tennis;
      case 'bong_chuyen':
        return Icons.sports_volleyball;
      case 'bong_ban':
        return Icons.sports_tennis; // Table tennis approximation
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
}