import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../models/group.dart';
import '../../models/group_invitation.dart';
import '../../services/invitation_service.dart';
import 'invitation_management_state.dart';

@injectable
class InvitationManagementViewModel extends Cubit<InvitationManagementState> {
  final InvitationService _invitationService;
  final Group _group;

  InvitationManagementViewModel(
    this._invitationService,
    @factoryParam this._group,
  ) : super(const InvitationManagementState());

  Group get group => _group;

  void init() {
    loadInvitations();
    loadJoinRequests();
  }

  void switchTab(InvitationTab tab) {
    emit(state.copyWith(currentTab: tab));
    if (tab == InvitationTab.invitations && state.invitations.isEmpty) {
      loadInvitations();
    } else if (tab == InvitationTab.joinRequests && state.joinRequests.isEmpty) {
      loadJoinRequests();
    }
  }

  Future<void> loadInvitations() async {
    emit(state.copyWith(isLoadingInvitations: true, errorMessage: null));
    
    try {
      final invitations = await _invitationService.getGroupInvitations(group.id);
      emit(state.copyWith(
        invitations: invitations,
        isLoadingInvitations: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingInvitations: false,
        errorMessage: 'Lỗi khi tải danh sách lời mời: ${e.toString()}',
      ));
    }
  }

  Future<void> loadJoinRequests() async {
    emit(state.copyWith(isLoadingJoinRequests: true, errorMessage: null));
    
    try {
      final joinRequests = await _invitationService.getGroupJoinRequests(group.id);
      emit(state.copyWith(
        joinRequests: joinRequests,
        isLoadingJoinRequests: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingJoinRequests: false,
        errorMessage: 'Lỗi khi tải danh sách yêu cầu tham gia: ${e.toString()}',
      ));
    }
  }

  Future<void> createInvitation({int? expiresInDays}) async {
    emit(state.copyWith(isCreatingInvitation: true, errorMessage: null));
    
    try {
      final newInvitation = await _invitationService.createInvitation(
        group.id,
        type: 'link',
        expiresInDays: expiresInDays,
      );
      
      final updatedInvitations = [newInvitation, ...state.invitations];
      emit(state.copyWith(
        invitations: updatedInvitations,
        isCreatingInvitation: false,
        successMessage: 'Tạo lời mời thành công!',
      ));
    } catch (e) {
      emit(state.copyWith(
        isCreatingInvitation: false,
        errorMessage: 'Lỗi khi tạo lời mời: ${e.toString()}',
      ));
    }
  }

  Future<void> deleteInvitation(GroupInvitation invitation) async {
    try {
      await _invitationService.deleteInvitation(group.id, invitation.id);
      
      final updatedInvitations = state.invitations
          .where((inv) => inv.id != invitation.id)
          .toList();
      
      emit(state.copyWith(
        invitations: updatedInvitations,
        successMessage: 'Đã xóa lời mời thành công!',
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Lỗi khi xóa lời mời: ${e.toString()}',
      ));
    }
  }

  Future<void> approveJoinRequest(GroupJoinRequest joinRequest, {String role = 'member'}) async {
    emit(state.copyWith(isProcessingRequest: true, errorMessage: null));
    
    try {
      final updatedRequest = await _invitationService.approveJoinRequest(
        group.id, 
        joinRequest.id,
        role: role,
      );
      
      final updatedJoinRequests = state.joinRequests
          .map((req) => req.id == updatedRequest.id ? updatedRequest : req)
          .toList();
      
      emit(state.copyWith(
        joinRequests: updatedJoinRequests,
        isProcessingRequest: false,
        successMessage: 'Đã duyệt yêu cầu tham gia thành công!',
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessingRequest: false,
        errorMessage: 'Lỗi khi duyệt yêu cầu: ${e.toString()}',
      ));
    }
  }

  Future<void> rejectJoinRequest(GroupJoinRequest joinRequest, {String? reason}) async {
    emit(state.copyWith(isProcessingRequest: true, errorMessage: null));
    
    try {
      final updatedRequest = await _invitationService.rejectJoinRequest(
        group.id, 
        joinRequest.id,
        reason: reason,
      );
      
      final updatedJoinRequests = state.joinRequests
          .map((req) => req.id == updatedRequest.id ? updatedRequest : req)
          .toList();
      
      emit(state.copyWith(
        joinRequests: updatedJoinRequests,
        isProcessingRequest: false,
        successMessage: 'Đã từ chối yêu cầu tham gia!',
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessingRequest: false,
        errorMessage: 'Lỗi khi từ chối yêu cầu: ${e.toString()}',
      ));
    }
  }

  void clearMessages() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }

  Future<void> refresh() async {
    if (state.currentTab == InvitationTab.invitations) {
      await loadInvitations();
    } else {
      await loadJoinRequests();
    }
  }
}