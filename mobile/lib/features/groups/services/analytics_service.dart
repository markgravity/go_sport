import 'package:injectable/injectable.dart';
import '../../../core/network/api_client.dart';
import '../models/invitation_analytics.dart';

@injectable
class AnalyticsService {
  final ApiClient _apiClient;

  AnalyticsService(this._apiClient);

  Future<GroupAnalytics> getGroupAnalytics(
    int groupId, {
    String? startDate,
    String? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (startDate != null) queryParams['start_date'] = startDate;
      if (endDate != null) queryParams['end_date'] = endDate;

      final response = await _apiClient.get(
        '/groups/$groupId/analytics',
        queryParameters: queryParams,
      );

      if (response.data['success'] == true) {
        return GroupAnalytics.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load group analytics: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching group analytics: $e');
    }
  }

  Future<MemberGrowthAnalytics> getMemberGrowthAnalytics(
    int groupId, {
    String? startDate,
    String? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (startDate != null) queryParams['start_date'] = startDate;
      if (endDate != null) queryParams['end_date'] = endDate;

      final response = await _apiClient.get(
        '/groups/$groupId/analytics/growth',
        queryParameters: queryParams,
      );

      if (response.data['success'] == true) {
        return MemberGrowthAnalytics.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load member growth analytics: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching member growth analytics: $e');
    }
  }

  Future<InvitationDetailedAnalytics> getInvitationAnalytics(
    int groupId,
    int invitationId,
  ) async {
    try {
      final response = await _apiClient.get(
        '/groups/$groupId/invitations/$invitationId/analytics',
      );

      if (response.data['success'] == true) {
        return InvitationDetailedAnalytics.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load invitation analytics: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching invitation analytics: $e');
    }
  }

  Future<void> trackInvitationEvent({
    required String invitationToken,
    required String eventType,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _apiClient.post(
        '/analytics/track-event',
        data: {
          'invitation_token': invitationToken,
          'event_type': eventType,
          if (metadata != null) 'metadata': metadata,
        },
      );

      if (response.data['success'] != true) {
        throw Exception('Failed to track event: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error tracking invitation event: $e');
    }
  }
}

extension AnalyticsServiceExtensions on AnalyticsService {
  // Helper methods for common analytics tracking
  Future<void> trackInvitationClick(String token) =>
      trackInvitationEvent(invitationToken: token, eventType: 'clicked');

  Future<void> trackInvitationShare(String token) =>
      trackInvitationEvent(invitationToken: token, eventType: 'shared');

  Future<void> trackInvitationCopy(String token) =>
      trackInvitationEvent(invitationToken: token, eventType: 'copied');

  // Get analytics for the last 7 days
  Future<GroupAnalytics> getWeeklyGroupAnalytics(int groupId) {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 7));
    
    return getGroupAnalytics(
      groupId,
      startDate: startDate.toIso8601String().split('T')[0],
      endDate: endDate.toIso8601String().split('T')[0],
    );
  }

  // Get analytics for the last 30 days
  Future<GroupAnalytics> getMonthlyGroupAnalytics(int groupId) {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 30));
    
    return getGroupAnalytics(
      groupId,
      startDate: startDate.toIso8601String().split('T')[0],
      endDate: endDate.toIso8601String().split('T')[0],
    );
  }

  // Get member growth for the last 30 days
  Future<MemberGrowthAnalytics> getMonthlyGrowthAnalytics(int groupId) {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 30));
    
    return getMemberGrowthAnalytics(
      groupId,
      startDate: startDate.toIso8601String().split('T')[0],
      endDate: endDate.toIso8601String().split('T')[0],
    );
  }
}