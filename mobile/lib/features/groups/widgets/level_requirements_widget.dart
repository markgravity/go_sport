import 'package:flutter/material.dart';
import '../../../core/dependency_injection/injection_container.dart';
import '../models/sport_level.dart';
import '../services/groups_service.dart';

class LevelRequirementsWidget extends StatefulWidget {
  final String? sportType;
  final List<String> selectedLevels;
  final Function(List<String>) onLevelsChanged;

  const LevelRequirementsWidget({
    super.key,
    required this.sportType,
    required this.selectedLevels,
    required this.onLevelsChanged,
  });

  @override
  State<LevelRequirementsWidget> createState() => _LevelRequirementsWidgetState();
}

class _LevelRequirementsWidgetState extends State<LevelRequirementsWidget> {
  List<SportLevel> _availableLevels = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  @override
  void didUpdateWidget(LevelRequirementsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.sportType != oldWidget.sportType) {
      _loadLevels();
    }
  }

  Future<void> _loadLevels() async {
    if (widget.sportType == null) {
      setState(() {
        _availableLevels = [];
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final levels = await getIt<GroupsService>().getSportLevels(widget.sportType!);
      setState(() {
        _availableLevels = levels;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Không thể tải danh sách cấp độ: $e';
        _isLoading = false;
      });
    }
  }

  void _toggleLevel(String levelKey) {
    final List<String> newSelection = List.from(widget.selectedLevels);
    
    if (newSelection.contains(levelKey)) {
      newSelection.remove(levelKey);
    } else {
      newSelection.add(levelKey);
    }
    
    widget.onLevelsChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yêu cầu cấp độ',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Chọn cấp độ phù hợp để thành viên có thể tự đánh giá (tùy chọn)',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),

        if (_isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          )
        else if (_errorMessage != null)
          Card(
            color: theme.colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: theme.colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        else if (_availableLevels.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Vui lòng chọn môn thể thao trước'),
                  ),
                ],
              ),
            ),
          )
        else ...[
          // Show available levels as chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableLevels.map((level) {
              final isSelected = widget.selectedLevels.contains(level.levelKey);
              
              return FilterChip(
                label: Text(level.levelName),
                selected: isSelected,
                onSelected: (_) => _toggleLevel(level.levelKey),
                selectedColor: theme.colorScheme.primaryContainer,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                side: BorderSide(
                  color: isSelected 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.outline,
                ),
              );
            }).toList(),
          ),
          
          // Show selection summary
          const SizedBox(height: 12),
          if (widget.selectedLevels.isEmpty)
            Text(
              'Không có yêu cầu cấp độ - Tất cả mọi người có thể tham gia',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Text(
              'Đã chọn ${widget.selectedLevels.length} cấp độ',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ],
    );
  }
}