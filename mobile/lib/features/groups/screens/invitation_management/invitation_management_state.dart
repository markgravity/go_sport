import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/group_invitation.dart';

part 'invitation_management_state.freezed.dart';

@freezed
class InvitationManagementState with _$InvitationManagementState {
  const factory InvitationManagementState({
    @Default([]) List<GroupInvitation> invitations,
    @Default([]) List<GroupJoinRequest> joinRequests,
    @Default(false) bool isLoadingInvitations,
    @Default(false) bool isLoadingJoinRequests,
    @Default(false) bool isCreatingInvitation,
    @Default(false) bool isProcessingRequest,
    String? errorMessage,
    String? successMessage,
    @Default(InvitationTab.invitations) InvitationTab currentTab,
  }) = _InvitationManagementState;
}

enum InvitationTab {
  invitations,
  joinRequests,
}

extension InvitationTabExtension on InvitationTab {
  String get displayName {
    switch (this) {
      case InvitationTab.invitations:
        return 'Lời mời';
      case InvitationTab.joinRequests:
        return 'Yêu cầu tham gia';
    }
  }
}