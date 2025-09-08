import 'package:injectable/injectable.dart';
import '../../../core/network/api_client.dart';
import '../models/group_invitation.dart';

@injectable
class InvitationService {
  final ApiClient _apiClient;
  
  InvitationService(this._apiClient);

  /// Get all invitations for a specific group
  Future<List<GroupInvitation>> getGroupInvitations(int groupId) async {
    try {
      final response = await _apiClient.get('/groups/$groupId/invitations');
      
      if (response.data['success'] == true) {
        final List<dynamic> invitationsData = response.data['data']['data'] ?? [];
        return invitationsData
            .map((json) => GroupInvitation.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load invitations: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching group invitations: $e');
    }
  }

  /// Create a new invitation for a group
  Future<GroupInvitation> createInvitation(int groupId, {
    String type = 'link',
    int? expiresInDays,
  }) async {
    try {
      final data = <String, dynamic>{
        'type': type,
        if (expiresInDays != null) 'expires_in_days': expiresInDays,
      };

      final response = await _apiClient.post('/groups/$groupId/invitations', data: data);
      
      if (response.data['success'] == true) {
        return GroupInvitation.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to create invitation: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error creating invitation: $e');
    }
  }

  /// Revoke/delete an invitation
  Future<void> deleteInvitation(int groupId, int invitationId) async {
    try {
      final response = await _apiClient.delete('/groups/$groupId/invitations/$invitationId');
      
      if (response.data['success'] != true) {
        throw Exception('Failed to delete invitation: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error deleting invitation: $e');
    }
  }

  /// Get invitation details
  Future<GroupInvitation> getInvitation(int groupId, int invitationId) async {
    try {
      final response = await _apiClient.get('/groups/$groupId/invitations/$invitationId');
      
      if (response.data['success'] == true) {
        return GroupInvitation.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load invitation: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching invitation: $e');
    }
  }

  /// Validate an invitation by token
  Future<Map<String, dynamic>> validateInvitationToken(String token) async {
    try {
      final response = await _apiClient.get('/invitations/validate/$token');
      
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception('Failed to validate invitation: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error validating invitation: $e');
    }
  }

  /// Get group preview from invitation token
  Future<Map<String, dynamic>> getGroupPreview(String token) async {
    try {
      final response = await _apiClient.get('/invitations/preview/$token');
      
      if (response.data['success'] == true) {
        return response.data['data'];
      } else {
        throw Exception('Failed to load group preview: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching group preview: $e');
    }
  }

  /// Get user's join requests
  Future<List<GroupJoinRequest>> getMyJoinRequests() async {
    try {
      final response = await _apiClient.get('/join-requests/my-requests');
      
      if (response.data['success'] == true) {
        final List<dynamic> requestsData = response.data['data']['data'] ?? [];
        return requestsData
            .map((json) => GroupJoinRequest.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load join requests: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching join requests: $e');
    }
  }

  /// Create a join request
  Future<GroupJoinRequest> createJoinRequest({
    required int groupId,
    int? invitationId,
    String? message,
    String source = 'direct',
  }) async {
    try {
      final data = <String, dynamic>{
        'group_id': groupId,
        if (invitationId != null) 'invitation_id': invitationId,
        if (message != null && message.isNotEmpty) 'message': message,
        'source': source,
      };

      final response = await _apiClient.post('/join-requests', data: data);
      
      if (response.data['success'] == true) {
        return GroupJoinRequest.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to create join request: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error creating join request: $e');
    }
  }

  /// Cancel a pending join request
  Future<void> cancelJoinRequest(int joinRequestId) async {
    try {
      final response = await _apiClient.delete('/join-requests/$joinRequestId');
      
      if (response.data['success'] != true) {
        throw Exception('Failed to cancel join request: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error cancelling join request: $e');
    }
  }

  /// Get join requests for a specific group (admin/moderator only)
  Future<List<GroupJoinRequest>> getGroupJoinRequests(int groupId, {String? status}) async {
    try {
      final queryParams = status != null ? '?status=$status' : '';
      final response = await _apiClient.get('/groups/$groupId/join-requests$queryParams');
      
      if (response.data['success'] == true) {
        final List<dynamic> requestsData = response.data['data']['data'] ?? [];
        return requestsData
            .map((json) => GroupJoinRequest.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load group join requests: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching group join requests: $e');
    }
  }

  /// Approve a join request
  Future<GroupJoinRequest> approveJoinRequest(int groupId, int joinRequestId, {String role = 'member'}) async {
    try {
      final data = {'role': role};
      final response = await _apiClient.post('/groups/$groupId/join-requests/$joinRequestId/approve', data: data);
      
      if (response.data['success'] == true) {
        return GroupJoinRequest.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to approve join request: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error approving join request: $e');
    }
  }

  /// Reject a join request
  Future<GroupJoinRequest> rejectJoinRequest(int groupId, int joinRequestId, {String? reason}) async {
    try {
      final data = <String, dynamic>{
        if (reason != null && reason.isNotEmpty) 'reason': reason,
      };
      
      final response = await _apiClient.post('/groups/$groupId/join-requests/$joinRequestId/reject', data: data);
      
      if (response.data['success'] == true) {
        return GroupJoinRequest.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to reject join request: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error rejecting join request: $e');
    }
  }

  /// Revoke an invitation
  Future<void> revokeInvitation(String token) async {
    try {
      final response = await _apiClient.delete('/invitations/$token');
      
      if (response.data['success'] != true) {
        throw Exception('Failed to revoke invitation: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error revoking invitation: $e');
    }
  }

  /// Resend SMS invitation
  Future<void> resendSmsInvitation(int groupId, int invitationId) async {
    try {
      final response = await _apiClient.post('/groups/$groupId/invitations/$invitationId/resend-sms');
      
      if (response.data['success'] != true) {
        throw Exception('Failed to resend SMS: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error resending SMS invitation: $e');
    }
  }
}