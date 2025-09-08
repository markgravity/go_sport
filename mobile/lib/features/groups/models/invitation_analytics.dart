import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation_analytics.freezed.dart';
part 'invitation_analytics.g.dart';

@freezed
class InvitationAnalytics with _$InvitationAnalytics {
  const factory InvitationAnalytics({
    required int invitationId,
    required String eventType,
    String? userAgent,
    String? ipAddress,
    String? referrer,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
  }) = _InvitationAnalytics;

  factory InvitationAnalytics.fromJson(Map<String, dynamic> json) =>
      _$InvitationAnalyticsFromJson({
        'invitationId': json['invitation_id'],
        'eventType': json['event_type'],
        'userAgent': json['user_agent'],
        'ipAddress': json['ip_address'],
        'referrer': json['referrer'],
        'metadata': json['metadata'],
        'createdAt': json['created_at'],
      });
}

@freezed
class AnalyticsSummary with _$AnalyticsSummary {
  const factory AnalyticsSummary({
    required int sent,
    required int clicked,
    required int registered,
    required int joined,
    required int rejected,
    required double clickRate,
    required double conversionRate,
  }) = _AnalyticsSummary;

  factory AnalyticsSummary.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsSummaryFromJson({
        'sent': json['sent'],
        'clicked': json['clicked'],
        'registered': json['registered'],
        'joined': json['joined'],
        'rejected': json['rejected'],
        'clickRate': json['click_rate'],
        'conversionRate': json['conversion_rate'],
      });
}

@freezed
class InvitationPerformance with _$InvitationPerformance {
  const factory InvitationPerformance({
    required int invitationId,
    required String createdBy,
    required DateTime createdAt,
    required String status,
    required int clicks,
    required int joins,
    required double clickRate,
    required double conversionRate,
  }) = _InvitationPerformance;

  factory InvitationPerformance.fromJson(Map<String, dynamic> json) =>
      _$InvitationPerformanceFromJson({
        'invitationId': json['invitation_id'],
        'createdBy': json['created_by'],
        'createdAt': json['created_at'],
        'status': json['status'],
        'clicks': json['clicks'],
        'joins': json['joins'],
        'clickRate': json['click_rate'],
        'conversionRate': json['conversion_rate'],
      });
}

@freezed
class GroupAnalytics with _$GroupAnalytics {
  const factory GroupAnalytics({
    required AnalyticsPeriod period,
    required GroupAnalyticsSummary summary,
    required List<JoinRequestStat> joinRequestStats,
    required Map<String, List<DailyActivity>> dailyActivity,
    required List<InvitationPerformance> topPerformers,
    required List<InvitationPerformance> allInvitations,
  }) = _GroupAnalytics;

  factory GroupAnalytics.fromJson(Map<String, dynamic> json) =>
      _$GroupAnalyticsFromJson({
        'period': json['period'],
        'summary': json['summary'],
        'joinRequestStats': json['join_request_stats'],
        'dailyActivity': json['daily_activity'],
        'topPerformers': json['top_performers'],
        'allInvitations': json['all_invitations'],
      });
}

@freezed
class AnalyticsPeriod with _$AnalyticsPeriod {
  const factory AnalyticsPeriod({
    required String start,
    required String end,
  }) = _AnalyticsPeriod;

  factory AnalyticsPeriod.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsPeriodFromJson(json);
}

@freezed
class GroupAnalyticsSummary with _$GroupAnalyticsSummary {
  const factory GroupAnalyticsSummary({
    required int totalInvitations,
    required int totalClicks,
    required int totalJoins,
    required int totalRejected,
    required String clickRate,
    required String conversionRate,
  }) = _GroupAnalyticsSummary;

  factory GroupAnalyticsSummary.fromJson(Map<String, dynamic> json) =>
      _$GroupAnalyticsSummaryFromJson({
        'totalInvitations': json['total_invitations'],
        'totalClicks': json['total_clicks'],
        'totalJoins': json['total_joins'],
        'totalRejected': json['total_rejected'],
        'clickRate': json['click_rate'],
        'conversionRate': json['conversion_rate'],
      });
}

@freezed
class JoinRequestStat with _$JoinRequestStat {
  const factory JoinRequestStat({
    required String status,
    required String source,
    required int count,
  }) = _JoinRequestStat;

  factory JoinRequestStat.fromJson(Map<String, dynamic> json) =>
      _$JoinRequestStatFromJson(json);
}

@freezed
class DailyActivity with _$DailyActivity {
  const factory DailyActivity({
    required String date,
    required String eventType,
    required int count,
  }) = _DailyActivity;

  factory DailyActivity.fromJson(Map<String, dynamic> json) =>
      _$DailyActivityFromJson({
        'date': json['date'],
        'eventType': json['event_type'],
        'count': json['count'],
      });
}

@freezed
class MemberGrowthAnalytics with _$MemberGrowthAnalytics {
  const factory MemberGrowthAnalytics({
    required AnalyticsPeriod period,
    required MemberGrowthSummary summary,
    required List<DailyGrowth> dailyGrowth,
    required List<MemberSource> memberSources,
    required Map<String, List<InvitationEffectiveness>> invitationEffectiveness,
  }) = _MemberGrowthAnalytics;

  factory MemberGrowthAnalytics.fromJson(Map<String, dynamic> json) =>
      _$MemberGrowthAnalyticsFromJson({
        'period': json['period'],
        'summary': json['summary'],
        'dailyGrowth': json['daily_growth'],
        'memberSources': json['member_sources'],
        'invitationEffectiveness': json['invitation_effectiveness'],
      });
}

@freezed
class MemberGrowthSummary with _$MemberGrowthSummary {
  const factory MemberGrowthSummary({
    required int newMembers,
    required String growthRate,
    required int currentTotal,
    required String capacityUsage,
  }) = _MemberGrowthSummary;

  factory MemberGrowthSummary.fromJson(Map<String, dynamic> json) =>
      _$MemberGrowthSummaryFromJson({
        'newMembers': json['new_members'],
        'growthRate': json['growth_rate'],
        'currentTotal': json['current_total'],
        'capacityUsage': json['capacity_usage'],
      });
}

@freezed
class DailyGrowth with _$DailyGrowth {
  const factory DailyGrowth({
    required String date,
    required int newMembers,
  }) = _DailyGrowth;

  factory DailyGrowth.fromJson(Map<String, dynamic> json) =>
      _$DailyGrowthFromJson({
        'date': json['date'],
        'newMembers': json['new_members'],
      });
}

@freezed
class MemberSource with _$MemberSource {
  const factory MemberSource({
    required String joinReason,
    required int count,
  }) = _MemberSource;

  factory MemberSource.fromJson(Map<String, dynamic> json) =>
      _$MemberSourceFromJson({
        'joinReason': json['join_reason'],
        'count': json['count'],
      });
}

@freezed
class InvitationEffectiveness with _$InvitationEffectiveness {
  const factory InvitationEffectiveness({
    required String source,
    required String status,
    required int count,
  }) = _InvitationEffectiveness;

  factory InvitationEffectiveness.fromJson(Map<String, dynamic> json) =>
      _$InvitationEffectivenessFromJson(json);
}

@freezed
class InvitationDetailedAnalytics with _$InvitationDetailedAnalytics {
  const factory InvitationDetailedAnalytics({
    required InvitationAnalyticsData invitation,
    required AnalyticsSummary summary,
    required List<InvitationAnalytics> recentEvents,
    required List<Map<String, dynamic>> joinRequests,
    required InvitationPerformanceMetrics performance,
  }) = _InvitationDetailedAnalytics;

  factory InvitationDetailedAnalytics.fromJson(Map<String, dynamic> json) =>
      _$InvitationDetailedAnalyticsFromJson({
        'invitation': json['invitation'],
        'summary': json['summary'],
        'recentEvents': json['recent_events'],
        'joinRequests': json['join_requests'],
        'performance': json['performance'],
      });
}

@freezed
class InvitationAnalyticsData with _$InvitationAnalyticsData {
  const factory InvitationAnalyticsData({
    required int id,
    required int groupId,
    required String token,
    required String type,
    required String status,
    DateTime? expiresAt,
    required DateTime createdAt,
  }) = _InvitationAnalyticsData;

  factory InvitationAnalyticsData.fromJson(Map<String, dynamic> json) =>
      _$InvitationAnalyticsDataFromJson({
        'id': json['id'],
        'groupId': json['group_id'],
        'token': json['token'],
        'type': json['type'],
        'status': json['status'],
        'expiresAt': json['expires_at'],
        'createdAt': json['created_at'],
      });
}

@freezed
class InvitationPerformanceMetrics with _$InvitationPerformanceMetrics {
  const factory InvitationPerformanceMetrics({
    required String clickRate,
    required String conversionRate,
    required int totalClicks,
    required int totalJoins,
  }) = _InvitationPerformanceMetrics;

  factory InvitationPerformanceMetrics.fromJson(Map<String, dynamic> json) =>
      _$InvitationPerformanceMetricsFromJson({
        'clickRate': json['click_rate'],
        'conversionRate': json['conversion_rate'],
        'totalClicks': json['total_clicks'],
        'totalJoins': json['total_joins'],
      });
}