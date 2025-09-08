import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:go_sport_app/features/groups/screens/create_group/create_group_view_model.dart';
import 'package:go_sport_app/features/groups/screens/create_group/create_group_state.dart';
import 'package:go_sport_app/features/groups/services/groups_service.dart';
import 'package:go_sport_app/features/groups/models/sport.dart';

import 'create_group_view_model_test.mocks.dart';

@GenerateMocks([GroupsService])
void main() {
  group('CreateGroupViewModel', () {
    late MockGroupsService mockGroupsService;
    late CreateGroupViewModel viewModel;
    final mockSports = [
      Sport(
        key: 'badminton',
        name: 'Cầu lông',
        englishName: 'Badminton',
        icon: 'sports',
        defaults: SportDefaults(
          maxMembers: 10,
          minPlayers: 2,
          maxPlayers: 4,
          notificationHours: 24,
          typicalDuration: 60,
          typicalLocations: ['Sân trong nhà'],
          equipmentNeeded: [],
        ),
        skillLevels: {},
      ),
    ];

    setUp(() {
      mockGroupsService = MockGroupsService();
      viewModel = CreateGroupViewModel(mockGroupsService);
    });

    group('initialize', () {
      test('should initialize successfully', () async {
        when(mockGroupsService.getAvailableSports())
            .thenAnswer((_) async => mockSports);

        expect(viewModel.state, const CreateGroupViewState.initial());
        
        await viewModel.initialize();
        
        expect(viewModel.state, const CreateGroupViewState.ready());
      });

      test('should handle initialization error', () async {
        when(mockGroupsService.getAvailableSports())
            .thenThrow(Exception('Network error'));

        expect(viewModel.state, const CreateGroupViewState.initial());
        
        await viewModel.initialize();
        
        expect(viewModel.state.when(
          initial: () => false,
          loading: () => false,
          ready: () => false,
          creating: (message, progress) => false,
          success: (group, message) => false,
          error: (message) => true,
        ), isTrue);
      });
    });

    group('form validation', () {
      test('should reject empty name', () async {
        when(mockGroupsService.getAvailableSports())
            .thenAnswer((_) async => []);
        
        await viewModel.initialize();
        
        viewModel.updateField('name', '');
        viewModel.updateField('sportType', 'badminton');
        viewModel.updateField('location', 'Hà Nội');
        viewModel.updateField('city', 'Hà Nội');
        
        await viewModel.createGroup();
        
        expect(viewModel.state.when(
          initial: () => false,
          loading: () => false,
          ready: () => false,
          creating: (message, progress) => false,
          success: (group, message) => false,
          error: (message) => message.contains('Tên nhóm'),
        ), isTrue);
      });

      test('should reject short name', () async {
        when(mockGroupsService.getAvailableSports())
            .thenAnswer((_) async => []);
        
        await viewModel.initialize();
        
        viewModel.updateField('name', 'AB');
        viewModel.updateField('sportType', 'badminton');
        viewModel.updateField('location', 'Hà Nội');
        viewModel.updateField('city', 'Hà Nội');
        
        await viewModel.createGroup();
        
        expect(viewModel.state.when(
          initial: () => false,
          loading: () => false,
          ready: () => false,
          creating: (message, progress) => false,
          success: (group, message) => false,
          error: (message) => message.contains('ít nhất 3 ký tự'),
        ), isTrue);
      });
    });

    group('field updates', () {
      test('should update form fields correctly', () {
        viewModel.updateField('name', 'Test Group');
        viewModel.updateField('sportType', 'badminton');
        viewModel.updateField('monthlyFee', 100000.0);
        
        // Form fields are private, so we can't directly test them
        // But we can verify the ViewModel doesn't crash
        expect(viewModel.state, const CreateGroupViewState.initial());
      });
    });

    group('resetForm', () {
      test('should reset form by reinitializing', () async {
        when(mockGroupsService.getAvailableSports())
            .thenAnswer((_) async => []);

        await viewModel.resetForm();
        
        expect(viewModel.state, const CreateGroupViewState.ready());
      });
    });

    group('clearError', () {
      test('should clear error state and return to ready', () {
        viewModel.clearError();
        expect(viewModel.state, const CreateGroupViewState.ready());
      });
    });

    group('state verification', () {
      test('should handle different state types', () {
        const initialState = CreateGroupViewState.initial();
        const loadingState = CreateGroupViewState.loading();
        const readyState = CreateGroupViewState.ready();
        const errorState = CreateGroupViewState.error(message: 'Error');

        expect(initialState.when(
          initial: () => true,
          loading: () => false,
          ready: () => false,
          creating: (_, __) => false,
          success: (_, __) => false,
          error: (_) => false,
        ), isTrue);

        expect(loadingState.when(
          initial: () => false,
          loading: () => true,
          ready: () => false,
          creating: (_, __) => false,
          success: (_, __) => false,
          error: (_) => false,
        ), isTrue);

        expect(readyState.when(
          initial: () => false,
          loading: () => false,
          ready: () => true,
          creating: (_, __) => false,
          success: (_, __) => false,
          error: (_) => false,
        ), isTrue);

        expect(errorState.when(
          initial: () => false,
          loading: () => false,
          ready: () => false,
          creating: (_, __) => false,
          success: (_, __) => false,
          error: (_) => true,
        ), isTrue);
      });
    });
  });
}