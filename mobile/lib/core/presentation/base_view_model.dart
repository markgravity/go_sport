import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';
import 'base_cubit.dart';

/// Base ViewModel cho MVVM pattern trong Go Sport app
/// 
/// ViewModel đóng vai trò bridge giữa View và Model:
/// - Xử lý business logic
/// - Quản lý UI state
/// - Tương tác với services
/// - Cung cấp data cho View
/// 
/// Example sử dụng:
/// ```dart
/// class UserProfileViewModel extends BaseViewModel<UserProfile> {
///   UserProfileViewModel({required this.authService});
///   
///   final AuthService authService;
///   
///   @override
///   Future<void> initialize() async {
///     await loadUserProfile();
///   }
///   
///   Future<void> loadUserProfile() async {
///     await execute(
///       () => authService.getCurrentUser(),
///       loadingMessage: "Đang tải thông tin cá nhân...",
///     );
///   }
/// }
/// ```
abstract class BaseViewModel<T> extends BaseCubit<T> {
  BaseViewModel() : super();

  /// Khởi tạo ViewModel - override để load initial data
  Future<void> initialize() async {
    // Override trong subclass để load initial data
  }

  /// Validate dữ liệu đầu vào - override trong subclass
  String? validate(Map<String, dynamic> data) {
    // Override trong subclass để validate data
    return null;
  }

  /// Xử lý khi ViewModel bị dispose
  void onDispose() {
    // Override trong subclass để cleanup resources
  }

  @override
  Future<void> close() {
    onDispose();
    return super.close();
  }
}

/// Form ViewModel cho các màn hình có form input
/// 
/// Cung cấp:
/// - Validation logic
/// - Form state management
/// - Submit handling
/// 
/// Example:
/// ```dart
/// class LoginFormViewModel extends BaseFormViewModel {
///   String _phone = '';
///   String _password = '';
///   
///   String get phone => _phone;
///   String get password => _password;
///   
///   void updatePhone(String value) {
///     _phone = value;
///     clearErrors();
///   }
///   
///   @override
///   Map<String, String?> validateForm() {
///     final errors = <String, String?>{};
///     
///     if (_phone.isEmpty) {
///       errors['phone'] = 'Vui lòng nhập số điện thoại';
///     }
///     
///     return errors;
///   }
/// }
/// ```
abstract class BaseFormViewModel extends BaseViewModel<bool> {
  final Map<String, String?> _errors = {};
  bool _isSubmitting = false;

  /// Map các lỗi validation theo field
  Map<String, String?> get errors => Map.unmodifiable(_errors);

  /// Kiểm tra có lỗi validation không
  bool get hasErrors => _errors.values.any((error) => error != null);

  /// Kiểm tra đang submit không
  bool get isSubmitting => _isSubmitting;

  /// Validate toàn bộ form - override trong subclass
  Map<String, String?> validateForm();

  /// Submit form
  Future<bool> submitForm(Future<bool> Function() onSubmit) async {
    // Clear previous errors
    _errors.clear();
    
    // Validate form
    final validationErrors = validateForm();
    _errors.addAll(validationErrors);
    
    if (hasErrors) {
      emit(const BaseState.error(message: 'Vui lòng kiểm tra lại thông tin'));
      return false;
    }

    _isSubmitting = true;
    emit(const BaseState.loading(message: 'Đang xử lý...'));

    try {
      final success = await onSubmit();
      
      if (success) {
        emit(const BaseState.success(data: true, message: 'Thành công'));
      } else {
        emit(const BaseState.error(message: 'Có lỗi xảy ra'));
      }
      
      _isSubmitting = false;
      return success;
    } catch (error) {
      _isSubmitting = false;
      final errorMessage = _getVietnameseErrorMessage(error);
      emit(BaseState.error(message: errorMessage, exception: error));
      return false;
    }
  }

  /// Clear all errors
  void clearErrors() {
    _errors.clear();
  }

  /// Clear error cho field cụ thể
  void clearFieldError(String field) {
    _errors.remove(field);
  }

  /// Set error cho field cụ thể
  void setFieldError(String field, String error) {
    _errors[field] = error;
  }

  /// Get error message cho field
  String? getFieldError(String field) {
    return _errors[field];
  }

  String _getVietnameseErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('validation') || errorString.contains('invalid')) {
      return 'Thông tin không hợp lệ. Vui lòng kiểm tra lại.';
    }
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Lỗi kết nối mạng. Vui lòng thử lại.';
    }
    
    return 'Có lỗi xảy ra. Vui lòng thử lại.';
  }
}

/// List ViewModel cho màn hình hiển thị danh sách
/// 
/// Extends BaseListCubit với thêm các tính năng:
/// - Search/Filter
/// - Sort
/// - Selection
/// 
/// Example:
/// ```dart
/// class GroupsListViewModel extends BaseListViewModel<Group> {
///   GroupsListViewModel({required this.groupService});
///   
///   final GroupService groupService;
///   
///   @override
///   Future<void> initialize() async {
///     await loadGroups();
///   }
///   
///   Future<void> loadGroups() async {
///     await loadList(() => groupService.getAllGroups());
///   }
/// }
/// ```
abstract class BaseListViewModel<T> extends BaseListCubit<T> {
  BaseListViewModel() : super();

  String _searchQuery = '';
  final Set<T> _selectedItems = {};

  /// Search query hiện tại
  String get searchQuery => _searchQuery;

  /// Danh sách items được select
  Set<T> get selectedItems => Set.unmodifiable(_selectedItems);

  /// Kiểm tra có items được select không
  bool get hasSelectedItems => _selectedItems.isNotEmpty;

  /// Số lượng items được select
  int get selectedCount => _selectedItems.length;

  /// Khởi tạo ViewModel - override để load initial data
  Future<void> initialize() async {
    // Override trong subclass
  }

  /// Search items
  Future<void> search(
    String query,
    Future<List<T>> Function(String query) searchOperation,
  ) async {
    _searchQuery = query;
    
    if (query.isEmpty) {
      await initialize(); // Reload all items
      return;
    }

    await loadList(() => searchOperation(query));
  }

  /// Clear search
  Future<void> clearSearch() async {
    _searchQuery = '';
    await initialize();
  }

  /// Toggle selection của item
  void toggleSelection(T item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
    } else {
      _selectedItems.add(item);
    }
  }

  /// Select tất cả items
  void selectAll() {
    _selectedItems.addAll(state.dataOrEmpty);
  }

  /// Clear tất cả selection
  void clearSelection() {
    _selectedItems.clear();
  }

  /// Kiểm tra item có được select không
  bool isSelected(T item) {
    return _selectedItems.contains(item);
  }

  /// Delete selected items
  Future<void> deleteSelected(
    Future<bool> Function(List<T> items) deleteOperation,
  ) async {
    if (_selectedItems.isEmpty) return;

    try {
      final success = await deleteOperation(_selectedItems.toList());
      
      if (success) {
        // Remove deleted items from list
        for (final item in _selectedItems) {
          removeItem((listItem) => listItem == item);
        }
        
        // Clear selection
        _selectedItems.clear();
      }
    } catch (error) {
      if (kDebugMode) {
        debugPrint('Delete selected failed: $error');
      }
    }
  }

  @override
  Future<void> close() {
    _selectedItems.clear();
    return super.close();
  }
}

/// Pagination ViewModel cho danh sách có phân trang
/// 
/// Example:
/// ```dart
/// class EventsPaginationViewModel extends BasePaginationViewModel<Event> {
///   @override
///   Future<List<Event>> loadPage(int page, int limit) async {
///     return eventService.getEvents(page: page, limit: limit);
///   }
/// }
/// ```
abstract class BasePaginationViewModel<T> extends Cubit<PaginationState<T>> {
  BasePaginationViewModel({this.pageSize = 20}) : super(const PaginationState());

  final int pageSize;

  /// Override để implement logic load page
  Future<List<T>> loadPage(int page, int limit);

  /// Load trang đầu tiên
  Future<void> loadFirstPage() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final items = await loadPage(1, pageSize);
      
      emit(state.resetWithItems(
        items, 
        hasMore: items.length >= pageSize,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        error: _getVietnameseErrorMessage(error),
      ));
    }
  }

  /// Load trang tiếp theo
  Future<void> loadNextPage() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final items = await loadPage(state.currentPage + 1, pageSize);
      
      emit(state.addItems(items, hasMore: items.length >= pageSize));
    } catch (error) {
      emit(state.copyWith(
        isLoadingMore: false,
        error: _getVietnameseErrorMessage(error),
      ));
    }
  }

  /// Refresh danh sách
  Future<void> refresh() async {
    await loadFirstPage();
  }

  String _getVietnameseErrorMessage(Object error) {
    return 'Có lỗi xảy ra khi tải danh sách. Vui lòng thử lại.';
  }

  @override
  void onChange(Change<PaginationState<T>> change) {
    super.onChange(change);
    
    if (kDebugMode) {
      debugPrint('$runtimeType pagination state: ${change.nextState.items.length} items, page ${change.nextState.currentPage}');
    }
  }
}