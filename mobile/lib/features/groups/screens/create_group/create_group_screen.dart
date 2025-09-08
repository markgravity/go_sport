import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../models/sport.dart';
import '../../widgets/sport_selection_widget.dart';
import '../../widgets/location_input_widget.dart';
import '../../widgets/group_settings_widget.dart';
import '../../widgets/avatar_selection_widget.dart';
import '../../widgets/level_requirements_widget.dart';
import 'create_group_view_model.dart';
import 'create_group_state.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  late final CreateGroupViewModel _viewModel;
  
  int _currentStep = 0;
  final int _totalSteps = 3;
  
  // Track selected sport for UI updates
  Sport? _selectedSport;
  String _selectedPrivacy = 'cong_khai';

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<CreateGroupViewModel>();
    _viewModel.initialize();
    // Set default privacy in ViewModel
    _viewModel.updateField('privacy', _selectedPrivacy);
  }


  void _onSportSelected(Sport sport) {
    setState(() {
      _selectedSport = sport;
    });
    _viewModel.updateField('sportType', sport.key);
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
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    await _viewModel.createGroup();
  }

  String? _validateCurrentStep() {
    switch (_currentStep) {
      case 0: // Sport selection step
        if (_selectedSport == null) {
          return 'Vui lòng chọn môn thể thao';
        }
        break;
      case 1: // Basic info step
        if (!_formKey.currentState!.validate()) {
          return 'Vui lòng hoàn thành thông tin bắt buộc';
        }
        break;
      case 2: // Settings step
        if (_selectedPrivacy.isEmpty) {
          return 'Vui lòng chọn quyền riêng tư';
        }
        break;
    }
    return null; // No validation errors
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateGroupViewModel>(
      create: (context) => _viewModel,
      child: BlocConsumer<CreateGroupViewModel, CreateGroupViewState>(
        listener: (context, viewState) {
          viewState.when(
            initial: () {},
            loading: () {},
            ready: () {},
            creating: (message, progress) {},
            success: (group, message) {
              Navigator.of(context).pop(group);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
          );
        },
        builder: (context, viewState) {
          return _buildScaffold(context, viewState);
        },
      ),
    );
  }

  Widget _buildScaffold(BuildContext context, CreateGroupViewState viewState) {
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
      body: viewState.isLoading
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
      bottomNavigationBar: _buildBottomNavigation(viewState),
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
              sports: _viewModel.availableSports,
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
              selectedAvatarUrl: null,
              uploadedImagePath: null,
              sportType: null,
              onAvatarSelected: (url) => _viewModel.updateField('avatar', url),
              onImageUploaded: (url) => _viewModel.updateField('avatar', url),
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
                    suffixIcon: null,
                  ),
                  initialValue: '',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên nhóm';
                    }
                    if (value.trim().length < 3) {
                      return 'Tên nhóm phải có ít nhất 3 ký tự';
                    }
                    return null;
                  },
                  onChanged: (value) => _viewModel.updateField('name', value.trim()),
                ),
                // Name suggestions removed for simplicity
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
              initialValue: '',
              maxLines: 3,
              onChanged: (value) => _viewModel.updateField('description', value.trim()),
            ),
            const SizedBox(height: 16),

            // Level requirements
            // Always show level requirements for simplicity
            if (true) ...[
              LevelRequirementsWidget(
                sportType: null,
                selectedLevels: [],
                onLevelsChanged: (levels) => _viewModel.updateField('levelRequirements', levels),
              ),
              const SizedBox(height: 16),
            ],

            // Location
            LocationInputWidget(
              onLocationChanged: (location, city, district, lat, lng) {
                _viewModel.updateField('location', location);
                _viewModel.updateField('city', city);
                _viewModel.updateField('district', district);
                _viewModel.updateField('latitude', lat);
                _viewModel.updateField('longitude', lng);
              },
              sportType: null,
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
              monthlyFee: 0.0,
              privacy: _selectedPrivacy,
              rules: [],
              onMonthlyFeeChanged: (value) => _viewModel.updateField('monthlyFee', value),
              onPrivacyChanged: (value) {
                setState(() {
                  _selectedPrivacy = value;
                });
                _viewModel.updateField('privacy', value);
              },
              onRulesChanged: (value) => _viewModel.updateField('rules', _convertRulesFromList(value)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(CreateGroupViewState viewState) {
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
                onPressed: viewState.isLoading ? null : _previousStep,
                child: const Text('Trở lại'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: viewState.isLoading ? null : () {
                if (_currentStep < _totalSteps - 1) {
                  String? validationError = _validateCurrentStep();
                  
                  if (validationError == null) {
                    _nextStep();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(validationError)),
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


  List<String> _convertRulesToList(Map<String, dynamic> rulesMap) {
    if (rulesMap.containsKey('rules') && rulesMap['rules'] is List) {
      return List<String>.from(rulesMap['rules']);
    }
    return [];
  }

  Map<String, dynamic> _convertRulesFromList(List<String> rulesList) {
    return rulesList.isNotEmpty ? {'rules': rulesList} : {};
  }

  @override
  void dispose() {
    _pageController.dispose();
    _viewModel.close();
    super.dispose();
  }
}