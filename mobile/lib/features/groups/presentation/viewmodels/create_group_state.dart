import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/group.dart';
import '../../models/sport.dart';

part 'create_group_state.freezed.dart';

/// CreateGroupState cho Group Creation Form
/// 
/// Quản lý trạng thái form tạo nhóm với Vietnamese validation
/// Hỗ trợ Vietnamese sports types và cultural patterns
@freezed
class CreateGroupState with _$CreateGroupState {
  /// Trạng thái ban đầu khi form chưa load
  const factory CreateGroupState.initial() = _Initial;
  
  /// Trạng thái đang load form dependencies (sports, locations)
  const factory CreateGroupState.loadingForm({
    /// Thông báo loading
    @Default('Đang tải form...') String message,
  }) = _LoadingForm;
  
  /// Trạng thái form đã sẵn sàng để nhập liệu
  const factory CreateGroupState.formReady({
    /// Danh sách sports có sẵn
    @Default([]) List<Sport> availableSports,
    /// Location suggestions cho sport type hiện tại
    @Default([]) List<String> locationSuggestions,
    /// Name suggestions cho sport type hiện tại
    @Default([]) List<String> nameSuggestions,
    /// Sport defaults cho sport type hiện tại
    SportDefaults? sportDefaults,
    /// Form validation errors
    @Default({}) Map<String, String> validationErrors,
    /// Form data
    @Default(GroupFormData()) GroupFormData formData,
    /// Có đang validate form không
    @Default(false) bool isValidating,
  }) = _FormReady;
  
  /// Trạng thái đang tạo nhóm
  const factory CreateGroupState.creating({
    /// Form data đang được submit
    required GroupFormData formData,
    /// Progress message
    @Default('Đang tạo nhóm...') String message,
    /// Progress percentage (0-100)
    @Default(0) int progress,
  }) = _Creating;
  
  /// Trạng thái tạo thành công
  const factory CreateGroupState.success({
    /// Nhóm đã được tạo
    required Group createdGroup,
    /// Thông báo thành công
    required String message,
  }) = _Success;
  
  /// Trạng thái lỗi
  const factory CreateGroupState.error({
    /// Thông báo lỗi bằng tiếng Việt
    required String message,
    /// Form data hiện tại (để preserve)
    @Default(GroupFormData()) GroupFormData formData,
    /// Validation errors chi tiết
    @Default({}) Map<String, String> validationErrors,
    /// Exception gốc
    Object? exception,
    /// Error code
    String? errorCode,
  }) = _CreateGroupError;
}

/// Data class cho form tạo nhóm
@freezed
class GroupFormData with _$GroupFormData {
  const factory GroupFormData({
    /// Tên nhóm (bắt buộc)
    @Default('') String name,
    /// Mô tả nhóm
    @Default('') String description,
    /// Loại thể thao (bắt buộc)
    String? sportType,
    /// Yêu cầu cấp độ (tùy chọn, đa chọn)
    @Default([]) List<String> levelRequirements,
    /// Địa điểm (bắt buộc)
    @Default('') String location,
    /// Thành phố (bắt buộc)
    @Default('') String city,
    /// Quận/Huyện
    @Default('') String district,
    /// Tọa độ latitude
    double? latitude,
    /// Tọa độ longitude  
    double? longitude,
    /// Lịch hoạt động
    @Default({}) Map<String, dynamic> schedule,
    /// Phí hàng tháng (VND)
    @Default(0.0) double monthlyFee,
    /// Quyền riêng tư (cong_khai/rieng_tu)
    String? privacy,
    /// Avatar URL
    String? avatar,
    /// Quy tắc nhóm
    @Default({}) Map<String, dynamic> rules,
    /// Custom fields for Vietnamese cultural patterns
    @Default({}) Map<String, dynamic> customFields,
  }) = _GroupFormData;
}

/// Extension methods for CreateGroupState
extension CreateGroupStateExtension on CreateGroupState {
  /// Kiểm tra có đang loading không
  bool get isLoading => when(
    initial: () => false,
    loadingForm: (_) => true,
    formReady: (_, __, ___, ____, _____, ______, _______) => false,
    creating: (_, __, ___) => true,
    success: (_, __) => false,
    error: (_, __, ___, ____, _____) => false,
  );
  
  /// Kiểm tra form có sẵn sàng không
  bool get isFormReady => when(
    initial: () => false,
    loadingForm: (_) => false,
    formReady: (_, __, ___, ____, _____, ______, _______) => true,
    creating: (_, __, ___) => false,
    success: (_, __) => false,
    error: (_, __, ___, ____, _____) => false,
  );
  
  /// Kiểm tra có lỗi không
  bool get hasError => when(
    initial: () => false,
    loadingForm: (_) => false,
    formReady: (_, __, ___, ____, _____, ______, _______) => false,
    creating: (_, __, ___) => false,
    success: (_, __) => false,
    error: (_, __, ___, ____, _____) => true,
  );
  
  /// Kiểm tra có thành công không
  bool get isSuccess => when(
    initial: () => false,
    loadingForm: (_) => false,
    formReady: (_, __, ___, ____, _____, ______, _______) => false,
    creating: (_, __, ___) => false,
    success: (_, __) => true,
    error: (_, __, ___, ____, _____) => false,
  );
  
  /// Lấy current form data
  GroupFormData get currentFormData => when(
    initial: () => const GroupFormData(),
    loadingForm: (_) => const GroupFormData(),
    formReady: (_, __, ___, ____, _____, formData, ______) => formData,
    creating: (formData, _, __) => formData,
    success: (_, __) => const GroupFormData(),
    error: (_, formData, __, ___, ____) => formData,
  );
  
  /// Lấy validation errors
  Map<String, String> get validationErrors => when(
    initial: () => <String, String>{},
    loadingForm: (_) => <String, String>{},
    formReady: (_, __, ___, ____, errors, _____, ______) => errors,
    creating: (_, __, ___) => <String, String>{},
    success: (_, __) => <String, String>{},
    error: (_, __, errors, ___, ____) => errors,
  );
  
  /// Lấy available sports
  List<Sport> get availableSports => when(
    initial: () => <Sport>[],
    loadingForm: (_) => <Sport>[],
    formReady: (sports, _, __, ___, ____, _____, ______) => sports,
    creating: (_, __, ___) => <Sport>[],
    success: (_, __) => <Sport>[],
    error: (_, __, ___, ____, _____) => <Sport>[],
  );
  
  /// Lấy location suggestions
  List<String> get locationSuggestions => when(
    initial: () => <String>[],
    loadingForm: (_) => <String>[],
    formReady: (_, locations, __, ___, ____, _____, ______) => locations,
    creating: (_, __, ___) => <String>[],
    success: (_, __) => <String>[],
    error: (_, __, ___, ____, _____) => <String>[],
  );
  
  /// Lấy name suggestions
  List<String> get nameSuggestions => when(
    initial: () => <String>[],
    loadingForm: (_) => <String>[],
    formReady: (_, __, names, ___, ____, _____, ______) => names,
    creating: (_, __, ___) => <String>[],
    success: (_, __) => <String>[],
    error: (_, __, ___, ____, _____) => <String>[],
  );
  
  /// Lấy sport defaults
  SportDefaults? get sportDefaults => when(
    initial: () => null,
    loadingForm: (_) => null,
    formReady: (_, __, ___, defaults, ____, _____, ______) => defaults,
    creating: (_, __, ___) => null,
    success: (_, __) => null,
    error: (_, __, ___, ____, _____) => null,
  );
  
  /// Lấy error message
  String? get errorMessage => when(
    initial: () => null,
    loadingForm: (_) => null,
    formReady: (_, __, ___, ____, _____, ______, _______) => null,
    creating: (_, __, ___) => null,
    success: (_, __) => null,
    error: (message, _, __, ___, ____) => message,
  );
  
  /// Lấy success message
  String? get successMessage => when(
    initial: () => null,
    loadingForm: (_) => null,
    formReady: (_, __, ___, ____, _____, ______, _______) => null,
    creating: (_, __, ___) => null,
    success: (_, message) => message,
    error: (_, __, ___, ____, _____) => null,
  );
  
  /// Lấy created group (nếu có)
  Group? get createdGroup => when(
    initial: () => null,
    loadingForm: (_) => null,
    formReady: (_, __, ___, ____, _____, ______, _______) => null,
    creating: (_, __, ___) => null,
    success: (group, _) => group,
    error: (_, __, ___, ____, _____) => null,
  );
  
  /// Kiểm tra form có đang validate không
  bool get isValidating => when(
    initial: () => false,
    loadingForm: (_) => false,
    formReady: (_, __, ___, ____, _____, ______, isValidating) => isValidating,
    creating: (_, __, ___) => false,
    success: (_, __) => false,
    error: (_, __, ___, ____, _____) => false,
  );
  
  /// Kiểm tra form có validation errors không
  bool get hasValidationErrors => validationErrors.isNotEmpty;
  
  /// Kiểm tra field cụ thể có lỗi không
  bool hasFieldError(String field) => validationErrors.containsKey(field);
  
  /// Lấy error message cho field cụ thể
  String? getFieldError(String field) => validationErrors[field];
  
  /// Kiểm tra form có thể submit không (basic validation)
  bool get canSubmit => currentFormData.name.trim().isNotEmpty &&
      currentFormData.sportType != null &&
      currentFormData.location.trim().isNotEmpty &&
      currentFormData.city.trim().isNotEmpty &&
      !hasValidationErrors &&
      !isLoading;
  
  /// Lấy display message cho UI
  String? get displayMessage => when(
    initial: () => null,
    loadingForm: (message) => message,
    formReady: (_, __, ___, ____, _____, ______, _______) => null,
    creating: (_, message, __) => message,
    success: (_, message) => message,
    error: (message, _, __, ___, ____) => message,
  );
  
  /// Lấy progress percentage
  int get progress => when(
    initial: () => 0,
    loadingForm: (_) => 0,
    formReady: (_, __, ___, ____, _____, ______, _______) => 0,
    creating: (_, __, progress) => progress,
    success: (_, __) => 100,
    error: (_, __, ___, ____, _____) => 0,
  );
}