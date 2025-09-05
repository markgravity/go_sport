import 'package:flutter/material.dart';

class VietnameseSportsSelector extends StatelessWidget {
  final List<String> availableSports;
  final List<String> selectedSports;
  final Function(List<String>) onChanged;
  final int maxSelections;

  const VietnameseSportsSelector({
    super.key,
    required this.availableSports,
    required this.selectedSports,
    required this.onChanged,
    this.maxSelections = 5,
  });

  void _toggleSport(String sport) {
    List<String> newSelected = List.from(selectedSports);
    
    if (newSelected.contains(sport)) {
      newSelected.remove(sport);
    } else if (newSelected.length < maxSelections) {
      newSelected.add(sport);
    }
    
    onChanged(newSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedSports.length >= maxSelections)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Bạn đã chọn tối đa $maxSelections môn thể thao',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableSports.map((sport) {
            final isSelected = selectedSports.contains(sport);
            final isDisabled = !isSelected && selectedSports.length >= maxSelections;
            
            return GestureDetector(
              onTap: isDisabled ? null : () => _toggleSport(sport),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? const Color(0xFF2E5BDA)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected 
                        ? const Color(0xFF2E5BDA)
                        : isDisabled 
                            ? Colors.grey.shade300
                            : Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      sport,
                      style: TextStyle(
                        color: isSelected 
                            ? Colors.white
                            : isDisabled
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Text(
          '${selectedSports.length}/$maxSelections môn đã chọn',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        if (selectedSports.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2E5BDA).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF2E5BDA).withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Môn thể thao yêu thích của bạn:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E5BDA),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  selectedSports.join(', '),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}