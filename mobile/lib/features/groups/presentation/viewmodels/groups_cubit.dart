import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/group.dart';
import '../../services/groups_service.dart';
import 'groups_state.dart';

/// GroupsCubit cho Group Management System
/// 
/// Migrate từ GroupsProvider sang Cubit architecture với Vietnamese localization:
/// - Danh sách nhóm với filtering và search
/// - Pagination hỗ trợ load more
/// - Vietnamese sports types và cultural patterns
/// - Group member management
class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit() : super(const GroupsState.initial());

  static const int _pageSize = 15;

  /// Load danh sách groups với filtering options
  /// 
  /// [refresh] - True để clear current data và reload từ page 1
  /// [sportType] - Loại thể thao để filter (cau_long, bong_da, etc.)
  /// [city] - Thành phố để filter
  /// [privacy] - Privacy level (cong_khai, rieng_tu)
  /// [search] - Query search cho group name
  Future<void> loadGroups({
    bool refresh = false,
    String? sportType,
    String? city, 
    String? privacy,
    String? search,
  }) async {
    try {
      if (refresh || state.currentGroups.isEmpty) {
        emit(GroupsState.loading(
          currentGroups: refresh ? [] : state.currentGroups,
          message: 'Đang tải danh sách nhóm...',
        ));
      }

      final groups = await GroupsService.getGroups(
        sportType: sportType,
        city: city,
        privacy: privacy,
        search: search,
        page: 1,
        perPage: _pageSize,
      );

      emit(GroupsState.loaded(
        groups: groups,
        searchQuery: search,
        sportTypeFilter: sportType,
        cityFilter: city,
        privacyFilter: privacy,
        currentPage: 1,
        hasMorePages: groups.length >= _pageSize,
        message: refresh ? 'Đã làm mới danh sách nhóm' : null,
      ));

      if (kDebugMode) {
        debugPrint('GroupsCubit: Loaded ${groups.length} groups');
      }

    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('GroupsCubit loadGroups error: $error');
        debugPrint('Stack trace: $stackTrace');
      }

      emit(GroupsState.error(
        message: _getVietnameseErrorMessage(error),
        currentGroups: state.currentGroups,
        exception: error,
        errorCode: 'LOAD_GROUPS_ERROR',
      ));
    }
  }

  /// Load more groups (pagination)
  Future<void> loadMoreGroups() async {
    final currentState = state;
    
    // Chỉ load more khi có thể load more
    if (!currentState.canLoadMore) {
      return;
    }

    try {
      final nextPage = currentState.currentPage + 1;
      
      emit(GroupsState.loadingMore(
        currentGroups: currentState.currentGroups,
        loadingPage: nextPage,
        searchQuery: currentState.searchQuery,
        sportTypeFilter: currentState.sportTypeFilter,
        cityFilter: currentState.cityFilter,
        privacyFilter: currentState.privacyFilter,
      ));

      final newGroups = await GroupsService.getGroups(
        sportType: currentState.sportTypeFilter,
        city: currentState.cityFilter,
        privacy: currentState.privacyFilter,
        search: currentState.searchQuery,
        page: nextPage,
        perPage: _pageSize,
      );

      final allGroups = [...currentState.currentGroups, ...newGroups];

      emit(GroupsState.loaded(
        groups: allGroups,
        searchQuery: currentState.currentSearchQuery,
        sportTypeFilter: currentState.currentSportTypeFilter,
        cityFilter: currentState.currentCityFilter,
        privacyFilter: currentState.currentPrivacyFilter,
        currentPage: nextPage,
        hasMorePages: newGroups.length >= _pageSize,
      ));

      if (kDebugMode) {
        debugPrint('GroupsCubit: Loaded ${newGroups.length} more groups, total: ${allGroups.length}');
      }

    } catch (error) {
      if (kDebugMode) {
        debugPrint('GroupsCubit loadMoreGroups error: $error');
      }

      // Rollback to previous loaded state with error message
      emit(GroupsState.error(
        message: _getVietnameseErrorMessage(error),
        currentGroups: currentState.groups,
        exception: error,
        errorCode: 'LOAD_MORE_ERROR',
      ));

      // Auto-recover to loaded state after showing error
      await Future.delayed(const Duration(seconds: 2));
      if (!isClosed) {
        emit(GroupsState.loaded(
          groups: currentState.groups,
          searchQuery: currentState.searchQuery,
          sportTypeFilter: currentState.sportTypeFilter,
          cityFilter: currentState.cityFilter,
          privacyFilter: currentState.privacyFilter,
          currentPage: currentState.currentPage,
          hasMorePages: currentState.hasMorePages,
        ));
      }
    }
  }

  /// Refresh danh sách groups
  Future<void> refreshGroups() async {
    final currentState = state;
    
    try {
      emit(GroupsState.refreshing(
        currentGroups: currentState.currentGroups,
        searchQuery: currentState.currentSearchQuery,
        sportTypeFilter: currentState.currentSportTypeFilter,
        cityFilter: currentState.currentCityFilter,
        privacyFilter: currentState.currentPrivacyFilter,
      ));

      await loadGroups(
        refresh: true,
        sportType: currentState.currentSportTypeFilter,
        city: currentState.currentCityFilter,
        privacy: currentState.currentPrivacyFilter,
        search: currentState.currentSearchQuery,
      );
      
    } catch (error) {
      if (kDebugMode) {
        debugPrint('GroupsCubit refreshGroups error: $error');
      }
      
      emit(GroupsState.error(
        message: _getVietnameseErrorMessage(error),
        currentGroups: currentState.currentGroups,
        exception: error,
        errorCode: 'REFRESH_ERROR',
      ));
    }
  }

  /// Search groups theo tên
  Future<void> searchGroups(String query) async {
    final currentState = state;
    
    await loadGroups(
      refresh: true,
      sportType: currentState.currentSportTypeFilter,
      city: currentState.currentCityFilter,
      privacy: currentState.currentPrivacyFilter,
      search: query.trim().isEmpty ? null : query.trim(),
    );
  }

  /// Apply sport type filter
  Future<void> filterBySportType(String? sportType) async {
    final currentState = state;
    
    await loadGroups(
      refresh: true,
      sportType: sportType,
      city: currentState.currentCityFilter,
      privacy: currentState.currentPrivacyFilter,
      search: currentState.currentSearchQuery,
    );
  }

  /// Apply city filter  
  Future<void> filterByCity(String? city) async {
    final currentState = state;
    
    await loadGroups(
      refresh: true,
      sportType: currentState.currentSportTypeFilter,
      city: city,
      privacy: currentState.currentPrivacyFilter,
      search: currentState.currentSearchQuery,
    );
  }

  /// Apply privacy filter
  Future<void> filterByPrivacy(String? privacy) async {
    final currentState = state;
    
    await loadGroups(
      refresh: true,
      sportType: currentState.currentSportTypeFilter,
      city: currentState.currentCityFilter,
      privacy: privacy,
      search: currentState.currentSearchQuery,
    );
  }

  /// Clear tất cả filters
  Future<void> clearFilters() async {
    await loadGroups(refresh: true);
  }

  /// Join group
  Future<Map<String, dynamic>?> joinGroup(int groupId, {String? joinReason}) async {
    try {
      final result = await GroupsService.joinGroup(groupId, joinReason: joinReason);
      
      // Refresh groups để update member count
      await refreshGroups();
      
      if (kDebugMode) {
        debugPrint('GroupsCubit: Successfully joined group $groupId');
      }
      
      return result;
    } catch (error) {
      if (kDebugMode) {
        debugPrint('GroupsCubit joinGroup error: $error');
      }
      
      emit(GroupsState.error(
        message: _getVietnameseErrorMessage(error),
        currentGroups: state.currentGroups,
        exception: error,
        errorCode: 'JOIN_GROUP_ERROR',
      ));
      
      return null;
    }
  }

  /// Leave group
  Future<bool> leaveGroup(int groupId) async {
    try {
      await GroupsService.leaveGroup(groupId);
      
      // Refresh groups để update member count
      await refreshGroups();
      
      if (kDebugMode) {
        debugPrint('GroupsCubit: Successfully left group $groupId');
      }
      
      return true;
    } catch (error) {
      if (kDebugMode) {
        debugPrint('GroupsCubit leaveGroup error: $error');
      }
      
      emit(GroupsState.error(
        message: _getVietnameseErrorMessage(error),
        currentGroups: state.currentGroups,
        exception: error,
        errorCode: 'LEAVE_GROUP_ERROR',
      ));
      
      return false;
    }
  }

  /// Add new group to current list (called after successful creation)
  void addGroup(Group group) {
    final currentGroups = state.currentGroups;
    if (currentGroups.isNotEmpty || state.hasData) {
      emit(GroupsState.loaded(
        groups: [group, ...currentGroups],
        searchQuery: state.currentSearchQuery,
        sportTypeFilter: state.currentSportTypeFilter,
        cityFilter: state.currentCityFilter,
        privacyFilter: state.currentPrivacyFilter,
        currentPage: state.currentPage,
        hasMorePages: state.canLoadMore,
        message: 'Đã thêm nhóm "${group.name}" thành công',
      ));
    }
  }

  /// Update existing group in list
  void updateGroup(Group updatedGroup) {
    final currentGroups = state.currentGroups;
    if (currentGroups.isNotEmpty) {
      final updatedGroups = currentGroups.map((group) {
        return group.id == updatedGroup.id ? updatedGroup : group;
      }).toList();
      
      emit(GroupsState.loaded(
        groups: updatedGroups,
        searchQuery: state.currentSearchQuery,
        sportTypeFilter: state.currentSportTypeFilter,
        cityFilter: state.currentCityFilter,
        privacyFilter: state.currentPrivacyFilter,
        currentPage: state.currentPage,
        hasMorePages: state.canLoadMore,
        message: 'Đã cập nhật nhóm "${updatedGroup.name}"',
      ));
    }
  }

  /// Remove group from list
  void removeGroup(int groupId) {
    final currentGroups = state.currentGroups;
    if (currentGroups.isNotEmpty) {
      final updatedGroups = currentGroups.where((group) => group.id != groupId).toList();
      
      emit(GroupsState.loaded(
        groups: updatedGroups,
        searchQuery: state.currentSearchQuery,
        sportTypeFilter: state.currentSportTypeFilter,
        cityFilter: state.currentCityFilter,
        privacyFilter: state.currentPrivacyFilter,
        currentPage: state.currentPage,
        hasMorePages: state.canLoadMore,
        message: 'Đã xóa nhóm khỏi danh sách',
      ));
    }
  }

  /// Clear error state
  void clearError() {
    if (state.hasError && state.currentGroups.isNotEmpty) {
      emit(GroupsState.loaded(
        groups: state.currentGroups,
        searchQuery: state.currentSearchQuery,
        sportTypeFilter: state.currentSportTypeFilter,
        cityFilter: state.currentCityFilter,
        privacyFilter: state.currentPrivacyFilter,
        currentPage: state.currentPage,
        hasMorePages: false, // Reset has more pages
      ));
    } else {
      emit(const GroupsState.initial());
    }
  }

  /// Get groups by sport type from current loaded groups (for quick filtering)
  List<Group> getGroupsBySport(String sportType) {
    return state.currentGroups.where((group) => group.sportType == sportType).toList();
  }

  /// Get unique cities from current loaded groups
  List<String> getAvailableCities() {
    final cities = state.currentGroups.map((group) => group.city).toSet().toList();
    cities.sort();
    return cities;
  }

  /// Get unique sport types from current loaded groups  
  List<String> getAvailableSportTypes() {
    final sportTypes = state.currentGroups.map((group) => group.sportType).toSet().toList();
    sportTypes.sort();
    return sportTypes;
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
      return 'Bạn không có quyền xem danh sách nhóm này.';
    }
    
    if (errorString.contains('not found') || errorString.contains('404')) {
      return 'Không tìm thấy nhóm nào phù hợp.';
    }
    
    if (errorString.contains('server') || errorString.contains('500')) {
      return 'Lỗi hệ thống. Vui lòng thử lại sau.';
    }

    if (errorString.contains('failed to join')) {
      return 'Không thể tham gia nhóm. Vui lòng thử lại.';
    }

    if (errorString.contains('failed to leave')) {
      return 'Không thể rời khỏi nhóm. Vui lòng thử lại.';
    }
    
    // Default Vietnamese error message
    return 'Có lỗi xảy ra khi tải danh sách nhóm. Vui lòng thử lại.';
  }

  @override
  void onChange(Change<GroupsState> change) {
    super.onChange(change);
    
    if (kDebugMode) {
      debugPrint('GroupsCubit state changed: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}');
    }
  }

  @override
  Future<void> close() {
    if (kDebugMode) {
      debugPrint('GroupsCubit closed');
    }
    return super.close();
  }
}