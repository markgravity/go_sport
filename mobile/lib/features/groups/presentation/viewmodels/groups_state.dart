import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/group.dart';

part 'groups_state.freezed.dart';

/// GroupsState cho Group Management System
/// 
/// Quản lý trạng thái danh sách nhóm thể thao với Vietnamese localization
/// Hỗ trợ filtering, searching và pagination
@freezed
class GroupsState with _$GroupsState {
  /// Trạng thái ban đầu khi chưa load dữ liệu
  const factory GroupsState.initial() = _Initial;
  
  /// Trạng thái đang tải danh sách nhóm
  const factory GroupsState.loading({
    /// Danh sách nhóm hiện tại (để maintain UI state)
    @Default([]) List<Group> currentGroups,
    /// Thông báo loading tùy chọn
    String? message,
  }) = _Loading;
  
  /// Trạng thái đã tải thành công danh sách nhóm
  const factory GroupsState.loaded({
    /// Danh sách nhóm đã tải
    required List<Group> groups,
    /// Query search hiện tại
    String? searchQuery,
    /// Sport type filter hiện tại  
    String? sportTypeFilter,
    /// City filter hiện tại
    String? cityFilter,
    /// Privacy filter hiện tại (cong_khai/rieng_tu)
    String? privacyFilter,
    /// Page hiện tại cho pagination
    @Default(1) int currentPage,
    /// Có thể load thêm page không
    @Default(false) bool hasMorePages,
    /// Thông báo thành công (nếu có)
    String? message,
  }) = _Loaded;
  
  /// Trạng thái đang load more groups (pagination)
  const factory GroupsState.loadingMore({
    /// Danh sách nhóm hiện tại
    required List<Group> currentGroups,
    /// Page đang load
    required int loadingPage,
    /// Query search hiện tại
    String? searchQuery,
    /// Sport type filter hiện tại
    String? sportTypeFilter,
    /// City filter hiện tại
    String? cityFilter,
    /// Privacy filter hiện tại
    String? privacyFilter,
  }) = _LoadingMore;
  
  /// Trạng thái lỗi khi load groups
  const factory GroupsState.error({
    /// Thông báo lỗi bằng tiếng Việt
    required String message,
    /// Danh sách nhóm hiện tại (để preserve UI state)
    @Default([]) List<Group> currentGroups,
    /// Exception gốc (cho debugging)
    Object? exception,
    /// Error code (tùy chọn)
    String? errorCode,
  }) = _GroupsError;
  
  /// Trạng thái đang refresh danh sách
  const factory GroupsState.refreshing({
    /// Danh sách nhóm hiện tại
    @Default([]) List<Group> currentGroups,
    /// Query search hiện tại
    String? searchQuery,
    /// Sport type filter hiện tại
    String? sportTypeFilter,
    /// City filter hiện tại
    String? cityFilter,
    /// Privacy filter hiện tại
    String? privacyFilter,
  }) = _Refreshing;
}

/// Extension methods for GroupsState
extension GroupsStateExtension on GroupsState {
  /// Kiểm tra có đang loading không
  bool get isLoading => when(
    initial: () => false,
    loading: (_, __) => true,
    loaded: (_, __, ___, ____, _____, ______, _______, ________) => false,
    loadingMore: (_, __, ___, ____, _____, ______) => false,
    error: (_, __, ___, ____) => false,
    refreshing: (_, __, ___, ____, _____) => true,
  );
  
  /// Kiểm tra có đang load more không
  bool get isLoadingMore => when(
    initial: () => false,
    loading: (_, __) => false,
    loaded: (_, __, ___, ____, _____, ______, _______, ________) => false,
    loadingMore: (_, __, ___, ____, _____, ______) => true,
    error: (_, __, ___, ____) => false,
    refreshing: (_, __, ___, ____, _____) => false,
  );
  
  /// Kiểm tra có lỗi không
  bool get hasError => when(
    initial: () => false,
    loading: (_, __) => false,
    loaded: (_, __, ___, ____, _____, ______, _______, ________) => false,
    loadingMore: (_, __, ___, ____, _____, ______) => false,
    error: (_, __, ___, ____) => true,
    refreshing: (_, __, ___, ____, _____) => false,
  );
  
  /// Kiểm tra có dữ liệu không
  bool get hasData => when(
    initial: () => false,
    loading: (groups, _) => groups.isNotEmpty,
    loaded: (groups, _, __, ___, ____, _____, ______, _______) => groups.isNotEmpty,
    loadingMore: (groups, _, __, ___, ____, _____) => groups.isNotEmpty,
    error: (_, groups, __, ___) => groups.isNotEmpty,
    refreshing: (groups, _, __, ___, ____) => groups.isNotEmpty,
  );
  
  /// Lấy danh sách groups hiện tại
  List<Group> get currentGroups => when(
    initial: () => <Group>[],
    loading: (groups, _) => groups,
    loaded: (groups, _, __, ___, ____, _____, ______, _______) => groups,
    loadingMore: (groups, _, __, ___, ____, _____) => groups,
    error: (_, groups, __, ___) => groups,
    refreshing: (groups, _, __, ___, ____) => groups,
  );
  
  /// Lấy search query hiện tại
  String? get currentSearchQuery => when(
    initial: () => null,
    loading: (_, __) => null,
    loaded: (_, query, __, ___, ____, _____, ______, _______) => query,
    loadingMore: (_, __, query, ___, ____, _____) => query,
    error: (_, __, ___, ____) => null,
    refreshing: (_, query, __, ___, ____) => query,
  );
  
  /// Lấy sport type filter hiện tại
  String? get currentSportTypeFilter => when(
    initial: () => null,
    loading: (_, __) => null,
    loaded: (_, __, sportType, ___, ____, _____, ______, _______) => sportType,
    loadingMore: (_, __, ___, sportType, ____, _____) => sportType,
    error: (_, __, ___, ____) => null,
    refreshing: (_, __, sportType, ___, ____) => sportType,
  );
  
  /// Lấy error message
  String? get errorMessage => when(
    initial: () => null,
    loading: (_, __) => null,
    loaded: (_, __, ___, ____, _____, ______, _______, ________) => null,
    loadingMore: (_, __, ___, ____, _____, ______) => null,
    error: (message, _, __, ___) => message,
    refreshing: (_, __, ___, ____, _____) => null,
  );
  
  /// Kiểm tra có thể load more không
  bool get canLoadMore => when(
    initial: () => false,
    loading: (_, __) => false,
    loaded: (_, __, ___, ____, _____, ______, hasMore, _______) => hasMore,
    loadingMore: (_, __, ___, ____, _____, ______) => false,
    error: (_, __, ___, ____) => false,
    refreshing: (_, __, ___, ____, _____) => false,
  );
  
  /// Lấy current page
  int get currentPage => when(
    initial: () => 1,
    loading: (_, __) => 1,
    loaded: (_, __, ___, ____, _____, page, ______, _______) => page,
    loadingMore: (_, __, ___, ____, _____, ______) => 1,
    error: (_, __, ___, ____) => 1,
    refreshing: (_, __, ___, ____, _____) => 1,
  );
  
  /// Kiểm tra có filter active không
  bool get hasActiveFilters => currentSearchQuery?.isNotEmpty == true ||
      currentSportTypeFilter != null ||
      currentCityFilter != null ||
      currentPrivacyFilter != null;
  
  /// Lấy city filter hiện tại
  String? get currentCityFilter => when(
    initial: () => null,
    loading: (_, __) => null,
    loaded: (_, __, ___, city, ____, _____, ______, _______) => city,
    loadingMore: (_, __, ___, ____, city, _____) => city,
    error: (_, __, ___, ____) => null,
    refreshing: (_, __, ___, city, ____) => city,
  );
  
  /// Lấy privacy filter hiện tại
  String? get currentPrivacyFilter => when(
    initial: () => null,
    loading: (_, __) => null,
    loaded: (_, __, ___, ____, privacy, _____, ______, _______) => privacy,
    loadingMore: (_, __, ___, ____, _____, privacy) => privacy,
    error: (_, __, ___, ____) => null,
    refreshing: (_, __, ___, ____, privacy) => privacy,
  );
  
  /// Lấy tổng số groups loaded
  int get groupsCount => currentGroups.length;
  
  /// Kiểm tra có groups nào không
  bool get isEmpty => currentGroups.isEmpty && !isLoading;
  
  /// Lấy Vietnamese message cho UI display
  String? get displayMessage => when(
    initial: () => null,
    loading: (_, message) => message,
    loaded: (_, __, ___, ____, _____, ______, _______, message) => message,
    loadingMore: (_, __, ___, ____, _____, ______) => null,
    error: (message, _, __, ___) => message,
    refreshing: (_, __, ___, ____, _____) => null,
  );
}