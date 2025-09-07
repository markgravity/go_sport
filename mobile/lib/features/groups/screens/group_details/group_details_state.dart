import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/group.dart';
import '../../models/group_role.dart';

part 'group_details_state.freezed.dart';

/// Group details screen state for Vietnamese sports app
/// 
/// Uses Freezed to create immutable state classes with type safety
/// Includes all states needed for Vietnamese group management and member roles
@freezed
class GroupDetailsState with _$GroupDetailsState {
  /// Initial state when group details screen loads
  const factory GroupDetailsState.initial() = _Initial;
  
  /// Loading state during group operations
  /// 
  /// [message] - Loading message in Vietnamese
  /// Example: "Đang tải thông tin nhóm...", "Đang cập nhật vai trò..."
  const factory GroupDetailsState.loading({
    String? message,
  }) = _Loading;
  
  /// Group details loaded successfully
  /// 
  /// [group] - Detailed group information
  /// [members] - List of group members with roles
  /// [currentUserRole] - Current user's role in the group
  const factory GroupDetailsState.loaded({
    required Group group,
    required List<GroupMember> members,
    VietnameseGroupRole? currentUserRole,
  }) = _Loaded;
  
  /// Error state with Vietnamese message
  /// 
  /// [message] - Error message in Vietnamese
  /// [errorCode] - Error code for specific handling (optional)
  const factory GroupDetailsState.error({
    required String message,
    String? errorCode,
  }) = _Error;
  
  /// Successfully assigned role to member
  /// 
  /// [message] - Success message in Vietnamese
  const factory GroupDetailsState.roleAssigned({
    String? message,
  }) = _RoleAssigned;
  
  /// Successfully removed member from group
  /// 
  /// [message] - Success message in Vietnamese
  const factory GroupDetailsState.memberRemoved({
    String? message,
  }) = _MemberRemoved;
  
  /// Successfully generated invitation link
  /// 
  /// [invitationLink] - Generated invitation link
  /// [message] - Success message in Vietnamese
  const factory GroupDetailsState.invitationGenerated({
    required String invitationLink,
    String? message,
  }) = _InvitationGenerated;
  
  /// Successfully updated group settings
  /// 
  /// [message] - Success message in Vietnamese
  const factory GroupDetailsState.settingsUpdated({
    String? message,
  }) = _SettingsUpdated;
  
  /// Successfully left the group
  /// 
  /// [message] - Success message in Vietnamese
  const factory GroupDetailsState.leftGroup({
    String? message,
  }) = _LeftGroup;
  
  /// Successfully deleted the group
  /// 
  /// [message] - Success message in Vietnamese
  const factory GroupDetailsState.groupDeleted({
    String? message,
  }) = _GroupDeleted;
  
  /// Navigate to edit group screen
  /// 
  /// [groupId] - ID of the group to edit
  const factory GroupDetailsState.navigateToEditGroup({
    required String groupId,
  }) = _NavigateToEditGroup;
  
  /// Navigate to member profile screen
  /// 
  /// [memberId] - ID of the member to view profile
  const factory GroupDetailsState.navigateToMemberProfile({
    required String memberId,
  }) = _NavigateToMemberProfile;
  
  /// Navigate back to groups list
  const factory GroupDetailsState.navigateBack() = _NavigateBack;
}

/// Extension methods for GroupDetailsState for convenient usage
extension GroupDetailsStateExtensions on GroupDetailsState {
  /// Check if currently loading
  bool get isLoading => when(
    initial: () => false,
    loading: (_) => true,
    loaded: (_, __, ___) => false,
    error: (_, __) => false,
    roleAssigned: (_) => false,
    memberRemoved: (_) => false,
    invitationGenerated: (_, __) => false,
    settingsUpdated: (_) => false,
    leftGroup: (_) => false,
    groupDeleted: (_) => false,
    navigateToEditGroup: (_) => false,
    navigateToMemberProfile: (_) => false,
    navigateBack: () => false,
  );
  
  /// Check if has error
  bool get hasError => when(
    initial: () => false,
    loading: (_) => false,
    loaded: (_, __, ___) => false,
    error: (_, __) => true,
    roleAssigned: (_) => false,
    memberRemoved: (_) => false,
    invitationGenerated: (_, __) => false,
    settingsUpdated: (_) => false,
    leftGroup: (_) => false,
    groupDeleted: (_) => false,
    navigateToEditGroup: (_) => false,
    navigateToMemberProfile: (_) => false,
    navigateBack: () => false,
  );
  
  /// Get error message (if any)
  String? get errorMessage => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (_, __, ___) => null,
    error: (message, _) => message,
    roleAssigned: (_) => null,
    memberRemoved: (_) => null,
    invitationGenerated: (_, __) => null,
    settingsUpdated: (_) => null,
    leftGroup: (_) => null,
    groupDeleted: (_) => null,
    navigateToEditGroup: (_) => null,
    navigateToMemberProfile: (_) => null,
    navigateBack: () => null,
  );
  
  /// Get loading message (if any)
  String? get loadingMessage => when(
    initial: () => null,
    loading: (message) => message,
    loaded: (_, __, ___) => null,
    error: (_, __) => null,
    roleAssigned: (_) => null,
    memberRemoved: (_) => null,
    invitationGenerated: (_, __) => null,
    settingsUpdated: (_) => null,
    leftGroup: (_) => null,
    groupDeleted: (_) => null,
    navigateToEditGroup: (_) => null,
    navigateToMemberProfile: (_) => null,
    navigateBack: () => null,
  );
  
  /// Check if group details are loaded
  bool get isLoaded => when(
    initial: () => false,
    loading: (_) => false,
    loaded: (_, __, ___) => true,
    error: (_, __) => false,
    roleAssigned: (_) => false,
    memberRemoved: (_) => false,
    invitationGenerated: (_, __) => false,
    settingsUpdated: (_) => false,
    leftGroup: (_) => false,
    groupDeleted: (_) => false,
    navigateToEditGroup: (_) => false,
    navigateToMemberProfile: (_) => false,
    navigateBack: () => false,
  );
  
  /// Get current group (if any)
  Group? get group => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (group, _, __) => group,
    error: (_, __) => null,
    roleAssigned: (_) => null,
    memberRemoved: (_) => null,
    invitationGenerated: (_, __) => null,
    settingsUpdated: (_) => null,
    leftGroup: (_) => null,
    groupDeleted: (_) => null,
    navigateToEditGroup: (_) => null,
    navigateToMemberProfile: (_) => null,
    navigateBack: () => null,
  );
  
  /// Get current members list (if any)
  List<GroupMember>? get members => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (_, members, __) => members,
    error: (_, __) => null,
    roleAssigned: (_) => null,
    memberRemoved: (_) => null,
    invitationGenerated: (_, __) => null,
    settingsUpdated: (_) => null,
    leftGroup: (_) => null,
    groupDeleted: (_) => null,
    navigateToEditGroup: (_) => null,
    navigateToMemberProfile: (_) => null,
    navigateBack: () => null,
  );
  
  /// Get current user's role (if any)
  VietnameseGroupRole? get currentUserRole => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (_, __, currentUserRole) => currentUserRole,
    error: (_, __) => null,
    roleAssigned: (_) => null,
    memberRemoved: (_) => null,
    invitationGenerated: (_, __) => null,
    settingsUpdated: (_) => null,
    leftGroup: (_) => null,
    groupDeleted: (_) => null,
    navigateToEditGroup: (_) => null,
    navigateToMemberProfile: (_) => null,
    navigateBack: () => null,
  );
  
  /// Check if current user can manage roles
  bool get canManageRoles => 
      currentUserRole == VietnameseGroupRole.leader ||
      currentUserRole == VietnameseGroupRole.coLeader;
  
  /// Check if current user can edit group settings
  bool get canEditGroup => 
      currentUserRole == VietnameseGroupRole.leader ||
      currentUserRole == VietnameseGroupRole.coLeader;
  
  /// Check if current user can delete group
  bool get canDeleteGroup => 
      currentUserRole == VietnameseGroupRole.leader;
  
  /// Get invitation link (if generated)
  String? get invitationLink => when(
    initial: () => null,
    loading: (_) => null,
    loaded: (_, __, ___) => null,
    error: (_, __) => null,
    roleAssigned: (_) => null,
    memberRemoved: (_) => null,
    invitationGenerated: (link, _) => link,
    settingsUpdated: (_) => null,
    leftGroup: (_) => null,
    groupDeleted: (_) => null,
    navigateToEditGroup: (_) => null,
    navigateToMemberProfile: (_) => null,
    navigateBack: () => null,
  );
}