import 'package:flutter/material.dart';
import '../models/sport.dart';
import '../services/groups_service.dart';
import '../widgets/sport_selection_widget.dart';
import '../widgets/location_input_widget.dart';
import '../widgets/group_settings_widget.dart';
import '../widgets/avatar_selection_widget.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  
  int _currentStep = 0;
  final int _totalSteps = 3;

  // Form data
  String? _selectedSportType;
  Sport? _selectedSport;
  String _groupName = '';
  String _description = '';
  String _skillLevel = '';
  String _location = '';
  String _city = '';
  String _district = '';
  double? _latitude;
  double? _longitude;
  int? _maxMembers;
  double _membershipFee = 0.0;
  String _privacy = 'cong_khai';
  List<String> _rules = [];
  String? _selectedAvatarUrl;
  String? _uploadedImageUrl;

  bool _isLoading = false;
  List<Sport> _availableSports = [];
  List<String> _nameSuggestions = [];
  bool _showNameSuggestions = false;

  @override
  void initState() {
    super.initState();
    _loadSports();
  }

  Future<void> _loadSports() async {
    try {
      setState(() => _isLoading = true);
      final sports = await GroupsService.getAvailableSports();
      setState(() {
        _availableSports = sports;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể tải danh sách môn thể thao: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSportSelected(Sport sport) {
    setState(() {
      _selectedSport = sport;
      _selectedSportType = sport.key;
      // Apply sport defaults
      _maxMembers ??= sport.defaults.maxMembers;
    });
    _loadNameSuggestions();
  }

  Future<void> _loadNameSuggestions() async {
    if (_selectedSportType == null) return;
    
    try {
      final suggestions = await GroupsService.getNameSuggestions(
        _selectedSportType!,
        city: _city.isNotEmpty ? _city : null,
      );
      setState(() {
        _nameSuggestions = suggestions;
      });
    } catch (e) {
      // Silently fail for name suggestions
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _createGroup() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedSportType == null || _skillLevel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng hoàn thành tất cả thông tin bắt buộc')),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);
      
      final group = await GroupsService.createGroup(
        name: _groupName,
        description: _description.isNotEmpty ? _description : null,
        sportType: _selectedSportType!,
        skillLevel: _skillLevel,
        location: _location,
        city: _city,
        district: _district.isNotEmpty ? _district : null,
        latitude: _latitude,
        longitude: _longitude,
        maxMembers: _maxMembers,
        membershipFee: _membershipFee,
        privacy: _privacy,
        avatar: _uploadedImageUrl ?? _selectedAvatarUrl,
        rules: _rules.isNotEmpty ? {'rules': _rules} : null,
      );

      if (mounted) {
        Navigator.of(context).pop(group);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tạo nhóm "${group.name}" thành công!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể tạo nhóm: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Nhóm'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / _totalSteps,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSportSelectionStep(),
                  _buildBasicInfoStep(),
                  _buildSettingsStep(),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildSportSelectionStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chọn môn thể thao',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Chọn môn thể thao cho nhóm của bạn',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SportSelectionWidget(
              sports: _availableSports,
              selectedSport: _selectedSport,
              onSportSelected: _onSportSelected,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin cơ bản',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Avatar selection
            AvatarSelectionWidget(
              selectedAvatarUrl: _selectedAvatarUrl,
              uploadedImagePath: null,
              sportType: _selectedSportType,
              onAvatarSelected: (url) => setState(() {
                _selectedAvatarUrl = url;
                _uploadedImageUrl = null;
              }),
              onImageUploaded: (url) => setState(() {
                _uploadedImageUrl = url;
                _selectedAvatarUrl = null;
              }),
            ),
            const SizedBox(height: 24),

            // Group name with suggestions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tên nhóm *',
                    hintText: 'VD: Nhóm cầu lông Hà Nội',
                    border: const OutlineInputBorder(),
                    suffixIcon: _nameSuggestions.isNotEmpty 
                      ? IconButton(
                          icon: Icon(_showNameSuggestions ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                          onPressed: () => setState(() => _showNameSuggestions = !_showNameSuggestions),
                        )
                      : null,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên nhóm';
                    }
                    if (value.trim().length < 3) {
                      return 'Tên nhóm phải có ít nhất 3 ký tự';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() => _groupName = value.trim()),
                ),
                if (_showNameSuggestions && _nameSuggestions.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.outline),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            'Gợi ý tên nhóm:',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        ...(_nameSuggestions.take(5).map((suggestion) => ListTile(
                          dense: true,
                          title: Text(suggestion),
                          onTap: () {
                            setState(() {
                              _groupName = suggestion;
                              _showNameSuggestions = false;
                            });
                          },
                        ))),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mô tả nhóm',
                hintText: 'Mô tả về nhóm của bạn...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) => _description = value.trim(),
            ),
            const SizedBox(height: 16),

            // Skill level
            if (_selectedSport != null) ...[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Trình độ *',
                  border: OutlineInputBorder(),
                ),
                value: _skillLevel.isEmpty ? null : _skillLevel,
                items: _selectedSport!.skillLevelsList.map((skill) {
                  return DropdownMenuItem(
                    value: skill.key,
                    child: Text(skill.name),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn trình độ';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _skillLevel = value ?? ''),
              ),
              const SizedBox(height: 16),
            ],

            // Location
            LocationInputWidget(
              onLocationChanged: (location, city, district, lat, lng) {
                setState(() {
                  _location = location;
                  _city = city;
                  _district = district;
                  _latitude = lat;
                  _longitude = lng;
                });
              },
              sportType: _selectedSportType,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cài đặt nhóm',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            GroupSettingsWidget(
              selectedSport: _selectedSport,
              maxMembers: _maxMembers,
              membershipFee: _membershipFee,
              privacy: _privacy,
              rules: _rules,
              onMaxMembersChanged: (value) => setState(() => _maxMembers = value),
              onMembershipFeeChanged: (value) => setState(() => _membershipFee = value),
              onPrivacyChanged: (value) => setState(() => _privacy = value),
              onRulesChanged: (value) => setState(() => _rules = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _isLoading ? null : _previousStep,
                child: const Text('Trở lại'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _isLoading ? null : () {
                if (_currentStep < _totalSteps - 1) {
                  // Validate current step
                  bool canProceed = false;
                  switch (_currentStep) {
                    case 0:
                      canProceed = _selectedSport != null;
                      break;
                    case 1:
                      canProceed = _groupName.isNotEmpty && 
                                 _skillLevel.isNotEmpty && 
                                 _location.isNotEmpty && 
                                 _city.isNotEmpty;
                      break;
                    case 2:
                      canProceed = true;
                      break;
                  }
                  
                  if (canProceed) {
                    _nextStep();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng hoàn thành thông tin bước này')),
                    );
                  }
                } else {
                  _createGroup();
                }
              },
              child: Text(_currentStep < _totalSteps - 1 ? 'Tiếp tục' : 'Tạo nhóm'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}