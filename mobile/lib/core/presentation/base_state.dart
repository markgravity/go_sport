import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_state.freezed.dart';

/// Base state cho tất cả các Cubit trong ứng dụng Go Sport
/// 
/// Template này cung cấp các trạng thái cơ bản:
/// - initial: Trạng thái khởi tạo
/// - loading: Đang tải dữ liệu
/// - success: Thành công với dữ liệu
/// - error: Lỗi với thông báo
/// 
/// Sử dụng Freezed để tạo immutable state classes với type safety
@freezed
class BaseState<T> with _$BaseState<T> {
  const factory BaseState.initial() = _Initial<T>;
  
  /// Trạng thái đang loading với thông báo tùy chọn
  /// 
  /// Example:
  /// ```dart
  /// const BaseState<User>.loading(message: "Đang tải thông tin người dùng...");
  /// ```
  const factory BaseState.loading({String? message}) = _Loading<T>;
  
  /// Trạng thái thành công với dữ liệu
  /// 
  /// Example:
  /// ```dart
  /// const BaseState<User>.success(data: user, message: "Tải thông tin thành công");
  /// ```
  const factory BaseState.success({
    required T data,
    String? message,
  }) = _Success<T>;
  
  /// Trạng thái lỗi với thông báo lỗi tiếng Việt
  /// 
  /// Example:
  /// ```dart
  /// const BaseState<User>.error(
  ///   message: "Không thể tải thông tin người dùng", 
  ///   exception: apiException
  /// );
  /// ```
  const factory BaseState.error({
    required String message,
    Object? exception,
  }) = _Error<T>;
}

/// Extension methods cho việc kiểm tra trạng thái
extension BaseStateExtension<T> on BaseState<T> {
  /// Kiểm tra có phải trạng thái loading không
  bool get isLoading => when(
    initial: () => false,
    loading: (_) => true,
    success: (_, __) => false,
    error: (_, __) => false,
  );
  
  /// Kiểm tra có phải trạng thái success không
  bool get isSuccess => when(
    initial: () => false,
    loading: (_) => false,
    success: (_, __) => true,
    error: (_, __) => false,
  );
  
  /// Kiểm tra có phải trạng thái error không
  bool get isError => when(
    initial: () => false,
    loading: (_) => false,
    success: (_, __) => false,
    error: (_, __) => true,
  );
  
  /// Kiểm tra có phải trạng thái initial không
  bool get isInitial => when(
    initial: () => true,
    loading: (_) => false,
    success: (_, __) => false,
    error: (_, __) => false,
  );
  
  /// Lấy data nếu ở trạng thái success, null nếu không
  T? get dataOrNull => when(
    initial: () => null,
    loading: (_) => null,
    success: (data, _) => data,
    error: (_, __) => null,
  );
  
  /// Lấy error message nếu có, null nếu không
  String? get errorMessage => when(
    initial: () => null,
    loading: (_) => null,
    success: (_, __) => null,
    error: (message, _) => message,
  );
}

/// Template cho list state - dùng cho danh sách dữ liệu
@freezed
class ListState<T> with _$ListState<T> {
  const factory ListState.initial() = _ListInitial<T>;
  
  /// Đang tải danh sách
  const factory ListState.loading({
    List<T>? currentData,
    String? message,
  }) = _ListLoading<T>;
  
  /// Danh sách tải thành công
  const factory ListState.success({
    required List<T> data,
    @Default(false) bool hasMore,
    String? message,
  }) = _ListSuccess<T>;
  
  /// Lỗi khi tải danh sách
  const factory ListState.error({
    required String message,
    List<T>? currentData,
    Object? exception,
  }) = _ListError<T>;
  
  /// Đang refresh danh sách
  const factory ListState.refreshing({
    required List<T> currentData,
  }) = _ListRefreshing<T>;
  
  /// Đang load more items
  const factory ListState.loadingMore({
    required List<T> currentData,
  }) = _ListLoadingMore<T>;
}

/// Extension methods cho ListState
extension ListStateExtension<T> on ListState<T> {
  /// Lấy danh sách dữ liệu hiện tại (có thể rỗng)
  List<T> get dataOrEmpty => when(
    initial: () => [],
    loading: (currentData, _) => currentData ?? [],
    success: (data, _, __) => data,
    error: (_, currentData, __) => currentData ?? [],
    refreshing: (currentData) => currentData,
    loadingMore: (currentData) => currentData,
  );
  
  /// Kiểm tra có đang loading không (bao gồm loading, refreshing, loadingMore)
  bool get isLoading => when(
    initial: () => false,
    loading: (_, __) => true,
    success: (_, __, ___) => false,
    error: (_, __, ___) => false,
    refreshing: (_) => true,
    loadingMore: (_) => true,
  );
  
  /// Kiểm tra có lỗi không
  bool get hasError => when(
    initial: () => false,
    loading: (_, __) => false,
    success: (_, __, ___) => false,
    error: (_, __, ___) => true,
    refreshing: (_) => false,
    loadingMore: (_) => false,
  );
}

/// Template cho pagination state
@freezed
class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState({
    @Default([]) List<T> items,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
    @Default(1) int currentPage,
    String? error,
  }) = _PaginationState<T>;
}

/// Extension cho PaginationState
extension PaginationStateExtension<T> on PaginationState<T> {
  /// Thêm items mới vào danh sách (dùng cho load more)
  PaginationState<T> addItems(List<T> newItems, {bool hasMore = true}) {
    return copyWith(
      items: [...items, ...newItems],
      hasMore: hasMore,
      currentPage: currentPage + 1,
      isLoadingMore: false,
    );
  }
  
  /// Reset về trang đầu với items mới (dùng cho refresh)
  PaginationState<T> resetWithItems(List<T> newItems, {bool hasMore = true}) {
    return copyWith(
      items: newItems,
      hasMore: hasMore,
      currentPage: 1,
      isLoading: false,
      error: null,
    );
  }
}