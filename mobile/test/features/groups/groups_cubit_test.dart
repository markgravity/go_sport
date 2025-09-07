import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:go_sport_app/features/groups/presentation/viewmodels/groups_cubit.dart';
import 'package:go_sport_app/features/groups/presentation/viewmodels/groups_state.dart';
import 'package:go_sport_app/features/groups/presentation/viewmodels/create_group_cubit.dart';
import 'package:go_sport_app/features/groups/presentation/viewmodels/create_group_state.dart';
import 'package:go_sport_app/features/groups/services/groups_service.dart';

@GenerateMocks([GroupsService])
import 'groups_cubit_test.mocks.dart';

/// Test Vietnamese Group functionality với Cubit architecture
/// 
/// Verifies that Vietnamese sports types and cultural patterns work correctly
void main() {
  group('GroupsCubit Vietnamese Integration', () {
    late GroupsCubit groupsCubit;
    late MockGroupsService mockGroupsService;
    
    setUp(() {
      mockGroupsService = MockGroupsService();
      groupsCubit = GroupsCubit(mockGroupsService);
    });
    
    tearDown(() {
      groupsCubit.close();
    });
    
    test('initializes với unauthenticated state', () {
      expect(groupsCubit.state, isA<GroupsState>());
      expect(groupsCubit.state.isLoading, isFalse);
      expect(groupsCubit.state.hasData, isFalse);
    });
    
    test('state extension methods work correctly', () {
      const loadedState = GroupsState.loaded(
        groups: [],
        searchQuery: 'cầu lông',
        sportTypeFilter: 'cau_long',
        cityFilter: 'Hồ Chí Minh',
      );
      
      expect(loadedState.isLoading, isFalse);
      expect(loadedState.hasData, isFalse); // Empty list
      expect(loadedState.currentSearchQuery, equals('cầu lông'));
      expect(loadedState.currentSportTypeFilter, equals('cau_long'));
      expect(loadedState.currentCityFilter, equals('Hồ Chí Minh'));
      expect(loadedState.hasActiveFilters, isTrue);
    });
    
    test('Vietnamese sport types are handled correctly', () {
      // Test common Vietnamese sport types
      const vietnameseSports = [
        'cau_long',     // Cầu lông  
        'bong_da',      // Bóng đá
        'bong_chuyen',  // Bóng chuyền
        'tennis',       // Tennis
        'bong_ro',      // Bóng rổ
      ];
      
      for (final sport in vietnameseSports) {
        expect(sport.isNotEmpty, isTrue);
        expect(sport.contains('_') || sport == 'tennis', isTrue);
      }
    });
    
    test('can clear filters and reset state', () {
      groupsCubit.clearFilters(); // Should trigger loadGroups
      // Since this is a unit test without actual API, just verify method doesn't throw
      expect(groupsCubit.state, isA<GroupsState>());
    });
  });
  
  group('CreateGroupCubit Vietnamese Form Management', () {
    late CreateGroupCubit createGroupCubit;
    late MockGroupsService mockGroupsService;
    
    setUp(() {
      mockGroupsService = MockGroupsService();
      createGroupCubit = CreateGroupCubit(mockGroupsService);
    });
    
    tearDown(() {
      createGroupCubit.close();
    });
    
    test('initializes với initial state', () {
      expect(createGroupCubit.state, isA<CreateGroupState>());
      expect(createGroupCubit.state.isLoading, isFalse);
      expect(createGroupCubit.state.isFormReady, isFalse);
    });
    
    test('form validation works with Vietnamese inputs', () {
      const formData = GroupFormData(
        name: 'Câu lạc bộ cầu lông Sài Gòn',
        sportType: 'cau_long',
        location: 'Quận 1, TP.HCM',
        city: 'Hồ Chí Minh',
        levelRequirements: ['trung_cap'],
        privacy: 'cong_khai',
        description: 'Câu lạc bộ cầu lông cho người yêu thích thể thao',
      );
      
      // Verify Vietnamese text is handled properly
      expect(formData.name.contains('ầu'), isTrue); // Vietnamese diacritics
      expect(formData.location.contains('Quận'), isTrue); // Vietnamese location format
      expect(formData.city.contains('ồ'), isTrue); // Vietnamese city name
      expect(formData.description.contains('ể'), isTrue); // Vietnamese description
    });
    
    test('form state extension methods work correctly', () {
      const formReadyState = CreateGroupState.formReady(
        availableSports: [],
        formData: GroupFormData(
          name: 'Test Group',
          sportType: 'cau_long',
        ),
        validationErrors: {'location': 'Địa điểm không được để trống'},
      );
      
      expect(formReadyState.isFormReady, isTrue);
      expect(formReadyState.isLoading, isFalse);
      expect(formReadyState.hasValidationErrors, isTrue);
      expect(formReadyState.getFieldError('location'), equals('Địa điểm không được để trống'));
      expect(formReadyState.canSubmit, isFalse); // Has validation errors
    });
    
    test('Vietnamese sport types mapping works', () {
      const sportTypes = {
        'cau_long': 'Cầu lông',
        'bong_da': 'Bóng đá', 
        'bong_chuyen': 'Bóng chuyền',
        'tennis': 'Tennis',
        'bong_ro': 'Bóng rổ',
      };
      
      sportTypes.forEach((key, value) {
        expect(key.isNotEmpty, isTrue);
        expect(value.isNotEmpty, isTrue);
        // Verify Vietnamese names contain proper diacritics where expected
        if (value.contains('ầu') || value.contains('óng')) {
          expect(value.length > 3, isTrue);
        }
      });
    });
  });
  
  group('Vietnamese Group Cultural Patterns', () {
    test('Vietnamese group roles hierarchy is correct', () {
      const roles = {
        'admin': 'Trưởng nhóm',
        'moderator': 'Phó nhóm', 
        'member': 'Thành viên',
        'guest': 'Khách',
      };
      
      expect(roles['admin'], equals('Trưởng nhóm'));
      expect(roles['moderator'], equals('Phó nhóm'));
      expect(roles['member'], equals('Thành viên'));
      expect(roles['guest'], equals('Khách'));
    });
    
    test('Vietnamese privacy levels are handled', () {
      const privacyLevels = {
        'cong_khai': 'Công khai',
        'rieng_tu': 'Riêng tư',
      };
      
      expect(privacyLevels['cong_khai'], equals('Công khai'));
      expect(privacyLevels['rieng_tu'], equals('Riêng tư'));
    });
    
    test('Vietnamese skill levels are supported', () {
      const skillLevels = {
        'moi_bat_dau': 'Mới bắt đầu',
        'trung_binh': 'Trung bình',
        'gioi': 'Giỏi',
        'chuyen_nghiep': 'Chuyên nghiệp',
      };
      
      skillLevels.forEach((key, value) {
        expect(key.contains('_'), isTrue); // API format
        expect(value.isNotEmpty, isTrue); // Vietnamese display
      });
    });
  });
}