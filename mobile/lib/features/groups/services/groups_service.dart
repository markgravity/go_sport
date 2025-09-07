import 'package:injectable/injectable.dart';
import '../../../core/network/api_client.dart';
import '../models/group.dart';
import '../models/sport.dart';

@injectable
class GroupsService {
  final ApiClient _apiClient;
  static const String _baseUrl = '/groups';
  static const String _sportsUrl = '/sports';
  
  GroupsService(this._apiClient);

  // Sports configuration methods
  Future<List<Sport>> getAvailableSports() async {
    try {
      final response = await _apiClient.get(_sportsUrl);
      
      if (response.data['success'] == true) {
        final Map<String, dynamic> sportsData = response.data['data']['sports'];
        return sportsData.entries.map((entry) => 
          Sport.fromJson(entry.key, entry.value)
        ).toList();
      } else {
        throw Exception('Failed to load sports: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching sports: $e');
    }
  }

  Future<Sport> getSportDetails(String sportType) async {
    try {
      final response = await _apiClient.get('$_sportsUrl/$sportType');
      
      if (response.data['success'] == true) {
        return Sport.fromJson(sportType, response.data['data']);
      } else {
        throw Exception('Failed to load sport details: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching sport details: $e');
    }
  }

  Future<SportDefaults> getSportDefaults(String sportType) async {
    try {
      final response = await _apiClient.get('$_sportsUrl/$sportType/defaults');
      
      if (response.data['success'] == true) {
        return SportDefaults.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load sport defaults: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching sport defaults: $e');
    }
  }

  Future<List<String>> getLocationSuggestions(String sportType, {String? city}) async {
    try {
      final queryParams = city != null ? {'city': city} : <String, String>{};
      final response = await _apiClient.get(
        '$_sportsUrl/$sportType/locations',
        queryParameters: queryParams,
      );
      
      if (response.data['success'] == true) {
        return List<String>.from(response.data['data']);
      } else {
        throw Exception('Failed to load location suggestions: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching location suggestions: $e');
    }
  }

  Future<List<String>> getNameSuggestions(String sportType, {String? city}) async {
    try {
      final queryParams = city != null ? {'city': city} : <String, String>{};
      final response = await _apiClient.get(
        '$_sportsUrl/$sportType/name-suggestions',
        queryParameters: queryParams,
      );
      
      if (response.data['success'] == true) {
        return List<String>.from(response.data['data']);
      } else {
        throw Exception('Failed to load name suggestions: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching name suggestions: $e');
    }
  }

  // Group management methods
  Future<List<Group>> getGroups({
    String? sportType,
    String? city,
    String? privacy,
    String? search,
    int page = 1,
    int perPage = 15,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'per_page': perPage,
      };
      
      if (sportType != null) queryParams['sport_type'] = sportType;
      if (city != null) queryParams['city'] = city;
      if (privacy != null) queryParams['privacy'] = privacy;
      if (search != null) queryParams['search'] = search;

      final response = await _apiClient.get(
        _baseUrl,
        queryParameters: queryParams,
      );
      
      if (response.data['success'] == true) {
        final List<dynamic> groupsData = response.data['data']['data'];
        return groupsData.map((json) => Group.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load groups: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching groups: $e');
    }
  }

  Future<Group> createGroup({
    required String name,
    String? description,
    required String sportType,
    required String skillLevel,
    required String location,
    required String city,
    String? district,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? schedule,
    int? maxMembers,
    double? membershipFee,
    required String privacy,
    String? avatar,
    Map<String, dynamic>? rules,
  }) async {
    try {
      final data = {
        'name': name,
        'description': description,
        'sport_type': sportType,
        'skill_level': skillLevel,
        'location': location,
        'city': city,
        'district': district,
        'latitude': latitude,
        'longitude': longitude,
        'schedule': schedule,
        'max_members': maxMembers,
        'membership_fee': membershipFee,
        'privacy': privacy,
        'avatar': avatar,
        'rules': rules,
      };

      // Remove null values
      data.removeWhere((key, value) => value == null);

      final response = await _apiClient.post(_baseUrl, data: data);
      
      if (response.data['success'] == true) {
        return Group.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to create group: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error creating group: $e');
    }
  }

  Future<Group> getGroup(int groupId) async {
    try {
      final response = await _apiClient.get('$_baseUrl/$groupId');
      
      if (response.data['success'] == true) {
        return Group.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load group: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching group: $e');
    }
  }

  Future<Group> updateGroup(
    int groupId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final response = await _apiClient.put('$_baseUrl/$groupId', data: updates);
      
      if (response.data['success'] == true) {
        return Group.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to update group: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error updating group: $e');
    }
  }

  Future<void> deleteGroup(int groupId) async {
    try {
      final response = await _apiClient.delete('$_baseUrl/$groupId');
      
      if (response.data['success'] != true) {
        throw Exception('Failed to delete group: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error deleting group: $e');
    }
  }

  Future<Map<String, dynamic>> joinGroup(int groupId, {String? joinReason}) async {
    try {
      final data = joinReason != null ? {'join_reason': joinReason} : <String, dynamic>{};
      final response = await _apiClient.post('$_baseUrl/$groupId/join', data: data);
      
      if (response.data['success'] == true) {
        return {
          'message': response.data['message'],
          'status': response.data['data']['status'],
          'role': response.data['data']['role'],
        };
      } else {
        throw Exception('Failed to join group: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error joining group: $e');
    }
  }

  Future<void> leaveGroup(int groupId) async {
    try {
      final response = await _apiClient.post('$_baseUrl/$groupId/leave');
      
      if (response.data['success'] != true) {
        throw Exception('Failed to leave group: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error leaving group: $e');
    }
  }

  Future<List<User>> getGroupMembers(int groupId) async {
    try {
      final response = await _apiClient.get('$_baseUrl/$groupId/members');
      
      if (response.data['success'] == true) {
        final List<dynamic> membersData = response.data['data'];
        return membersData.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load members: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching members: $e');
    }
  }

  // Additional methods needed by ViewModels

  /// Get detailed group information (alias for getGroup)
  Future<Group> getGroupDetails(String groupId) async {
    return await getGroup(int.parse(groupId));
  }

  /// Remove member from group
  Future<bool> removeMemberFromGroup({
    required String groupId,
    required String memberId,
  }) async {
    try {
      final response = await _apiClient.delete(
        '$_baseUrl/${int.parse(groupId)}/members/${int.parse(memberId)}'
      );
      return response.data['success'] == true;
    } catch (e) {
      throw Exception('Error removing member: $e');
    }
  }

  /// Generate invitation link for group
  Future<String> generateInvitationLink(String groupId) async {
    try {
      final response = await _apiClient.post(
        '$_baseUrl/${int.parse(groupId)}/invite'
      );
      if (response.data['success'] == true) {
        return response.data['data']['invitation_link'] as String;
      } else {
        throw Exception('Failed to generate invitation link: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error generating invitation link: $e');
    }
  }

  /// Update group settings
  Future<bool> updateGroupSettings({
    required String groupId,
    String? name,
    String? description,
    bool? isPrivate,
    String? location,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (description != null) data['description'] = description;
      if (isPrivate != null) data['privacy'] = isPrivate ? 'rieng_tu' : 'cong_khai';
      if (location != null) data['location'] = location;

      final response = await _apiClient.put(
        '$_baseUrl/${int.parse(groupId)}',
        data: data,
      );
      return response.data['success'] == true;
    } catch (e) {
      throw Exception('Error updating group settings: $e');
    }
  }
}