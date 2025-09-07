import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/dependency_injection/injection_container.dart';
import '../models/sport.dart';
import '../presentation/viewmodels/create_group_cubit.dart';
import '../presentation/viewmodels/create_group_state.dart';
import '../widgets/sport_selection_widget.dart';
import '../widgets/location_input_widget.dart';
import '../widgets/group_settings_widget.dart';
import '../widgets/avatar_selection_widget.dart';
import '../widgets/level_requirements_widget.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  late final CreateGroupCubit _createGroupCubit;
  
  int _currentStep = 0;
  final int _totalSteps = 3;

  bool _showNameSuggestions = false;

  @override
  void initState() {
    super.initState();
    _createGroupCubit = getIt<CreateGroupCubit>();
    _createGroupCubit.initializeForm();
  }


  void _onSportSelected(Sport sport) {
    _createGroupCubit.updateField('sportType', sport.key);
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
    debugPrint('_createGroup called');
    
    if (!_formKey.currentState!.validate()) {
      debugPrint('Form validation failed');
      return;
    }
    
    debugPrint('Form validation passed, calling cubit.createGroup()');
    await _createGroupCubit.createGroup();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateGroupCubit>(
      create: (context) => _createGroupCubit,
      child: BlocConsumer<CreateGroupCubit, CreateGroupState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loadingForm: (_) {},
            formReady: (_, __, ___, ____, _____, ______, _______) {},
            creating: (_, __, ___) {},
            success: (group, message) {
              Navigator.of(context).pop(group);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tạo nhóm "${group.name}" thành công!'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
            error: (message, _, __, ___, ____) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
          );
        },
        builder: (context, state) => _buildScaffold(context, state),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context, CreateGroupState state) {
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
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSportSelectionStep(state),
                  _buildBasicInfoStep(state),
                  _buildSettingsStep(state),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNavigation(state),
    );
  }

  Widget _buildSportSelectionStep(CreateGroupState state) {
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
              sports: state.availableSports,
              selectedSport: _getSelectedSport(state),
              onSportSelected: _onSportSelected,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep(CreateGroupState state) {
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
              selectedAvatarUrl: state.currentFormData.avatar,
              uploadedImagePath: null,
              sportType: state.currentFormData.sportType,
              onAvatarSelected: (url) => _createGroupCubit.updateField('avatar', url),
              onImageUploaded: (url) => _createGroupCubit.updateField('avatar', url),
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
                    suffixIcon: state.nameSuggestions.isNotEmpty 
                      ? IconButton(
                          icon: Icon(_showNameSuggestions ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                          onPressed: () => setState(() => _showNameSuggestions = !_showNameSuggestions),
                        )
                      : null,
                  ),
                  initialValue: state.currentFormData.name,
                  validator: (value) {
                    final error = state.getFieldError('name');
                    if (error != null) return error;
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên nhóm';
                    }
                    if (value.trim().length < 3) {
                      return 'Tên nhóm phải có ít nhất 3 ký tự';
                    }
                    return null;
                  },
                  onChanged: (value) => _createGroupCubit.updateField('name', value.trim()),
                ),
                if (_showNameSuggestions && state.nameSuggestions.isNotEmpty) ...[
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
                        ...(state.nameSuggestions.take(5).map((suggestion) => ListTile(
                          dense: true,
                          title: Text(suggestion),
                          onTap: () {
                            _createGroupCubit.updateField('name', suggestion);
                            setState(() => _showNameSuggestions = false);
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
              initialValue: state.currentFormData.description,
              maxLines: 3,
              onChanged: (value) => _createGroupCubit.updateField('description', value.trim()),
            ),
            const SizedBox(height: 16),

            // Level requirements
            if (_getSelectedSport(state) != null) ...[
              LevelRequirementsWidget(
                sportType: state.currentFormData.sportType,
                selectedLevels: state.currentFormData.levelRequirements,
                onLevelsChanged: (levels) => _createGroupCubit.updateField('levelRequirements', levels),
              ),
              const SizedBox(height: 16),
            ],

            // Location
            LocationInputWidget(
              onLocationChanged: (location, city, district, lat, lng) {
                _createGroupCubit.updateField('location', location);
                _createGroupCubit.updateField('city', city);
                _createGroupCubit.updateField('district', district);
                _createGroupCubit.updateField('latitude', lat);
                _createGroupCubit.updateField('longitude', lng);
              },
              sportType: state.currentFormData.sportType,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsStep(CreateGroupState state) {
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
              selectedSport: _getSelectedSport(state),
              monthlyFee: state.currentFormData.monthlyFee,
              privacy: state.currentFormData.privacy ?? 'cong_khai',
              rules: _convertRulesToList(state.currentFormData.rules),
              onMonthlyFeeChanged: (value) => _createGroupCubit.updateField('monthlyFee', value),
              onPrivacyChanged: (value) => _createGroupCubit.updateField('privacy', value),
              onRulesChanged: (value) => _createGroupCubit.updateField('rules', _convertRulesFromList(value)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(CreateGroupState state) {
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
                onPressed: state.isLoading ? null : _previousStep,
                child: const Text('Trở lại'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: state.isLoading ? null : () {
                debugPrint('Button pressed! Current step: $_currentStep, Total steps: $_totalSteps');
                
                if (_currentStep < _totalSteps - 1) {
                  debugPrint('Not final step, validating current step');
                  // Validate current step
                  bool canProceed = false;
                  switch (_currentStep) {
                    case 0:
                      canProceed = _getSelectedSport(state) != null;
                      debugPrint('Step 0 validation: canProceed = $canProceed');
                      break;
                    case 1:
                      canProceed = state.currentFormData.name.isNotEmpty && 
                                 state.currentFormData.location.isNotEmpty && 
                                 state.currentFormData.city.isNotEmpty;
                      debugPrint('Step 1 validation: canProceed = $canProceed');
                      break;
                    case 2:
                      canProceed = true;
                      debugPrint('Step 2 validation: canProceed = $canProceed');
                      break;
                  }
                  
                  if (canProceed) {
                    debugPrint('Proceeding to next step');
                    _nextStep();
                  } else {
                    debugPrint('Cannot proceed, showing snackbar');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng hoàn thành thông tin bước này')),
                    );
                  }
                } else {
                  debugPrint('Final step reached, calling _createGroup()');
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

  Sport? _getSelectedSport(CreateGroupState state) {
    if (state.currentFormData.sportType == null) return null;
    
    try {
      return state.availableSports.firstWhere(
        (sport) => sport.key == state.currentFormData.sportType,
      );
    } catch (_) {
      return null;
    }
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
    _createGroupCubit.close();
    super.dispose();
  }
}