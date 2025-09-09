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
      
      // Laravel API returns paginated data directly
      final List<dynamic> invitationsData = response.data['data'] ?? [];
      return invitationsData
          .map((json) => GroupInvitation.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error fetching group invitations: $e');
    }
  }

  /// Create a new invitation for a group
  Future<GroupInvitation> createInvitation(int groupId, {
    String type = 'link',
    String? expiresIn,
  }) async {
    try {
      final data = <String, dynamic>{
        'type': type,
        if (expiresIn != null) 'expires_in': expiresIn,
      };

      final response = await _apiClient.post('/groups/$groupId/invitations', data: data);
      
      // Laravel API returns the invitation data directly in the 'invitation' field
      if (response.data['invitation'] != null) {
        return GroupInvitation.fromJson(response.data['invitation']);
      } else {
        throw Exception('Failed to create invitation: ${response.data['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Error creating invitation: $e');
    }
  }

  /// Revoke/delete an invitation
  Future<void> deleteInvitation(int groupId, int invitationId) async {
    try {
      await _apiClient.delete('/groups/$groupId/invitations/$invitationId');
      // If no exception is thrown, the deletion was successful
    } catch (e) {
      throw Exception('Error deleting invitation: $e');
    }
  }

  /// Get invitation details
  Future<GroupInvitation> getInvitation(int groupId, int invitationId) async {
    try {
      final response = await _apiClient.get('/groups/$groupId/invitations/$invitationId');
      return GroupInvitation.fromJson(response.data);
    } catch (e) {
      throw Exception('Error fetching invitation: $e');
    }
  }

  /// Validate an invitation by token
  Future<Map<String, dynamic>> validateInvitationToken(String token) async {
    try {
      final response = await _apiClient.get('/invitations/$token/validate');
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      throw Exception('Error validating invitation: $e');
    }
  }

  /// Get group preview from invitation token
  Future<Map<String, dynamic>> getGroupPreview(String token) async {
    try {
      final response = await _apiClient.get('/invitations/$token/preview');
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      throw Exception('Error fetching group preview: $e');
    }
  }


  /// Revoke an invitation
  Future<void> revokeInvitation(String token) async {
    try {
      await _apiClient.delete('/invitations/$token');
      // If no exception is thrown, the revocation was successful
    } catch (e) {
      throw Exception('Error revoking invitation: $e');
    }
  }

  /// Resend SMS invitation
  Future<void> resendSmsInvitation(int groupId, int invitationId) async {
    try {
      await _apiClient.post('/groups/$groupId/invitations/$invitationId/resend-sms');
      // If no exception is thrown, the SMS was sent successfully
    } catch (e) {
      throw Exception('Error resending SMS invitation: $e');
    }
  }
}