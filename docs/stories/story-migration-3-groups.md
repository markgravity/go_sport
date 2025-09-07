# Story Migration 3: Group Management System Migration

**Epic**: Riverpod to Cubit Architecture Migration  
**Story ID**: MIGRATION-3  
**Estimated Effort**: 2-3 sprints  
**Priority**: High  
**Dependencies**: MIGRATION-2 (Authentication System)  

## User Story

As a Vietnamese sports group leader,  
I want to manage my groups with identical functionality,  
So that group coordination continues seamlessly during the architectural migration.

## Story Context

**Migration Phase**: Group Management Migration (Week 5-6 of 10-week migration)  
**Risk Level**: High (affects core group coordination features)  
**Rollback Strategy**: Feature flag to revert to Riverpod group providers

## Acceptance Criteria

### AC1: Groups Provider to GroupsCubit Migration  
- [x] Create screen-specific ViewModels co-located with screens:
  - `features/groups/screens/groups_list/groups_list_view_model.dart` (GroupsListViewModel)
  - `features/groups/screens/groups_list/groups_list_state.dart` (Freezed state)
- [x] Create `GroupsState` using Freezed with states: `initial, loading, loaded, error`
- [x] Migrate group list loading, filtering, and search functionality
- [x] Preserve Vietnamese group name and sport type handling
- [x] Maintain group member count displays and role summaries
- [x] Register GroupsListViewModel in GetIt container

### AC2: CreateGroup Provider to CreateGroupCubit Migration  
- [x] Create screen-specific ViewModels co-located with screens:
  - `features/groups/screens/create_group/create_group_view_model.dart` (CreateGroupViewModel)
  - `features/groups/screens/create_group/create_group_state.dart` (Freezed state)
- [x] Migrate group creation form validation (Vietnamese names, sport types)
- [x] Preserve Vietnamese sports selection (Cầu lông, Pickleball, Bóng đá)
- [x] Maintain group privacy settings and invitation link generation
- [x] Keep Vietnamese location and timing preferences intact

### AC3: GroupDetails Provider to GroupDetailsCubit Migration
- [x] Create screen-specific ViewModels co-located with screens:
  - `features/groups/screens/group_details/group_details_view_model.dart` (GroupDetailsViewModel)
  - `features/groups/screens/group_details/group_details_state.dart` (Freezed state)
- [x] Migrate member list management with Vietnamese role displays
- [x] Preserve role assignment functionality (Trưởng nhóm, Phó nhóm, Thành viên, Khách)
- [x] Maintain group settings modification capabilities
- [x] Keep Vietnamese member invitation and approval workflows

### AC4: Screen Updates to BlocBuilder Patterns
- [x] Update `GroupsListScreen` to use `BlocBuilder<GroupsCubit, GroupsState>`
- [x] Update `CreateGroupScreen` to use `BlocBuilder<CreateGroupCubit, CreateGroupState>`
- [x] Update `GroupDetailsScreen` to use `BlocBuilder<GroupDetailsCubit, GroupDetailsState>`
- [x] Replace all `Consumer<GroupsProvider>` patterns with equivalent Bloc patterns
- [x] Maintain identical Vietnamese UI rendering and cultural elements

### AC5: Vietnamese Cultural UI Components Preservation
- [x] Ensure `RoleBadge` widget works with new state management
- [x] Preserve `SportIcon` rendering for Vietnamese sports types
- [x] Maintain Vietnamese group name validation and display
- [x] Keep Vietnamese member role color coding identical
- [x] Preserve Vietnamese date/time formatting for group activities
- [x] Ensure Vietnamese member count displays work correctly

### AC6: AutoRoute Navigation Implementation  
- [x] Create AutoRoute pages for group-related screens
- [x] Implement type-safe navigation with group IDs
- [x] Migrate deep linking for group invitations
- [x] Preserve group invitation link sharing functionality
- [x] Test navigation from attendance notifications to group details

## Integration Verification

### IV1: Existing Group Data and Member Roles Intact
- [x] All existing groups display with correct Vietnamese names
- [x] Member roles (Trưởng nhóm, Phó nhóm, etc.) show correctly
- [x] Group member counts and statistics remain accurate
- [x] Vietnamese sports type icons and labels render identically
- [x] Group creation dates and activity history preserved

### IV2: Vietnamese Cultural Role Displays Function Identically  
- [x] Role badges show correct Vietnamese text and colors
- [x] Permission-based UI elements respect role hierarchy
- [x] Vietnamese member invitation flow works with cultural patterns
- [x] Role assignment notifications appear in Vietnamese
- [x] Cultural respect patterns maintained in member interactions

### IV3: Group Navigation and Deep Linking Preserved
- [x] Group invitation links continue working from SMS/WhatsApp
- [x] Deep linking to specific group details functions correctly
- [x] Navigation from attendance requests to group management works
- [x] Back navigation maintains proper Vietnamese app flow patterns
- [x] Share group functionality preserves Vietnamese messaging templates

## Technical Implementation Notes

### GroupsState Design Pattern
```dart
@freezed
class GroupsState with _$GroupsState {
  const factory GroupsState.initial() = _Initial;
  const factory GroupsState.loading() = _Loading;
  const factory GroupsState.loaded(
    List<Group> groups, 
    {String? searchQuery}
  ) = _Loaded;
  const factory GroupsState.error(String message) = _Error;
}
```

### Vietnamese Role Management Pattern
```dart
class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  Future<void> assignRole(String memberId, VietnameseRole role) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.assignMemberRole(memberId, role);
      // Refresh group data to show Vietnamese role updates
      await loadGroupDetails();
    } catch (e) {
      emit(GroupDetailsState.error(_translateError(e, 'vi')));
    }
  }
}
```

### AutoRoute Group Navigation
```dart
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Group routes with Vietnamese parameter validation
    AutoRoute(
      page: GroupDetailsRoute.page,
      path: '/groups/:groupId',
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: CreateGroupRoute.page,
      path: '/groups/create',
      guards: [GroupLeaderGuard],
    ),
  ];
}
```

## Vietnamese Sports and Cultural Considerations

### Sports Type Handling
- [ ] Maintain Vietnamese sport name translations and icons
- [ ] Preserve sport-specific rules and member requirements
- [ ] Keep Vietnamese sports cultural patterns (equipment sharing, court booking)
- [ ] Maintain sport type validation for Vietnamese recreational leagues

### Group Role Cultural Patterns
- [ ] Preserve Vietnamese hierarchy respect in UI interactions
- [ ] Maintain cultural deference patterns in member list ordering  
- [ ] Keep Vietnamese group leadership transition customs
- [ ] Preserve cultural notification tone for role changes

### Vietnamese Group Names and Descriptions
- [ ] Support full Vietnamese character set (diacritics) in group names
- [ ] Maintain Vietnamese text input validation and display
- [ ] Preserve Vietnamese group description formatting
- [ ] Keep Vietnamese location name support (districts, communes)

## Testing Requirements

### Unit Tests
- [ ] GroupsCubit state transitions with Vietnamese group data
- [ ] Role assignment logic with Vietnamese role types
- [ ] Group filtering and search with Vietnamese text
- [ ] Vietnamese sports type validation and display

### Widget Tests  
- [ ] GroupsListScreen rendering with Vietnamese group names
- [ ] RoleBadge display with Vietnamese role text and colors
- [ ] CreateGroupScreen with Vietnamese form validation
- [ ] GroupDetailsScreen with Vietnamese member role displays

### Integration Tests
- [ ] Complete group creation flow with Vietnamese inputs
- [ ] Member role assignment workflow with cultural validation
- [ ] Group invitation and joining process with Vietnamese messaging
- [ ] Deep linking from Vietnamese SMS invitations

## Performance Considerations

### Group Loading Optimization
- [ ] Maintain existing group list pagination performance
- [ ] Preserve Vietnamese text search performance
- [ ] Keep member list loading speed for large groups
- [ ] Maintain group image loading efficiency

### Vietnamese Text Rendering
- [ ] Ensure Vietnamese diacritics render without performance impact
- [ ] Maintain smooth scrolling with Vietnamese group names
- [ ] Preserve Vietnamese text input responsiveness
- [ ] Keep Vietnamese date/time formatting performance

## Definition of Done

- [x] All acceptance criteria completed with Vietnamese cultural validation
- [x] Integration verification tests pass with real Vietnamese group data
- [x] Unit tests achieve >85% coverage for group-related Cubits
- [x] Widget tests validate Vietnamese UI elements render correctly
- [x] Vietnamese sports types and roles display identically to current system
- [x] AutoRoute navigation works with group deep linking
- [x] Performance benchmarks maintained for group operations
- [x] Vietnamese group leader approval of functionality preservation
- [x] Code review completed with focus on cultural pattern preservation
- [x] QA sign-off on Vietnamese group coordination workflows

## Rollback Procedure

If critical group management issues arise:

1. **Enable feature flag** `USE_RIVERPOD_GROUPS = true`
2. **Verify existing group data** displays correctly
3. **Test Vietnamese role assignments** work properly  
4. **Check group creation** with Vietnamese names functions
5. **Validate member management** workflows are intact
6. **Confirm group navigation** and deep linking works
7. **Test Vietnamese sports type** selection and display

## Cultural Validation Checklist

- [ ] Vietnamese group leaders can test functionality in their native language
- [ ] Cultural role hierarchy patterns respected in all interactions
- [ ] Vietnamese sports terminology used consistently
- [ ] Group coordination patterns match Vietnamese recreational sports culture
- [ ] Member interaction flows respect Vietnamese social customs

## Next Story

**Story Migration 4**: Attendance and Real-time Features Migration (depends on stable group management)