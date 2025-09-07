import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/group.dart';

part 'groups_list_state.freezed.dart';

/// Groups list screen state for Vietnamese sports app
/// 
/// Uses Freezed to create immutable state classes with type safety
/// Includes all states needed for Vietnamese groups list management
@freezed
class GroupsListState with _$GroupsListState {
  /// Initial state when groups list screen loads
  const factory GroupsListState.initial() = _Initial;
  
  /// Loading state during groups operations
  /// 
  /// [message] - Loading message in Vietnamese
  /// Example: "Đang tải danh sách nhóm...", "Đang tham gia nhóm..."
  const factory GroupsListState.loading({
    String? message,
  }) = _Loading;
  
  /// Groups loaded successfully
  /// 
  /// [groups] - List of user's groups
  /// [searchQuery] - Current search query
  /// [sportTypeFilter] - Current Vietnamese sport type filter
  /// [hasMore] - Whether more groups can be loaded (pagination)
  const factory GroupsListState.loaded({
    required List<Group> groups,
    String? searchQuery,
    String? sportTypeFilter,
    required bool hasMore,
  }) = _Loaded;
  
  /// Error state with Vietnamese message
  /// 
  /// [message] - Error message in Vietnamese
  /// [errorCode] - Error code for specific handling (optional)
  const factory GroupsListState.error({
    required String message,
    String? errorCode,
  }) = _Error;
  
  /// Successfully joined a group
  /// 
  /// [message] - Success message in Vietnamese
  const factory GroupsListState.groupJoined({
    String? message,
  }) = _GroupJoined;
  
  /// Successfully left a group
  /// 
  /// [message] - Success message in Vietnamese
  const factory GroupsListState.groupLeft({
    String? message,
  }) = _GroupLeft;
  
  /// Navigate to create group screen
  const factory GroupsListState.navigateToCreateGroup() = _NavigateToCreateGroup;
  
  /// Navigate to group details screen
  /// 
  /// [groupId] - ID of the group to view details for
  const factory GroupsListState.navigateToGroupDetails({
    required String groupId,
  }) = _NavigateToGroupDetails;
}

/// Extension methods for GroupsListState for convenient usage
extension GroupsListStateExtensions on GroupsListState {
  /// Check if currently loading
  bool get isLoading => when(
    initial: () => false,
    loading: (_) => true,
    loaded: (_, __, ___, ____) => false,
    error: (_, __) => false,
    groupJoined: (_) => false,
    groupLeft: (_) => false,
    navigateToCreateGroup: () => false,
    navigateToGroupDetails: (_) => false,
  );
  
  /// Check if has error
  bool get hasError => when(
    initial: () => false,
    loading: (_) => false,
    loaded: (_, __, ___, ____) => false,
    error: (_, __) => true,
    groupJoined: (_) => false,
    groupLeft: (_) => false,
    navigateToCreateGroup: () => false,
    navigateToGroupDetails: (_) => false,
  );
  
  /// Get error message (if any)
  String? get errorMessage => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (_, __, ___, ____) => null,
    error: (message, _) => message,
    groupJoined: (_) => null,
    groupLeft: (_) => null,
    navigateToCreateGroup: () => null,
    navigateToGroupDetails: (_) => null,
  );
  
  /// Get loading message (if any)
  String? get loadingMessage => when(
    initial: () => null,
    loading: (message) => message,
    loaded: (_, __, ___, ____) => null,
    error: (_, __) => null,
    groupJoined: (_) => null,
    groupLeft: (_) => null,
    navigateToCreateGroup: () => null,
    navigateToGroupDetails: (_) => null,
  );
  
  /// Check if groups are loaded
  bool get isLoaded => when(
    initial: () => false,
    loading: (_) => false,
    loaded: (_, __, ___, ____) => true,
    error: (_, __) => false,
    groupJoined: (_) => false,
    groupLeft: (_) => false,
    navigateToCreateGroup: () => false,
    navigateToGroupDetails: (_) => false,
  );
  
  /// Get current groups list (if any)
  List<Group>? get groups => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (groups, _, __, ___) => groups,
    error: (_, __) => null,
    groupJoined: (_) => null,
    groupLeft: (_) => null,
    navigateToCreateGroup: () => null,
    navigateToGroupDetails: (_) => null,
  );
  
  /// Get current search query (if any)
  String? get searchQuery => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (_, searchQuery, __, ___) => searchQuery,
    error: (_, __) => null,
    groupJoined: (_) => null,
    groupLeft: (_) => null,
    navigateToCreateGroup: () => null,
    navigateToGroupDetails: (_) => null,
  );
  
  /// Get current sport type filter (if any)
  String? get sportTypeFilter => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (_, __, sportTypeFilter, ___) => sportTypeFilter,
    error: (_, __) => null,
    groupJoined: (_) => null,
    groupLeft: (_) => null,
    navigateToCreateGroup: () => null,
    navigateToGroupDetails: (_) => null,
  );
  
  /// Check if has more groups to load
  bool get hasMore => when(
    initial: () => false,
    loading: (_) => false,
    loaded: (_, __, ___, hasMore) => hasMore,
    error: (_, __) => false,
    groupJoined: (_) => false,
    groupLeft: (_) => false,
    navigateToCreateGroup: () => false,
    navigateToGroupDetails: (_) => false,
  );
  
  /// Check if has active filters
  bool get hasActiveFilters => 
      (searchQuery?.isNotEmpty == true) || 
      (sportTypeFilter?.isNotEmpty == true);
}