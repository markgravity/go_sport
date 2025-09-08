import 'package:flutter/material.dart';

class CreateInvitationDialog extends StatefulWidget {
  final Function(int?) onCreateInvitation;

  const CreateInvitationDialog({
    super.key,
    required this.onCreateInvitation,
  });

  @override
  State<CreateInvitationDialog> createState() => _CreateInvitationDialogState();
}

class _CreateInvitationDialogState extends State<CreateInvitationDialog> {
  int? _selectedDays;
  final List<int?> _expirationOptions = [
    null, // No expiration
    1,
    3,
    7,
    30,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tạo lời mời mới'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thời hạn lời mời:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...(_expirationOptions.map((days) {
            return RadioListTile<int?>(
              title: Text(_getExpirationText(days)),
              value: days,
              groupValue: _selectedDays,
              onChanged: (value) {
                setState(() {
                  _selectedDays = value;
                });
              },
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            );
          }).toList()),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Thông tin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Liên kết lời mời sẽ được tạo và có thể chia sẻ với người khác. Người nhận có thể sử dụng liên kết để gửi yêu cầu tham gia nhóm.',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
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
            widget.onCreateInvitation(_selectedDays);
          },
          child: const Text('Tạo lời mời'),
        ),
      ],
    );
  }

  String _getExpirationText(int? days) {
    if (days == null) {
      return 'Không hết hạn';
    }
    return '$days ngày';
  }
}