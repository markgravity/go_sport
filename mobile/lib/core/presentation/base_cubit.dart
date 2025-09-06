import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';

/// Base Cubit cho tất cả các Cubit trong ứng dụng Go Sport
/// 
/// Template này cung cấp:
/// - Quản lý state với BaseState<T>
/// - Error handling thống nhất
/// - Logging cho debug
/// - Extension methods tiện ích
/// 
/// Example sử dụng:
/// ```dart
/// class UserCubit extends BaseCubit<User> {
///   UserCubit() : super();
///   
///   Future<void> loadUser(String id) async {
///     await safeExecute(
///       () => userService.getUser(id),
///       loadingMessage: "Đang tải thông tin người dùng...",
///       successMessage: "Tải thông tin thành công",
///     );
///   }
/// }
/// ```
abstract class BaseCubit<T> extends Cubit<BaseState<T>> {
  BaseCubit() : super(const BaseState.initial()) {
    if (kDebugMode) {
      debugPrint('${runtimeType} initialized');
    }
  }

  /// Thực thi một operation với error handling tự động
  /// 
  /// [operation] - Function trả về dữ liệu type T
  /// [loadingMessage] - Thông báo khi đang loading
  /// [successMessage] - Thông báo khi thành công (tùy chọn)
  /// [errorTransform] - Transform error message (tùy chọn)
  Future<void> safeExecute(
    Future<T> Function() operation, {
    String? loadingMessage,
    String? successMessage,
    String Function(Object error)? errorTransform,
  }) async {
    try {
      emit(BaseState.loading(message: loadingMessage));
      
      final result = await operation();
      
      if (kDebugMode) {
        debugPrint('${runtimeType} operation succeeded');
      }
      
      emit(BaseState.success(
        data: result, 
        message: successMessage,
      ));
    } catch (error, stackTrace) {
      final errorMessage = errorTransform?.call(error) ?? 
                          _getVietnameseErrorMessage(error);
      
      if (kDebugMode) {
        debugPrint('${runtimeType} operation failed: $error');
        debugPrint('Stack trace: $stackTrace');
      }
      
      emit(BaseState.error(
        message: errorMessage,
        exception: error,
      ));
    }
  }

  /// Thực thi operation mà không thay đổi state loading
  /// Hữu ích cho các action không cần loading indicator
  Future<bool> silentExecute(
    Future<T> Function() operation, {
    Function(T data)? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      final result = await operation();
      onSuccess?.call(result);
      return true;
    } catch (error) {
      final errorMessage = _getVietnameseErrorMessage(error);
      onError?.call(errorMessage);
      return false;
    }
  }

  /// Reset về trạng thái initial
  void resetState() {
    emit(const BaseState.initial());
  }

  /// Emit success state với data
  void emitSuccess(T data, {String? message}) {
    emit(BaseState.success(data: data, message: message));
  }

  /// Emit error state với message
  void emitError(String message, {Object? exception}) {
    emit(BaseState.error(message: message, exception: exception));
  }

  /// Emit loading state
  void emitLoading({String? message}) {
    emit(BaseState.loading(message: message));
  }

  /// Transform error thành thông báo tiếng Việt
  String _getVietnameseErrorMessage(Object error) {
    // Kiểm tra các loại error phổ biến và trả về thông báo tiếng Việt
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Lỗi kết nối mạng. Vui lòng kiểm tra kết nối internet.';
    }
    
    if (errorString.contains('timeout')) {
      return 'Kết nối quá chậm. Vui lòng thử lại.';
    }
    
    if (errorString.contains('unauthorized') || errorString.contains('401')) {
      return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
    }
    
    if (errorString.contains('forbidden') || errorString.contains('403')) {
      return 'Bạn không có quyền thực hiện thao tác này.';
    }
    
    if (errorString.contains('not found') || errorString.contains('404')) {
      return 'Không tìm thấy thông tin yêu cầu.';
    }
    
    if (errorString.contains('server') || errorString.contains('500')) {
      return 'Lỗi hệ thống. Vui lòng thử lại sau.';
    }
    
    // Default Vietnamese error message
    return 'Có lỗi xảy ra. Vui lòng thử lại.';
  }

  @override
  void onChange(Change<BaseState<T>> change) {
    super.onChange(change);
    
    if (kDebugMode) {
      debugPrint('${runtimeType} state changed: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}');
    }
  }

  @override
  Future<void> close() {
    if (kDebugMode) {
      debugPrint('${runtimeType} closed');
    }
    return super.close();
  }
}

/// Base List Cubit cho quản lý danh sách dữ liệu
/// 
/// Cung cấp các methods phổ biến cho list operations:
/// - Load danh sách
/// - Refresh
/// - Load more (pagination)
/// - Search/Filter
abstract class BaseListCubit<T> extends Cubit<ListState<T>> {
  BaseListCubit() : super(const ListState.initial());

  /// Load danh sách dữ liệu
  Future<void> loadList(
    Future<List<T>> Function() operation, {
    String? loadingMessage,
  }) async {
    try {
      emit(ListState.loading(
        currentData: state.dataOrEmpty,
        message: loadingMessage,
      ));
      
      final result = await operation();
      
      emit(ListState.success(data: result));
      
      if (kDebugMode) {
        debugPrint('${runtimeType} loaded ${result.length} items');
      }
    } catch (error) {
      final errorMessage = _getVietnameseErrorMessage(error);
      
      emit(ListState.error(
        message: errorMessage,
        currentData: state.dataOrEmpty,
        exception: error,
      ));
      
      if (kDebugMode) {
        debugPrint('${runtimeType} load failed: $error');
      }
    }
  }

  /// Refresh danh sách
  Future<void> refresh(Future<List<T>> Function() operation) async {
    try {
      emit(ListState.refreshing(currentData: state.dataOrEmpty));
      
      final result = await operation();
      
      emit(ListState.success(data: result));
    } catch (error) {
      final errorMessage = _getVietnameseErrorMessage(error);
      
      emit(ListState.error(
        message: errorMessage,
        currentData: state.dataOrEmpty,
        exception: error,
      ));
    }
  }

  /// Load more items (pagination)
  Future<void> loadMore(
    Future<List<T>> Function() operation, {
    bool hasMore = false,
  }) async {
    try {
      emit(ListState.loadingMore(currentData: state.dataOrEmpty));
      
      final newItems = await operation();
      final allItems = [...state.dataOrEmpty, ...newItems];
      
      emit(ListState.success(
        data: allItems,
        hasMore: hasMore,
      ));
    } catch (error) {
      final errorMessage = _getVietnameseErrorMessage(error);
      
      emit(ListState.error(
        message: errorMessage,
        currentData: state.dataOrEmpty,
        exception: error,
      ));
    }
  }

  /// Add single item to list
  void addItem(T item) {
    final currentList = state.dataOrEmpty;
    emit(ListState.success(data: [item, ...currentList]));
  }

  /// Remove item from list
  void removeItem(bool Function(T item) predicate) {
    final currentList = state.dataOrEmpty;
    final updatedList = currentList.where((item) => !predicate(item)).toList();
    emit(ListState.success(data: updatedList));
  }

  /// Update item in list
  void updateItem(T updatedItem, bool Function(T item) predicate) {
    final currentList = state.dataOrEmpty;
    final updatedList = currentList.map((item) {
      return predicate(item) ? updatedItem : item;
    }).toList();
    emit(ListState.success(data: updatedList));
  }

  String _getVietnameseErrorMessage(Object error) {
    // Same logic as BaseCubit
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Lỗi kết nối mạng. Vui lòng kiểm tra kết nối internet.';
    }
    
    return 'Có lỗi xảy ra khi tải danh sách. Vui lòng thử lại.';
  }

  @override
  void onChange(Change<ListState<T>> change) {
    super.onChange(change);
    
    if (kDebugMode) {
      debugPrint('${runtimeType} state changed: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}');
    }
  }
}