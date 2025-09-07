import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../services/groups_service.dart';
import '../../models/group.dart';
import 'groups_list_state.dart';

/// ViewModel for Groups List Screen using Cubit pattern
/// 
/// Handles Vietnamese groups list loading, filtering, and search
/// Supports Vietnamese sports types and cultural group patterns
@injectable
class GroupsListViewModel extends Cubit<GroupsListState> {
  final GroupsService _groupsService;
  List<Group> _allGroups = [];
  String _currentSearchQuery = '';
  String? _currentSportTypeFilter;
  
  GroupsListViewModel(this._groupsService) : super(const GroupsListState.initial());

  /// Initialize groups list screen
  Future<void> initialize() async {
    await loadGroups();
  }

  /// Load all user's groups from the service
  Future<void> loadGroups() async {
    emit(const GroupsListState.loading());
    
    try {
      _allGroups = await GroupsService.getGroups();
      _applyFiltersAndSearch();
    } catch (error) {
      emit(GroupsListState.error(
        message: 'Không thể tải danh sách nhóm: $error',
      ));
    }
  }

  /// Refresh groups list
  Future<void> refreshGroups() async {
    try {
      _allGroups = await GroupsService.getGroups();
      _applyFiltersAndSearch();
    } catch (error) {
      emit(GroupsListState.error(
        message: 'Không thể làm mới danh sách nhóm: $error',
      ));
    }
  }

  /// Search groups by Vietnamese name
  void searchGroups(String query) {
    _currentSearchQuery = query.trim();
    _applyFiltersAndSearch();
  }

  /// Filter groups by Vietnamese sport type
  void filterBySportType(String? sportType) {
    _currentSportTypeFilter = sportType;
    _applyFiltersAndSearch();
  }

  /// Clear all filters and search
  void clearFilters() {
    _currentSearchQuery = '';
    _currentSportTypeFilter = null;
    _applyFiltersAndSearch();
  }

  /// Navigate to create group screen
  void navigateToCreateGroup() {
    emit(const GroupsListState.navigateToCreateGroup());
  }

  /// Navigate to group details screen
  void navigateToGroupDetails(String groupId) {
    emit(GroupsListState.navigateToGroupDetails(groupId: groupId));
  }

  /// Join a group with invitation code
  Future<void> joinGroupWithCode(String invitationCode) async {
    emit(const GroupsListState.loading());
    
    try {
      final result = await GroupsService.joinGroup(int.parse(invitationCode));
      
      if (result['success'] == true) {
        // Reload groups to include the newly joined group
        await loadGroups();
        emit(const GroupsListState.groupJoined(
          message: 'Tham gia nhóm thành công!',
        ));
      } else {
        emit(const GroupsListState.error(
          message: 'Không thể tham gia nhóm. Mã mời có thể đã hết hạn.',
        ));
      }
    } catch (error) {
      emit(GroupsListState.error(
        message: 'Có lỗi xảy ra khi tham gia nhóm: $error',
      ));
    }
  }

  /// Leave a group
  Future<void> leaveGroup(String groupId) async {
    emit(const GroupsListState.loading());
    
    try {
      await GroupsService.leaveGroup(int.parse(groupId));
      
      // Remove the group from local list
      _allGroups.removeWhere((group) => group.id == int.parse(groupId));
      _applyFiltersAndSearch();
      
      emit(const GroupsListState.groupLeft(
        message: 'Đã rời khỏi nhóm thành công',
      ));
    } catch (error) {
      emit(GroupsListState.error(
        message: 'Có lỗi xảy ra khi rời nhóm: $error',
      ));
    }
  }

  /// Apply current filters and search to groups list
  void _applyFiltersAndSearch() {
    List<Group> filteredGroups = List.from(_allGroups);

    // Apply sport type filter
    if (_currentSportTypeFilter != null && _currentSportTypeFilter!.isNotEmpty) {
      filteredGroups = filteredGroups
          .where((group) => group.sportType == _currentSportTypeFilter)
          .toList();
    }

    // Apply search filter (Vietnamese name search)
    if (_currentSearchQuery.isNotEmpty) {
      filteredGroups = filteredGroups
          .where((group) =>
              group.name.toLowerCase().contains(_currentSearchQuery.toLowerCase()) ||
              (group.description?.toLowerCase().contains(_currentSearchQuery.toLowerCase()) ?? false))
          .toList();
    }

    // Sort groups by activity (most recently active first)
    filteredGroups.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    emit(GroupsListState.loaded(
      groups: filteredGroups,
      searchQuery: _currentSearchQuery,
      sportTypeFilter: _currentSportTypeFilter,
      hasMore: false, // Pagination could be added later
    ));
  }

  /// Get available Vietnamese sport types for filtering
  List<String> getAvailableSportTypes() {
    final sportTypes = _allGroups
        .map((group) => group.sportType)
        .where((sportType) => sportType.isNotEmpty)
        .toSet()
        .toList();
    
    sportTypes.sort(); // Sort Vietnamese sport names alphabetically
    return sportTypes;
  }
}