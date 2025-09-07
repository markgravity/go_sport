import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../services/groups_service.dart';
import '../../services/group_role_service.dart';
import '../../models/group.dart';
import '../../models/group_role.dart';
import 'group_details_state.dart';

/// ViewModel for Group Details Screen using Cubit pattern
/// 
/// Handles Vietnamese group details, member management, and role assignments
/// Supports Vietnamese cultural patterns for group hierarchy and roles
@injectable
class GroupDetailsViewModel extends Cubit<GroupDetailsState> {
  final GroupsService _groupsService;
  final GroupRoleService _groupRoleService;
  
  GroupDetailsViewModel(
    this._groupsService,
    this._groupRoleService,
  ) : super(const GroupDetailsState.initial());

  /// Initialize group details screen with group ID
  Future<void> initialize(String groupId) async {
    await loadGroupDetails(groupId);
  }

  /// Load detailed group information and members
  Future<void> loadGroupDetails(String groupId) async {
    emit(const GroupDetailsState.loading(
      message: 'Đang tải thông tin nhóm...'
    ));
    
    try {
      final group = await _groupsService.getGroupDetails(groupId);
      final members = await _groupsService.getGroupMembers(groupId);
      
      emit(GroupDetailsState.loaded(
        group: group,
        members: members,
        currentUserRole: _getCurrentUserRole(members),
      ));
    } catch (error) {
      emit(GroupDetailsState.error(
        message: 'Không thể tải thông tin nhóm: $error',
      ));
    }
  }

  /// Refresh group details
  Future<void> refreshGroupDetails(String groupId) async {
    try {
      final group = await _groupsService.getGroupDetails(groupId);
      final members = await _groupsService.getGroupMembers(groupId);
      
      emit(GroupDetailsState.loaded(
        group: group,
        members: members,
        currentUserRole: _getCurrentUserRole(members),
      ));
    } catch (error) {
      emit(GroupDetailsState.error(
        message: 'Không thể làm mới thông tin nhóm: $error',
      ));
    }
  }

  /// Assign role to group member with Vietnamese hierarchy validation
  Future<void> assignMemberRole({
    required String groupId,
    required String memberId,
    required VietnameseGroupRole role,
  }) async {
    emit(const GroupDetailsState.loading(
      message: 'Đang cập nhật vai trò thành viên...'
    ));
    
    try {
      final success = await _groupRoleService.assignMemberRole(
        groupId: groupId,
        memberId: memberId,
        role: role,
      );
      
      if (success) {
        // Reload group details to show updated roles
        await loadGroupDetails(groupId);
        emit(const GroupDetailsState.roleAssigned(
          message: 'Cập nhật vai trò thành công',
        ));
      } else {
        emit(const GroupDetailsState.error(
          message: 'Không thể cập nhật vai trò thành viên',
        ));
      }
    } catch (error) {
      emit(GroupDetailsState.error(
        message: 'Có lỗi xảy ra khi cập nhật vai trò: $error',
      ));
    }
  }

  /// Remove member from group with Vietnamese confirmation
  Future<void> removeMember({
    required String groupId,
    required String memberId,
    required String memberName,
  }) async {
    emit(const GroupDetailsState.loading(
      message: 'Đang xóa thành viên khỏi nhóm...'
    ));
    
    try {
      final success = await _groupsService.removeMemberFromGroup(
        groupId: groupId,
        memberId: memberId,
      );
      
      if (success) {
        // Reload group details to show updated member list
        await loadGroupDetails(groupId);
        emit(GroupDetailsState.memberRemoved(
          message: 'Đã xóa $memberName khỏi nhóm',
        ));
      } else {
        emit(const GroupDetailsState.error(
          message: 'Không thể xóa thành viên khỏi nhóm',
        ));
      }
    } catch (error) {
      emit(GroupDetailsState.error(
        message: 'Có lỗi xảy ra khi xóa thành viên: $error',
      ));
    }
  }

  /// Generate group invitation link for Vietnamese sharing
  Future<void> generateInvitationLink(String groupId) async {
    emit(const GroupDetailsState.loading(
      message: 'Đang tạo liên kết mời...'
    ));
    
    try {
      final invitationLink = await _groupsService.generateInvitationLink(groupId);
      
      emit(GroupDetailsState.invitationGenerated(
        invitationLink: invitationLink,
        message: 'Tạo liên kết mời thành công',
      ));
    } catch (error) {
      emit(GroupDetailsState.error(
        message: 'Không thể tạo liên kết mời: $error',
      ));
    }
  }

  /// Update group settings with Vietnamese validation
  Future<void> updateGroupSettings({
    required String groupId,
    String? name,
    String? description,
    bool? isPrivate,
    String? location,
  }) async {
    emit(const GroupDetailsState.loading(
      message: 'Đang cập nhật cài đặt nhóm...'
    ));
    
    try {
      final success = await _groupsService.updateGroupSettings(
        groupId: groupId,
        name: name,
        description: description,
        isPrivate: isPrivate,
        location: location,
      );
      
      if (success) {
        // Reload group details to show updated information
        await loadGroupDetails(groupId);
        emit(const GroupDetailsState.settingsUpdated(
          message: 'Cập nhật cài đặt thành công',
        ));
      } else {
        emit(const GroupDetailsState.error(
          message: 'Không thể cập nhật cài đặt nhóm',
        ));
      }
    } catch (error) {
      emit(GroupDetailsState.error(
        message: 'Có lỗi xảy ra khi cập nhật cài đặt: $error',
      ));
    }
  }

  /// Leave group with Vietnamese confirmation
  Future<void> leaveGroup(String groupId) async {
    emit(const GroupDetailsState.loading(
      message: 'Đang rời khỏi nhóm...'
    ));
    
    try {
      final success = await _groupsService.leaveGroup(groupId);
      
      if (success) {
        emit(const GroupDetailsState.leftGroup(
          message: 'Đã rời khỏi nhóm thành công',
        ));
      } else {
        emit(const GroupDetailsState.error(
          message: 'Không thể rời khỏi nhóm. Vui lòng thử lại.',
        ));
      }
    } catch (error) {
      emit(GroupDetailsState.error(
        message: 'Có lỗi xảy ra khi rời nhóm: $error',
      ));
    }
  }

  /// Delete group (only for group leaders)
  Future<void> deleteGroup(String groupId) async {
    emit(const GroupDetailsState.loading(
      message: 'Đang xóa nhóm...'
    ));
    
    try {
      final success = await _groupsService.deleteGroup(groupId);
      
      if (success) {
        emit(const GroupDetailsState.groupDeleted(
          message: 'Đã xóa nhóm thành công',
        ));
      } else {
        emit(const GroupDetailsState.error(
          message: 'Không thể xóa nhóm. Vui lòng thử lại.',
        ));
      }
    } catch (error) {
      emit(GroupDetailsState.error(
        message: 'Có lỗi xảy ra khi xóa nhóm: $error',
      ));
    }
  }

  /// Navigate to edit group screen
  void navigateToEditGroup(String groupId) {
    emit(GroupDetailsState.navigateToEditGroup(groupId: groupId));
  }

  /// Navigate to member profile
  void navigateToMemberProfile(String memberId) {
    emit(GroupDetailsState.navigateToMemberProfile(memberId: memberId));
  }

  /// Navigate back to groups list
  void navigateBack() {
    emit(const GroupDetailsState.navigateBack());
  }

  /// Get current user's role in the group
  VietnameseGroupRole? _getCurrentUserRole(List<GroupMember> members) {
    // This would need to be implemented based on current user ID
    // For now, return a default role
    final currentUser = members.firstWhere(
      (member) => member.isCurrentUser,
      orElse: () => members.first,
    );
    return _mapStringRoleToVietnameseRole(currentUser.role);
  }

  /// Map string role to Vietnamese group role enum
  VietnameseGroupRole _mapStringRoleToVietnameseRole(String role) {
    switch (role.toLowerCase()) {
      case 'leader':
      case 'truong_nhom':
        return VietnameseGroupRole.leader;
      case 'co_leader':
      case 'pho_nhom':
        return VietnameseGroupRole.coLeader;
      case 'member':
      case 'thanh_vien':
      default:
        return VietnameseGroupRole.member;
    }
  }

  /// Check if current user can manage roles
  bool canManageRoles(VietnameseGroupRole? currentUserRole) {
    return currentUserRole == VietnameseGroupRole.leader ||
           currentUserRole == VietnameseGroupRole.coLeader;
  }

  /// Check if current user can edit group settings
  bool canEditGroup(VietnameseGroupRole? currentUserRole) {
    return currentUserRole == VietnameseGroupRole.leader ||
           currentUserRole == VietnameseGroupRole.coLeader;
  }

  /// Check if current user can delete group
  bool canDeleteGroup(VietnameseGroupRole? currentUserRole) {
    return currentUserRole == VietnameseGroupRole.leader;
  }
}