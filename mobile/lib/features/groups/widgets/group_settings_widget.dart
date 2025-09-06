import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/sport.dart';

class GroupSettingsWidget extends StatefulWidget {
  final Sport? selectedSport;
  final int? maxMembers;
  final double membershipFee;
  final String privacy;
  final List<String> rules;
  final Function(int?) onMaxMembersChanged;
  final Function(double) onMembershipFeeChanged;
  final Function(String) onPrivacyChanged;
  final Function(List<String>) onRulesChanged;

  const GroupSettingsWidget({
    super.key,
    required this.selectedSport,
    required this.maxMembers,
    required this.membershipFee,
    required this.privacy,
    required this.rules,
    required this.onMaxMembersChanged,
    required this.onMembershipFeeChanged,
    required this.onPrivacyChanged,
    required this.onRulesChanged,
  });

  @override
  State<GroupSettingsWidget> createState() => _GroupSettingsWidgetState();
}

class _GroupSettingsWidgetState extends State<GroupSettingsWidget> {
  final _maxMembersController = TextEditingController();
  final _membershipFeeController = TextEditingController();
  final _ruleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _maxMembersController.text = widget.maxMembers?.toString() ?? '';
    _membershipFeeController.text = widget.membershipFee == 0 ? '' : widget.membershipFee.toStringAsFixed(0);
  }

  void _addRule() {
    final rule = _ruleController.text.trim();
    if (rule.isNotEmpty && !widget.rules.contains(rule)) {
      final newRules = [...widget.rules, rule];
      widget.onRulesChanged(newRules);
      _ruleController.clear();
    }
  }

  void _removeRule(int index) {
    final newRules = [...widget.rules];
    newRules.removeAt(index);
    widget.onRulesChanged(newRules);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Max members
        TextFormField(
          controller: _maxMembersController,
          decoration: InputDecoration(
            labelText: 'Số thành viên tối đa',
            hintText: widget.selectedSport?.defaults.maxMembers.toString(),
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.people),
            helperText: widget.selectedSport != null
                ? 'Đề xuất: ${widget.selectedSport!.defaults.maxMembers} người'
                : null,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              final members = int.tryParse(value);
              if (members == null || members < 2) {
                return 'Số thành viên phải ít nhất 2 người';
              }
              if (members > 100) {
                return 'Số thành viên không được vượt quá 100 người';
              }
            }
            return null;
          },
          onChanged: (value) {
            final members = int.tryParse(value);
            widget.onMaxMembersChanged(members);
          },
        ),
        const SizedBox(height: 16),

        // Membership fee
        TextFormField(
          controller: _membershipFeeController,
          decoration: const InputDecoration(
            labelText: 'Phí thành viên (VND/tháng)',
            hintText: '0',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.attach_money),
            helperText: 'Để trống nếu miễn phí',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(8),
          ],
          onChanged: (value) {
            final fee = double.tryParse(value) ?? 0.0;
            widget.onMembershipFeeChanged(fee);
          },
        ),
        const SizedBox(height: 16),

        // Privacy settings
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quyền riêng tư',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                RadioListTile<String>(
                  title: const Text('Công khai'),
                  subtitle: const Text('Mọi người có thể tìm thấy và tham gia nhóm'),
                  value: 'cong_khai',
                  groupValue: widget.privacy,
                  onChanged: (value) => widget.onPrivacyChanged(value!),
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<String>(
                  title: const Text('Riêng tư'),
                  subtitle: const Text('Chỉ có thể tham gia bằng lời mời hoặc yêu cầu'),
                  value: 'rieng_tu',
                  groupValue: widget.privacy,
                  onChanged: (value) => widget.onPrivacyChanged(value!),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Group rules
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nội quy nhóm',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Thiết lập các quy tắc để thành viên tuân thủ',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),

                // Add rule input
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _ruleController,
                        decoration: const InputDecoration(
                          hintText: 'Nhập quy tắc mới...',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onFieldSubmitted: (_) => _addRule(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _addRule,
                      icon: const Icon(Icons.add),
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Rules list
                if (widget.rules.isNotEmpty) ...[
                  Text(
                    'Nội quy đã thêm:',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.rules.asMap().entries.map((entry) {
                    final index = entry.key;
                    final rule = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('${index + 1}. $rule'),
                          ),
                          IconButton(
                            onPressed: () => _removeRule(index),
                            icon: const Icon(Icons.delete_outline),
                            iconSize: 18,
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ] else
                  Text(
                    'Chưa có nội quy nào',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Sport-specific information
        if (widget.selectedSport != null) ...[
          const SizedBox(height: 16),
          Card(
            color: theme.colorScheme.primaryContainer.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Thông tin ${widget.selectedSport!.name}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow('Số người chơi', 
                    '${widget.selectedSport!.defaults.minPlayers} - ${widget.selectedSport!.defaults.maxPlayers} người'),
                  _buildInfoRow('Thời gian thông thường', 
                    '${widget.selectedSport!.defaults.typicalDuration} phút'),
                  if (widget.selectedSport!.defaults.equipmentNeeded.isNotEmpty)
                    _buildInfoRow('Dụng cụ cần thiết', 
                      widget.selectedSport!.defaults.equipmentNeeded.join(', ')),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _maxMembersController.dispose();
    _membershipFeeController.dispose();
    _ruleController.dispose();
    super.dispose();
  }
}