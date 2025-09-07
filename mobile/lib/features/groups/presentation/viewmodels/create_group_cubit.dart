import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/sport.dart';
import '../../services/groups_service.dart';
import 'create_group_state.dart';

/// CreateGroupCubit cho Group Creation Form
/// 
/// Migrate từ CreateGroupProvider sang Cubit architecture với Vietnamese validation:
/// - Form management với Vietnamese sports types
/// - Vietnamese location và name suggestions
/// - Cultural patterns trong group creation
/// - Vietnamese validation messages
@injectable
class CreateGroupCubit extends Cubit<CreateGroupState> {
  final GroupsService _groupsService;
  
  CreateGroupCubit(this._groupsService) : super(const CreateGroupState.initial());

  /// Initialize form với sports data và suggestions
  Future<void> initializeForm() async {
    try {
      emit(const CreateGroupState.loadingForm());
      
      // Load available sports
      final sports = await _groupsService.getAvailableSports();
      
      emit(CreateGroupState.formReady(
        availableSports: sports,
        formData: const GroupFormData(),
      ));
      
      if (kDebugMode) {
        debugPrint('CreateGroupCubit: Form initialized with ${sports.length} sports');
      }
      
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('CreateGroupCubit initializeForm error: $error');
        debugPrint('Stack trace: $stackTrace');
      }
      
      emit(CreateGroupState.error(
        message: _getVietnameseErrorMessage(error),
        exception: error,
        errorCode: 'INIT_FORM_ERROR',
      ));
    }
  }

  /// Update form field và trigger validation
  Future<void> updateField(String field, dynamic value) async {
    final currentState = state;
    if (!currentState.isFormReady) return;

    final currentFormData = currentState.currentFormData;
    GroupFormData updatedFormData;

    // Update specific field
    switch (field) {
      case 'name':
        updatedFormData = currentFormData.copyWith(name: value as String);
        break;
      case 'description':
        updatedFormData = currentFormData.copyWith(description: value as String);
        break;
      case 'sportType':
        updatedFormData = currentFormData.copyWith(sportType: value as String?);
        // Load suggestions khi sport type thay đổi
        if (value != null) {
          _loadSportSuggestions(value, currentState, updatedFormData);
          return; // _loadSportSuggestions sẽ emit state mới
        }
        break;
      case 'skillLevel':
        updatedFormData = currentFormData.copyWith(skillLevel: value as String?);
        break;
      case 'location':
        updatedFormData = currentFormData.copyWith(location: value as String);
        break;
      case 'city':
        updatedFormData = currentFormData.copyWith(city: value as String);
        break;
      case 'district':
        updatedFormData = currentFormData.copyWith(district: value as String);
        break;
      case 'maxMembers':
        updatedFormData = currentFormData.copyWith(maxMembers: value as int?);
        break;
      case 'membershipFee':
        updatedFormData = currentFormData.copyWith(membershipFee: value as double);
        break;
      case 'privacy':
        updatedFormData = currentFormData.copyWith(privacy: value as String?);
        break;
      case 'schedule':
        updatedFormData = currentFormData.copyWith(schedule: value as Map<String, dynamic>);
        break;
      case 'rules':
        updatedFormData = currentFormData.copyWith(rules: value as Map<String, dynamic>);
        break;
      default:
        return; // Unknown field
    }

    // Validate field và emit new state
    final validationErrors = _validateForm(updatedFormData);
    
    state.when(
      initial: () {},
      loadingForm: (_) {},
      formReady: (sports, locations, names, defaults, _, __, isValidating) {
        emit(CreateGroupState.formReady(
          availableSports: sports,
          locationSuggestions: locations,
          nameSuggestions: names,
          sportDefaults: defaults,
          validationErrors: validationErrors,
          formData: updatedFormData,
          isValidating: isValidating,
        ));
      },
      creating: (_, __, ___) {},
      success: (_, __) {},
      error: (_, __, ___, ____, _____) {},
    );
  }

  /// Load suggestions khi sport type thay đổi
  Future<void> _loadSportSuggestions(
    String sportType,
    CreateGroupState currentState,
    GroupFormData updatedFormData,
  ) async {
    try {
      // Show loading state for validation - skip for now

      // Load suggestions parallel
      final futures = await Future.wait([
        _groupsService.getLocationSuggestions(sportType, city: updatedFormData.city.isNotEmpty ? updatedFormData.city : null),
        _groupsService.getNameSuggestions(sportType, city: updatedFormData.city.isNotEmpty ? updatedFormData.city : null),
        _groupsService.getSportDefaults(sportType),
      ]);

      final locationSuggestions = futures[0] as List<String>;
      final nameSuggestions = futures[1] as List<String>;
      final sportDefaults = futures[2] as SportDefaults;

      // Apply sport defaults if form fields are empty
      var finalFormData = updatedFormData;
      if (finalFormData.maxMembers == null) {
        finalFormData = finalFormData.copyWith(maxMembers: sportDefaults.maxMembers);
      }

      final validationErrors = _validateForm(finalFormData);

      emit(CreateGroupState.formReady(
        availableSports: currentState.availableSports,
        formData: finalFormData,
        locationSuggestions: locationSuggestions,
        nameSuggestions: nameSuggestions,
        sportDefaults: sportDefaults,
        validationErrors: validationErrors,
        isValidating: false,
      ));

      if (kDebugMode) {
        debugPrint('CreateGroupCubit: Loaded ${locationSuggestions.length} locations, ${nameSuggestions.length} names for $sportType');
      }

    } catch (error) {
      if (kDebugMode) {
        debugPrint('CreateGroupCubit _loadSportSuggestions error: $error');
      }

      // Emit form state with error in validation
      emit(CreateGroupState.formReady(
        availableSports: currentState.availableSports,
        locationSuggestions: currentState.locationSuggestions,
        nameSuggestions: currentState.nameSuggestions,
        sportDefaults: currentState.sportDefaults,
        formData: updatedFormData,
        validationErrors: {
          'sportType': 'Không thể tải gợi ý cho loại thể thao này',
          ..._validateForm(updatedFormData),
        },
        isValidating: false,
      ));
    }
  }

  /// Validate entire form và trả về errors
  Map<String, String> _validateForm(GroupFormData formData) {
    final errors = <String, String>{};

    // Validate required fields
    if (formData.name.trim().isEmpty) {
      errors['name'] = 'Tên nhóm không được để trống';
    } else if (formData.name.trim().length < 3) {
      errors['name'] = 'Tên nhóm phải có ít nhất 3 ký tự';
    } else if (formData.name.length > 100) {
      errors['name'] = 'Tên nhóm không được dài quá 100 ký tự';
    }

    if (formData.sportType == null) {
      errors['sportType'] = 'Vui lòng chọn loại thể thao';
    }

    if (formData.location.trim().isEmpty) {
      errors['location'] = 'Địa điểm không được để trống';
    }

    if (formData.city.trim().isEmpty) {
      errors['city'] = 'Thành phố không được để trống';
    }

    if (formData.skillLevel == null) {
      errors['skillLevel'] = 'Vui lòng chọn mức độ kỹ năng';
    }

    if (formData.privacy == null) {
      errors['privacy'] = 'Vui lòng chọn quyền riêng tư';
    }

    // Validate optional fields
    if (formData.description.length > 500) {
      errors['description'] = 'Mô tả không được dài quá 500 ký tự';
    }

    if (formData.maxMembers != null && formData.maxMembers! < 2) {
      errors['maxMembers'] = 'Số thành viên tối đa phải ít nhất 2 người';
    }

    if (formData.maxMembers != null && formData.maxMembers! > 200) {
      errors['maxMembers'] = 'Số thành viên tối đa không được quá 200 người';
    }

    if (formData.membershipFee < 0) {
      errors['membershipFee'] = 'Phí thành viên không được âm';
    }

    if (formData.membershipFee > 10000000) { // 10 million VND
      errors['membershipFee'] = 'Phí thành viên không được quá 10,000,000 VND';
    }

    return errors;
  }

  /// Submit form và tạo nhóm mới
  Future<void> createGroup() async {
    final currentState = state;
    if (!currentState.isFormReady) return;

    final formData = currentState.currentFormData;

    // Final validation before submit
    final validationErrors = _validateForm(formData);
    if (validationErrors.isNotEmpty) {
      emit(CreateGroupState.formReady(
        availableSports: currentState.availableSports,
        locationSuggestions: currentState.locationSuggestions,
        nameSuggestions: currentState.nameSuggestions,
        sportDefaults: currentState.sportDefaults,
        formData: formData,
        validationErrors: validationErrors,
      ));
      return;
    }

    try {
      // Start creation process
      emit(CreateGroupState.creating(
        formData: formData,
        message: 'Đang tạo nhóm "${formData.name}"...',
        progress: 10,
      ));

      // Simulate progress updates
      await Future.delayed(const Duration(milliseconds: 500));
      emit(CreateGroupState.creating(
        formData: formData,
        message: 'Đang xử lý thông tin nhóm...',
        progress: 40,
      ));

      // Create group via API
      final createdGroup = await _groupsService.createGroup(
        name: formData.name.trim(),
        description: formData.description.trim().isNotEmpty ? formData.description.trim() : null,
        sportType: formData.sportType!,
        skillLevel: formData.skillLevel!,
        location: formData.location.trim(),
        city: formData.city.trim(),
        district: formData.district.trim().isNotEmpty ? formData.district.trim() : null,
        latitude: formData.latitude,
        longitude: formData.longitude,
        schedule: formData.schedule.isNotEmpty ? formData.schedule : null,
        maxMembers: formData.maxMembers,
        membershipFee: formData.membershipFee,
        privacy: formData.privacy!,
        avatar: formData.avatar,
        rules: formData.rules.isNotEmpty ? formData.rules : null,
      );

      await Future.delayed(const Duration(milliseconds: 300));
      emit(CreateGroupState.creating(
        formData: formData,
        message: 'Đang hoàn tất thiết lập...',
        progress: 80,
      ));

      await Future.delayed(const Duration(milliseconds: 200));
      
      // Success!
      emit(CreateGroupState.success(
        createdGroup: createdGroup,
        message: 'Đã tạo nhóm "${createdGroup.name}" thành công!',
      ));

      if (kDebugMode) {
        debugPrint('CreateGroupCubit: Successfully created group ${createdGroup.id}: ${createdGroup.name}');
      }

    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('CreateGroupCubit createGroup error: $error');
        debugPrint('Stack trace: $stackTrace');
      }

      emit(CreateGroupState.error(
        message: _getVietnameseErrorMessage(error),
        formData: formData,
        validationErrors: _parseServerValidationErrors(error),
        exception: error,
        errorCode: 'CREATE_GROUP_ERROR',
      ));
    }
  }

  /// Parse server validation errors
  Map<String, String> _parseServerValidationErrors(Object error) {
    final errors = <String, String>{};
    final errorString = error.toString().toLowerCase();

    // Parse common server validation errors
    if (errorString.contains('name') && errorString.contains('unique')) {
      errors['name'] = 'Tên nhóm đã tồn tại. Vui lòng chọn tên khác.';
    }
    
    if (errorString.contains('sport_type') && errorString.contains('invalid')) {
      errors['sportType'] = 'Loại thể thao không hợp lệ.';
    }

    if (errorString.contains('location')) {
      errors['location'] = 'Địa điểm không hợp lệ.';
    }

    if (errorString.contains('max_members')) {
      errors['maxMembers'] = 'Số thành viên tối đa không hợp lệ.';
    }

    return errors;
  }

  /// Reset form về trạng thái ban đầu
  Future<void> resetForm() async {
    await initializeForm();
  }

  /// Clear error và quay về form ready state
  void clearError() {
    final currentState = state;
    if (currentState.hasError) {
      emit(CreateGroupState.formReady(
        availableSports: state.availableSports,
        formData: currentState.currentFormData,
        validationErrors: currentState.validationErrors,
      ));
    }
  }

  /// Auto-fill location field từ suggestion
  void selectLocationSuggestion(String location) {
    updateField('location', location);
  }

  /// Auto-fill name field từ suggestion
  void selectNameSuggestion(String name) {
    updateField('name', name);
  }

  /// Apply sport defaults khi user chọn "sử dụng mặc định"
  void applySportDefaults() {
    final currentState = state;
    if (!currentState.isFormReady || currentState.sportDefaults == null) return;

    final defaults = currentState.sportDefaults!;
    var updatedFormData = currentState.currentFormData;

    updatedFormData = updatedFormData.copyWith(maxMembers: defaults.maxMembers);

    final validationErrors = _validateForm(updatedFormData);
    
    emit(CreateGroupState.formReady(
      availableSports: currentState.availableSports,
      locationSuggestions: currentState.locationSuggestions,
      nameSuggestions: currentState.nameSuggestions,
      sportDefaults: defaults,
      formData: updatedFormData,
      validationErrors: validationErrors,
    ));
  }

  /// Get group name suggestions based on current form
  List<String> getFilteredNameSuggestions() {
    final currentState = state;
    if (!currentState.isFormReady) return [];

    final query = currentState.currentFormData.name.toLowerCase();
    if (query.isEmpty) return currentState.nameSuggestions;

    return currentState.nameSuggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query))
        .toList();
  }

  /// Get location suggestions based on current form
  List<String> getFilteredLocationSuggestions() {
    final currentState = state;
    if (!currentState.isFormReady) return [];

    final query = currentState.currentFormData.location.toLowerCase();
    if (query.isEmpty) return currentState.locationSuggestions;

    return currentState.locationSuggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query))
        .toList();
  }

  /// Transform error thành Vietnamese message
  String _getVietnameseErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Lỗi kết nối mạng. Vui lòng kiểm tra kết nối internet và thử lại.';
    }
    
    if (errorString.contains('timeout')) {
      return 'Kết nối quá chậm. Vui lòng thử lại.';
    }
    
    if (errorString.contains('unauthorized') || errorString.contains('401')) {
      return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
    }
    
    if (errorString.contains('forbidden') || errorString.contains('403')) {
      return 'Bạn không có quyền tạo nhóm.';
    }
    
    if (errorString.contains('conflict') || errorString.contains('409')) {
      return 'Tên nhóm đã tồn tại. Vui lòng chọn tên khác.';
    }
    
    if (errorString.contains('validation')) {
      return 'Thông tin form chưa đúng. Vui lòng kiểm tra lại.';
    }
    
    if (errorString.contains('server') || errorString.contains('500')) {
      return 'Lỗi hệ thống. Vui lòng thử lại sau.';
    }
    
    // Default Vietnamese error message
    return 'Có lỗi xảy ra khi tạo nhóm. Vui lòng thử lại.';
  }

  @override
  void onChange(Change<CreateGroupState> change) {
    super.onChange(change);
    
    if (kDebugMode) {
      debugPrint('CreateGroupCubit state changed: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}');
    }
  }

  @override
  Future<void> close() {
    if (kDebugMode) {
      debugPrint('CreateGroupCubit closed');
    }
    return super.close();
  }
}