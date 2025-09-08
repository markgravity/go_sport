// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvitationAnalyticsImpl _$$InvitationAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationAnalyticsImpl(
      invitationId: (json['invitation_id'] as num).toInt(),
      eventType: json['event_type'] as String,
      userAgent: json['user_agent'] as String?,
      ipAddress: json['ip_address'] as String?,
      referrer: json['referrer'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$InvitationAnalyticsImplToJson(
        _$InvitationAnalyticsImpl instance) =>
    <String, dynamic>{
      'invitation_id': instance.invitationId,
      'event_type': instance.eventType,
      'user_agent': instance.userAgent,
      'ip_address': instance.ipAddress,
      'referrer': instance.referrer,
      'metadata': instance.metadata,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$AnalyticsSummaryImpl _$$AnalyticsSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$AnalyticsSummaryImpl(
      sent: (json['sent'] as num).toInt(),
      clicked: (json['clicked'] as num).toInt(),
      registered: (json['registered'] as num).toInt(),
      joined: (json['joined'] as num).toInt(),
      rejected: (json['rejected'] as num).toInt(),
      clickRate: (json['click_rate'] as num).toDouble(),
      conversionRate: (json['conversion_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$AnalyticsSummaryImplToJson(
        _$AnalyticsSummaryImpl instance) =>
    <String, dynamic>{
      'sent': instance.sent,
      'clicked': instance.clicked,
      'registered': instance.registered,
      'joined': instance.joined,
      'rejected': instance.rejected,
      'click_rate': instance.clickRate,
      'conversion_rate': instance.conversionRate,
    };

_$InvitationPerformanceImpl _$$InvitationPerformanceImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationPerformanceImpl(
      invitationId: (json['invitation_id'] as num).toInt(),
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: json['status'] as String,
      clicks: (json['clicks'] as num).toInt(),
      joins: (json['joins'] as num).toInt(),
      clickRate: (json['click_rate'] as num).toDouble(),
      conversionRate: (json['conversion_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$InvitationPerformanceImplToJson(
        _$InvitationPerformanceImpl instance) =>
    <String, dynamic>{
      'invitation_id': instance.invitationId,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt.toIso8601String(),
      'status': instance.status,
      'clicks': instance.clicks,
      'joins': instance.joins,
      'click_rate': instance.clickRate,
      'conversion_rate': instance.conversionRate,
    };

_$GroupAnalyticsImpl _$$GroupAnalyticsImplFromJson(Map<String, dynamic> json) =>
    _$GroupAnalyticsImpl(
      period: AnalyticsPeriod.fromJson(json['period'] as Map<String, dynamic>),
      summary: GroupAnalyticsSummary.fromJson(
          json['summary'] as Map<String, dynamic>),
      joinRequestStats: (json['join_request_stats'] as List<dynamic>)
          .map((e) => JoinRequestStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyActivity: (json['daily_activity'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => DailyActivity.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      topPerformers: (json['top_performers'] as List<dynamic>)
          .map((e) => InvitationPerformance.fromJson(e as Map<String, dynamic>))
          .toList(),
      allInvitations: (json['all_invitations'] as List<dynamic>)
          .map((e) => InvitationPerformance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GroupAnalyticsImplToJson(
        _$GroupAnalyticsImpl instance) =>
    <String, dynamic>{
      'period': instance.period.toJson(),
      'summary': instance.summary.toJson(),
      'join_request_stats':
          instance.joinRequestStats.map((e) => e.toJson()).toList(),
      'daily_activity': instance.dailyActivity
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'top_performers': instance.topPerformers.map((e) => e.toJson()).toList(),
      'all_invitations':
          instance.allInvitations.map((e) => e.toJson()).toList(),
    };

_$AnalyticsPeriodImpl _$$AnalyticsPeriodImplFromJson(
        Map<String, dynamic> json) =>
    _$AnalyticsPeriodImpl(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$$AnalyticsPeriodImplToJson(
        _$AnalyticsPeriodImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

_$GroupAnalyticsSummaryImpl _$$GroupAnalyticsSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupAnalyticsSummaryImpl(
      totalInvitations: (json['total_invitations'] as num).toInt(),
      totalClicks: (json['total_clicks'] as num).toInt(),
      totalJoins: (json['total_joins'] as num).toInt(),
      totalRejected: (json['total_rejected'] as num).toInt(),
      clickRate: json['click_rate'] as String,
      conversionRate: json['conversion_rate'] as String,
    );

Map<String, dynamic> _$$GroupAnalyticsSummaryImplToJson(
        _$GroupAnalyticsSummaryImpl instance) =>
    <String, dynamic>{
      'total_invitations': instance.totalInvitations,
      'total_clicks': instance.totalClicks,
      'total_joins': instance.totalJoins,
      'total_rejected': instance.totalRejected,
      'click_rate': instance.clickRate,
      'conversion_rate': instance.conversionRate,
    };

_$JoinRequestStatImpl _$$JoinRequestStatImplFromJson(
        Map<String, dynamic> json) =>
    _$JoinRequestStatImpl(
      status: json['status'] as String,
      source: json['source'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$JoinRequestStatImplToJson(
        _$JoinRequestStatImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'source': instance.source,
      'count': instance.count,
    };

_$DailyActivityImpl _$$DailyActivityImplFromJson(Map<String, dynamic> json) =>
    _$DailyActivityImpl(
      date: json['date'] as String,
      eventType: json['event_type'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$DailyActivityImplToJson(_$DailyActivityImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'event_type': instance.eventType,
      'count': instance.count,
    };

_$MemberGrowthAnalyticsImpl _$$MemberGrowthAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$MemberGrowthAnalyticsImpl(
      period: AnalyticsPeriod.fromJson(json['period'] as Map<String, dynamic>),
      summary:
          MemberGrowthSummary.fromJson(json['summary'] as Map<String, dynamic>),
      dailyGrowth: (json['daily_growth'] as List<dynamic>)
          .map((e) => DailyGrowth.fromJson(e as Map<String, dynamic>))
          .toList(),
      memberSources: (json['member_sources'] as List<dynamic>)
          .map((e) => MemberSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      invitationEffectiveness:
          (json['invitation_effectiveness'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) =>
                    InvitationEffectiveness.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$$MemberGrowthAnalyticsImplToJson(
        _$MemberGrowthAnalyticsImpl instance) =>
    <String, dynamic>{
      'period': instance.period.toJson(),
      'summary': instance.summary.toJson(),
      'daily_growth': instance.dailyGrowth.map((e) => e.toJson()).toList(),
      'member_sources': instance.memberSources.map((e) => e.toJson()).toList(),
      'invitation_effectiveness': instance.invitationEffectiveness
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
    };

_$MemberGrowthSummaryImpl _$$MemberGrowthSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$MemberGrowthSummaryImpl(
      newMembers: (json['new_members'] as num).toInt(),
      growthRate: json['growth_rate'] as String,
      currentTotal: (json['current_total'] as num).toInt(),
      capacityUsage: json['capacity_usage'] as String,
    );

Map<String, dynamic> _$$MemberGrowthSummaryImplToJson(
        _$MemberGrowthSummaryImpl instance) =>
    <String, dynamic>{
      'new_members': instance.newMembers,
      'growth_rate': instance.growthRate,
      'current_total': instance.currentTotal,
      'capacity_usage': instance.capacityUsage,
    };

_$DailyGrowthImpl _$$DailyGrowthImplFromJson(Map<String, dynamic> json) =>
    _$DailyGrowthImpl(
      date: json['date'] as String,
      newMembers: (json['new_members'] as num).toInt(),
    );

Map<String, dynamic> _$$DailyGrowthImplToJson(_$DailyGrowthImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'new_members': instance.newMembers,
    };

_$MemberSourceImpl _$$MemberSourceImplFromJson(Map<String, dynamic> json) =>
    _$MemberSourceImpl(
      joinReason: json['join_reason'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$MemberSourceImplToJson(_$MemberSourceImpl instance) =>
    <String, dynamic>{
      'join_reason': instance.joinReason,
      'count': instance.count,
    };

_$InvitationEffectivenessImpl _$$InvitationEffectivenessImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationEffectivenessImpl(
      source: json['source'] as String,
      status: json['status'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$InvitationEffectivenessImplToJson(
        _$InvitationEffectivenessImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'status': instance.status,
      'count': instance.count,
    };

_$InvitationDetailedAnalyticsImpl _$$InvitationDetailedAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationDetailedAnalyticsImpl(
      invitation: InvitationAnalyticsData.fromJson(
          json['invitation'] as Map<String, dynamic>),
      summary:
          AnalyticsSummary.fromJson(json['summary'] as Map<String, dynamic>),
      recentEvents: (json['recent_events'] as List<dynamic>)
          .map((e) => InvitationAnalytics.fromJson(e as Map<String, dynamic>))
          .toList(),
      joinRequests: (json['join_requests'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      performance: InvitationPerformanceMetrics.fromJson(
          json['performance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InvitationDetailedAnalyticsImplToJson(
        _$InvitationDetailedAnalyticsImpl instance) =>
    <String, dynamic>{
      'invitation': instance.invitation.toJson(),
      'summary': instance.summary.toJson(),
      'recent_events': instance.recentEvents.map((e) => e.toJson()).toList(),
      'join_requests': instance.joinRequests,
      'performance': instance.performance.toJson(),
    };

_$InvitationAnalyticsDataImpl _$$InvitationAnalyticsDataImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationAnalyticsDataImpl(
      id: (json['id'] as num).toInt(),
      groupId: (json['group_id'] as num).toInt(),
      token: json['token'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$InvitationAnalyticsDataImplToJson(
        _$InvitationAnalyticsDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'token': instance.token,
      'type': instance.type,
      'status': instance.status,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

_$InvitationPerformanceMetricsImpl _$$InvitationPerformanceMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationPerformanceMetricsImpl(
      clickRate: json['click_rate'] as String,
      conversionRate: json['conversion_rate'] as String,
      totalClicks: (json['total_clicks'] as num).toInt(),
      totalJoins: (json['total_joins'] as num).toInt(),
    );

Map<String, dynamic> _$$InvitationPerformanceMetricsImplToJson(
        _$InvitationPerformanceMetricsImpl instance) =>
    <String, dynamic>{
      'click_rate': instance.clickRate,
      'conversion_rate': instance.conversionRate,
      'total_clicks': instance.totalClicks,
      'total_joins': instance.totalJoins,
    };
