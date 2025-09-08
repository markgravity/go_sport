import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation_analytics.freezed.dart';
part 'invitation_analytics.g.dart';

@freezed
class InvitationAnalytics with _$InvitationAnalytics {
  const factory InvitationAnalytics({
    @JsonKey(name: 'invitation_id') required int invitationId,
    @JsonKey(name: 'event_type') required String eventType,
    @JsonKey(name: 'user_agent') String? userAgent,
    @JsonKey(name: 'ip_address') String? ipAddress,
    String? referrer,
    Map<String, dynamic>? metadata,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _InvitationAnalytics;

  factory InvitationAnalytics.fromJson(Map<String, dynamic> json) =>
      _$InvitationAnalyticsFromJson(json);
}

@freezed
class AnalyticsSummary with _$AnalyticsSummary {
  const factory AnalyticsSummary({
    required int sent,
    required int clicked,
    required int registered,
    required int joined,
    required int rejected,
    @JsonKey(name: 'click_rate') required double clickRate,
    @JsonKey(name: 'conversion_rate') required double conversionRate,
  }) = _AnalyticsSummary;

  factory AnalyticsSummary.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsSummaryFromJson(json);
}

@freezed
class InvitationPerformance with _$InvitationPerformance {
  const factory InvitationPerformance({
    @JsonKey(name: 'invitation_id') required int invitationId,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required String status,
    required int clicks,
    required int joins,
    @JsonKey(name: 'click_rate') required double clickRate,
    @JsonKey(name: 'conversion_rate') required double conversionRate,
  }) = _InvitationPerformance;

  factory InvitationPerformance.fromJson(Map<String, dynamic> json) =>
      _$InvitationPerformanceFromJson(json);
}

@freezed
class GroupAnalytics with _$GroupAnalytics {
  const factory GroupAnalytics({
    required AnalyticsPeriod period,
    required GroupAnalyticsSummary summary,
    @JsonKey(name: 'join_request_stats') required List<JoinRequestStat> joinRequestStats,
    @JsonKey(name: 'daily_activity') required Map<String, List<DailyActivity>> dailyActivity,
    @JsonKey(name: 'top_performers') required List<InvitationPerformance> topPerformers,
    @JsonKey(name: 'all_invitations') required List<InvitationPerformance> allInvitations,
  }) = _GroupAnalytics;

  factory GroupAnalytics.fromJson(Map<String, dynamic> json) =>
      _$GroupAnalyticsFromJson(json);
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
    @JsonKey(name: 'total_invitations') required int totalInvitations,
    @JsonKey(name: 'total_clicks') required int totalClicks,
    @JsonKey(name: 'total_joins') required int totalJoins,
    @JsonKey(name: 'total_rejected') required int totalRejected,
    @JsonKey(name: 'click_rate') required String clickRate,
    @JsonKey(name: 'conversion_rate') required String conversionRate,
  }) = _GroupAnalyticsSummary;

  factory GroupAnalyticsSummary.fromJson(Map<String, dynamic> json) =>
      _$GroupAnalyticsSummaryFromJson(json);
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
    @JsonKey(name: 'event_type') required String eventType,
    required int count,
  }) = _DailyActivity;

  factory DailyActivity.fromJson(Map<String, dynamic> json) =>
      _$DailyActivityFromJson(json);
}

@freezed
class MemberGrowthAnalytics with _$MemberGrowthAnalytics {
  const factory MemberGrowthAnalytics({
    required AnalyticsPeriod period,
    required MemberGrowthSummary summary,
    @JsonKey(name: 'daily_growth') required List<DailyGrowth> dailyGrowth,
    @JsonKey(name: 'member_sources') required List<MemberSource> memberSources,
    @JsonKey(name: 'invitation_effectiveness') required Map<String, List<InvitationEffectiveness>> invitationEffectiveness,
  }) = _MemberGrowthAnalytics;

  factory MemberGrowthAnalytics.fromJson(Map<String, dynamic> json) =>
      _$MemberGrowthAnalyticsFromJson(json);
}

@freezed
class MemberGrowthSummary with _$MemberGrowthSummary {
  const factory MemberGrowthSummary({
    @JsonKey(name: 'new_members') required int newMembers,
    @JsonKey(name: 'growth_rate') required String growthRate,
    @JsonKey(name: 'current_total') required int currentTotal,
    @JsonKey(name: 'capacity_usage') required String capacityUsage,
  }) = _MemberGrowthSummary;

  factory MemberGrowthSummary.fromJson(Map<String, dynamic> json) =>
      _$MemberGrowthSummaryFromJson(json);
}

@freezed
class DailyGrowth with _$DailyGrowth {
  const factory DailyGrowth({
    required String date,
    @JsonKey(name: 'new_members') required int newMembers,
  }) = _DailyGrowth;

  factory DailyGrowth.fromJson(Map<String, dynamic> json) =>
      _$DailyGrowthFromJson(json);
}

@freezed
class MemberSource with _$MemberSource {
  const factory MemberSource({
    @JsonKey(name: 'join_reason') required String joinReason,
    required int count,
  }) = _MemberSource;

  factory MemberSource.fromJson(Map<String, dynamic> json) =>
      _$MemberSourceFromJson(json);
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
    @JsonKey(name: 'recent_events') required List<InvitationAnalytics> recentEvents,
    @JsonKey(name: 'join_requests') required List<Map<String, dynamic>> joinRequests,
    required InvitationPerformanceMetrics performance,
  }) = _InvitationDetailedAnalytics;

  factory InvitationDetailedAnalytics.fromJson(Map<String, dynamic> json) =>
      _$InvitationDetailedAnalyticsFromJson(json);
}

@freezed
class InvitationAnalyticsData with _$InvitationAnalyticsData {
  const factory InvitationAnalyticsData({
    required int id,
    @JsonKey(name: 'group_id') required int groupId,
    required String token,
    required String type,
    required String status,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _InvitationAnalyticsData;

  factory InvitationAnalyticsData.fromJson(Map<String, dynamic> json) =>
      _$InvitationAnalyticsDataFromJson(json);
}

@freezed
class InvitationPerformanceMetrics with _$InvitationPerformanceMetrics {
  const factory InvitationPerformanceMetrics({
    @JsonKey(name: 'click_rate') required String clickRate,
    @JsonKey(name: 'conversion_rate') required String conversionRate,
    @JsonKey(name: 'total_clicks') required int totalClicks,
    @JsonKey(name: 'total_joins') required int totalJoins,
  }) = _InvitationPerformanceMetrics;

  factory InvitationPerformanceMetrics.fromJson(Map<String, dynamic> json) =>
      _$InvitationPerformanceMetricsFromJson(json);
}