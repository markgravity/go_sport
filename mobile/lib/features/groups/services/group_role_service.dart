import '../../../core/network/api_client.dart';
import '../models/group_role.dart';
import '../models/group_permission.dart';

class GroupRoleService {
  static const String _baseUrl = '/groups';

  /// Get user's permissions in a group
  static Future<UserPermissions> getUserPermissions(int groupId) async {
    try {
      final response = await ApiClient.instance.get('$_baseUrl/$groupId/permissions');
      
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
  static Future<void> updateMemberRole(int groupId, int userId, GroupRole newRole) async {
    try {
      final response = await ApiClient.instance.post(
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
  static Future<void> removeMember(int groupId, int userId) async {
    try {
      final response = await ApiClient.instance.delete('$_baseUrl/$groupId/members/$userId');
      
      if (response.data['success'] != true) {
        throw Exception('Failed to remove member: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error removing member: $e');
    }
  }
}