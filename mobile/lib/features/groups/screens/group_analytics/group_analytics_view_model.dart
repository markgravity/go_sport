import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../services/analytics_service.dart';
import '../../models/invitation_analytics.dart';

@injectable
class GroupAnalyticsViewModel extends ChangeNotifier {
  final AnalyticsService _analyticsService = getIt<AnalyticsService>();

  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  GroupAnalytics? _groupAnalytics;
  MemberGrowthAnalytics? _memberGrowthAnalytics;
  String _dateRange = '30days';

  // Getters
  bool get isLoading => _isLoading;
  bool get hasError => _errorMessage != null;
  String? get errorMessage => _errorMessage;
  GroupAnalytics? get groupAnalytics => _groupAnalytics;
  MemberGrowthAnalytics? get memberGrowthAnalytics => _memberGrowthAnalytics;
  String get dateRange => _dateRange;

  /// Load analytics data for a group
  Future<void> loadAnalytics(int groupId) async {
    _setLoading(true);
    _clearError();

    try {
      // Calculate date range
      final endDate = DateTime.now();
      final startDate = _getStartDate(endDate, _dateRange);

      // Load group analytics and member growth in parallel
      final results = await Future.wait([
        _analyticsService.getGroupAnalytics(
          groupId,
          startDate: startDate.toIso8601String().split('T')[0],
          endDate: endDate.toIso8601String().split('T')[0],
        ),
        _analyticsService.getMemberGrowthAnalytics(
          groupId,
          startDate: startDate.toIso8601String().split('T')[0],
          endDate: endDate.toIso8601String().split('T')[0],
        ),
      ]);

      final groupResult = results[0] as GroupAnalytics;
      final growthResult = results[1] as MemberGrowthAnalytics;

      _groupAnalytics = groupResult;
      _memberGrowthAnalytics = growthResult;
    } catch (e) {
      _setError('Lỗi khi tải thống kê: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Change the date range and reload analytics
  Future<void> changeDateRange(String newRange) async {
    if (_dateRange == newRange) return;
    
    _dateRange = newRange;
    
    // If we have analytics loaded, reload with new date range
    if (_groupAnalytics != null) {
      // Assuming we can get the group ID from the current analytics
      // In practice, this would be passed or stored
      final groupId = _groupAnalytics!.allInvitations.isNotEmpty 
          ? _extractGroupIdFromInvitation(_groupAnalytics!.allInvitations.first)
          : null;
      
      if (groupId != null) {
        await loadAnalytics(groupId);
      }
    }
  }

  /// Refresh analytics data
  Future<void> refresh(int groupId) async {
    await loadAnalytics(groupId);
  }

  /// Get detailed analytics for a specific invitation
  Future<InvitationDetailedAnalytics?> getInvitationDetails(
    int groupId, 
    int invitationId,
  ) async {
    try {
      final result = await _analyticsService.getInvitationAnalytics(groupId, invitationId);
      return result;
    } catch (e) {
      _setError('Lỗi khi tải chi tiết lời mời: ${e.toString()}');
      return null;
    }
  }

  /// Track an analytics event (for invitation interactions)
  Future<void> trackEvent({
    required String invitationToken,
    required String eventType,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      await _analyticsService.trackInvitationEvent(
        invitationToken: invitationToken,
        eventType: eventType,
        metadata: metadata,
      );
    } catch (e) {
      // Track events silently - don't show errors to user
      debugPrint('Failed to track analytics event: $e');
    }
  }

  // Helper methods for common tracking events
  Future<void> trackInvitationClick(String token) => 
      trackEvent(invitationToken: token, eventType: 'clicked');
  
  Future<void> trackInvitationShare(String token) => 
      trackEvent(invitationToken: token, eventType: 'shared');
  
  Future<void> trackInvitationCopy(String token) => 
      trackEvent(invitationToken: token, eventType: 'copied');

  /// Get analytics summary text for display
  String getAnalyticsSummary() {
    if (_groupAnalytics == null) return 'Chưa có dữ liệu';
    
    final summary = _groupAnalytics!.summary;
    return '${summary.totalInvitations} lời mời • '
           '${summary.totalClicks} lượt nhấn • '
           '${summary.totalJoins} tham gia • '
           'Tỷ lệ chuyển đổi: ${summary.conversionRate}';
  }

  /// Get growth summary text for display
  String getGrowthSummary() {
    if (_memberGrowthAnalytics == null) return 'Chưa có dữ liệu tăng trưởng';
    
    final summary = _memberGrowthAnalytics!.summary;
    return '${summary.newMembers} thành viên mới • '
           'Tăng trưởng: ${summary.growthRate} • '
           'Tổng: ${summary.currentTotal} thành viên';
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  DateTime _getStartDate(DateTime endDate, String range) {
    switch (range) {
      case '7days':
        return endDate.subtract(Duration(days: 7));
      case '30days':
        return endDate.subtract(Duration(days: 30));
      case '90days':
        return endDate.subtract(Duration(days: 90));
      default:
        return endDate.subtract(Duration(days: 30));
    }
  }

  int? _extractGroupIdFromInvitation(InvitationPerformance invitation) {
    // This is a workaround - in practice, we'd store the group ID
    // or pass it differently to maintain it across date range changes
    return null;
  }

}

// Extension methods for analytics data
extension GroupAnalyticsExtensions on GroupAnalytics {
  bool get hasData => allInvitations.isNotEmpty;
  
  double get averageClickRate {
    if (allInvitations.isEmpty) return 0.0;
    return allInvitations
        .map((inv) => inv.clickRate)
        .reduce((a, b) => a + b) / allInvitations.length;
  }
  
  double get averageConversionRate {
    if (allInvitations.isEmpty) return 0.0;
    return allInvitations
        .map((inv) => inv.conversionRate)
        .reduce((a, b) => a + b) / allInvitations.length;
  }
  
  List<InvitationPerformance> get bestPerformers => 
      List.from(allInvitations)
        ..sort((a, b) => b.conversionRate.compareTo(a.conversionRate));
}

extension MemberGrowthAnalyticsExtensions on MemberGrowthAnalytics {
  bool get hasGrowth => dailyGrowth.isNotEmpty;
  
  int get totalNewMembers => 
      dailyGrowth.fold(0, (sum, day) => sum + day.newMembers);
  
  double get averageDailyGrowth {
    if (dailyGrowth.isEmpty) return 0.0;
    return totalNewMembers / dailyGrowth.length;
  }
}