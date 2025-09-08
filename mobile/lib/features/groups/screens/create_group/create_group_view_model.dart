import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/sport.dart';
import '../../services/groups_service.dart';
import 'create_group_state.dart';

/// ViewModel for Create Group Screen using Cubit pattern
/// 
/// Handles Vietnamese group creation form, validation, and submission
/// Supports Vietnamese sports types and cultural group patterns
@injectable
class CreateGroupViewModel extends Cubit<CreateGroupViewState> {
  final GroupsService _groupsService;
  
  // Form state
  Map<String, dynamic> _formData = {};
  List<Sport> _availableSports = [];
  
  CreateGroupViewModel(
    this._groupsService,
  ) : super(const CreateGroupViewState.initial());

  /// Initialize create group screen
  Future<void> initialize() async {
    emit(const CreateGroupViewState.loading());
    
    try {
      // Load available sports
      _availableSports = await _groupsService.getAvailableSports();
      
      // Initialize form data
      _formData = {
        'name': '',
        'description': '',
        'sportType': null,
        'location': '',
        'city': '',
        'district': '',
        'monthlyFee': 0.0,
        'privacy': null,
        'levelRequirements': <String>[],
        'rules': <String, dynamic>{},
        'schedule': <String, dynamic>{},
        'avatar': null,
        'latitude': null,
        'longitude': null,
      };
      
      emit(const CreateGroupViewState.ready());
      
      if (kDebugMode) {
        debugPrint('CreateGroupViewModel: Screen initialized with ${_availableSports.length} sports');
      }
      
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('CreateGroupViewModel initialize error: $error');
        debugPrint('Stack trace: $stackTrace');
      }
      
      emit(CreateGroupViewState.error(
        message: _getVietnameseErrorMessage(error),
      ));
    }
  }

  /// Update a form field
  void updateField(String field, dynamic value) {
    _formData[field] = value;
    if (kDebugMode) {
      debugPrint('CreateGroupViewModel: Updated $field = $value');
    }
  }
  
  /// Get available sports
  List<Sport> get availableSports => _availableSports;

  /// Create group with form data
  Future<void> createGroup() async {
    if (isClosed) return; // Prevent emit after dispose
    
    // Validate form
    final validationErrors = _validateForm();
    if (validationErrors.isNotEmpty) {
      emit(CreateGroupViewState.error(
        message: validationErrors.values.first,
      ));
      return;
    }
    
    emit(CreateGroupViewState.creating(
      message: 'Đang tạo nhóm "${_formData['name']}"...',
      progress: 10,
    ));
    
    try {
      // Simulate progress updates
      await Future.delayed(const Duration(milliseconds: 500));
      emit(CreateGroupViewState.creating(
        message: 'Đang xử lý thông tin nhóm...',
        progress: 40,
      ));
      
      // Create group via API
      final createdGroup = await _groupsService.createGroup(
        name: _formData['name']?.toString().trim() ?? '',
        description: _formData['description']?.toString().trim().isNotEmpty == true 
            ? _formData['description']?.toString().trim() : null,
        sportType: _formData['sportType'] as String,
        levelRequirements: _formData['levelRequirements'] as List<String>? ?? [],
        location: _formData['location']?.toString().trim() ?? '',
        city: _formData['city']?.toString().trim() ?? '',
        district: _formData['district']?.toString().trim().isNotEmpty == true 
            ? _formData['district']?.toString().trim() : null,
        latitude: _formData['latitude'] as double?,
        longitude: _formData['longitude'] as double?,
        schedule: _formData['schedule'] as Map<String, dynamic>?,
        monthlyFee: _formData['monthlyFee'] as double? ?? 0.0,
        privacy: _formData['privacy'] as String,
        avatar: _formData['avatar'] as String?,
        rules: _formData['rules'] as Map<String, dynamic>?,
      );
      
      await Future.delayed(const Duration(milliseconds: 300));
      emit(CreateGroupViewState.creating(
        message: 'Đang hoàn tất thiết lập...',
        progress: 80,
      ));
      
      await Future.delayed(const Duration(milliseconds: 200));
      
      // Success!
      emit(CreateGroupViewState.success(
        group: createdGroup,
        message: 'Đã tạo nhóm "${createdGroup.name}" thành công!',
      ));
      
      if (kDebugMode) {
        debugPrint('CreateGroupViewModel: Successfully created group ${createdGroup.id}: ${createdGroup.name}');
      }
      
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('CreateGroupViewModel createGroup error: $error');
        debugPrint('Stack trace: $stackTrace');
      }
      
      if (!isClosed) {
        emit(CreateGroupViewState.error(
          message: _getVietnameseErrorMessage(error),
        ));
      }
    }
  }

  /// Reset form to initial state
  Future<void> resetForm() async {
    if (isClosed) return;
    
    await initialize();
  }

  /// Clear current error state
  void clearError() {
    if (isClosed) return;
    
    emit(const CreateGroupViewState.ready());
  }
  
  /// Validate form data
  Map<String, String> _validateForm() {
    final errors = <String, String>{};
    
    final name = _formData['name']?.toString().trim() ?? '';
    if (name.isEmpty) {
      errors['name'] = 'Tên nhóm không được để trống';
    } else if (name.length < 3) {
      errors['name'] = 'Tên nhóm phải có ít nhất 3 ký tự';
    } else if (name.length > 100) {
      errors['name'] = 'Tên nhóm không được dài quá 100 ký tự';
    }
    
    if (_formData['sportType'] == null) {
      errors['sportType'] = 'Vui lòng chọn loại thể thao';
    }
    
    final location = _formData['location']?.toString().trim() ?? '';
    if (location.isEmpty) {
      errors['location'] = 'Địa điểm không được để trống';
    }
    
    final city = _formData['city']?.toString().trim() ?? '';
    if (city.isEmpty) {
      errors['city'] = 'Thành phố không được để trống';
    }
    
    if (_formData['privacy'] == null) {
      errors['privacy'] = 'Vui lòng chọn quyền riêng tư';
    }
    
    final description = _formData['description']?.toString() ?? '';
    if (description.length > 500) {
      errors['description'] = 'Mô tả không được dài quá 500 ký tự';
    }
    
    final monthlyFee = _formData['monthlyFee'] as double? ?? 0.0;
    if (monthlyFee < 0) {
      errors['monthlyFee'] = 'Phí hàng tháng không được âm';
    }
    
    if (monthlyFee > 10000000) {
      errors['monthlyFee'] = 'Phí hàng tháng không được quá 10,000,000 VND';
    }
    
    return errors;
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
  void onChange(Change<CreateGroupViewState> change) {
    super.onChange(change);
    
    if (kDebugMode) {
      debugPrint('CreateGroupViewModel state changed: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}');
    }
  }

  @override
  Future<void> close() {
    if (kDebugMode) {
      debugPrint('CreateGroupViewModel closed');
    }
    return super.close();
  }
}