import 'package:injectable/injectable.dart';
import '../../../core/network/api_client.dart';
import '../models/group_role.dart';
import '../models/group_permission.dart';

@injectable
class GroupRoleService {
  final ApiClient _apiClient;
  static const String _baseUrl = '/groups';
  
  GroupRoleService(this._apiClient);

  /// Get user's permissions in a group
  Future<UserPermissions> getUserPermissions(int groupId) async {
    try {
      final response = await _apiClient.get('$_baseUrl/$groupId/permissions');
      
      if (response.data['success'] == true) {
        return UserPermissions.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to get permissions: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching user permissions: $e');
    }
  }

  /// Update member role
  Future<void> updateMemberRole(int groupId, int userId, GroupRole newRole) async {
    try {
      final response = await _apiClient.post(
        '$_baseUrl/$groupId/members/$userId/role',
        data: {'role': newRole.value},
      );
      
      if (response.data['success'] != true) {
        throw Exception('Failed to update role: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error updating member role: $e');
    }
  }

  /// Remove member from group
  Future<void> removeMember(int groupId, int userId) async {
    try {
      final response = await _apiClient.delete('$_baseUrl/$groupId/members/$userId');
      
      if (response.data['success'] != true) {
        throw Exception('Failed to remove member: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error removing member: $e');
    }
  }

  // Additional methods needed by ViewModels

  /// Assign role to group member
  Future<bool> assignMemberRole({
    required String groupId,
    required String memberId,
    required VietnameseGroupRole role,
  }) async {
    try {
      final response = await _apiClient.put(
        '$_baseUrl/${int.parse(groupId)}/members/${int.parse(memberId)}/role',
        data: {'role': role.value},
      );
      return response.data['success'] == true;
    } catch (e) {
      throw Exception('Error assigning member role: $e');
    }
  }
}