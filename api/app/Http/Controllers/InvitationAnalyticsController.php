<?php

namespace App\Http\Controllers;

use App\Models\Group;
use App\Models\GroupInvitation;
use App\Models\InvitationAnalytics;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class InvitationAnalyticsController extends Controller
{
    /**
     * Get analytics dashboard for a group
     * GET /api/groups/{group}/analytics
     */
    public function getGroupAnalytics(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);

        // Check permissions
        if (!$this->canViewAnalytics(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền xem thống kê',
                'error' => 'forbidden'
            ], 403);
        }

        // Get date range from request
        $startDate = $request->get('start_date', now()->subDays(30)->toDateString());
        $endDate = $request->get('end_date', now()->toDateString());

        try {
            $analytics = $this->calculateGroupAnalytics($groupId, $startDate, $endDate);
            
            return response()->json([
                'group' => [
                    'id' => $group->id,
                    'name' => $group->name,
                ],
                'period' => [
                    'start_date' => $startDate,
                    'end_date' => $endDate,
                ],
                'analytics' => $analytics,
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Không thể tải thống kê',
                'error' => 'server_error'
            ], 500);
        }
    }

    /**
     * Get member growth analytics for a group
     * GET /api/groups/{group}/analytics/growth
     */
    public function getMemberGrowthAnalytics(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);

        if (!$this->canViewAnalytics(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền xem thống kê',
                'error' => 'forbidden'
            ], 403);
        }

        $period = $request->get('period', '30d'); // 7d, 30d, 90d, 1y
        $startDate = $this->getStartDateForPeriod($period);

        try {
            $growth = $this->calculateMemberGrowth($groupId, $startDate, $period);

            return response()->json([
                'group' => [
                    'id' => $group->id,
                    'name' => $group->name,
                ],
                'period' => $period,
                'growth' => $growth,
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Không thể tải thống kê tăng trưởng',
                'error' => 'server_error'
            ], 500);
        }
    }

    /**
     * Get analytics for a specific invitation
     * GET /api/groups/{group}/invitations/{invitation}/analytics
     */
    public function getInvitationAnalytics(Request $request, int $groupId, int $invitationId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        $invitation = GroupInvitation::where('group_id', $groupId)
            ->where('id', $invitationId)
            ->firstOrFail();

        if (!$this->canViewAnalytics(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền xem thống kê',
                'error' => 'forbidden'
            ], 403);
        }

        try {
            $analytics = $this->calculateInvitationAnalytics($invitation);

            return response()->json([
                'invitation' => [
                    'id' => $invitation->id,
                    'token' => $invitation->token,
                    'type' => $invitation->type,
                    'type_name' => $invitation->type_name,
                    'status' => $invitation->status,
                    'status_name' => $invitation->status_name,
                    'created_at' => $invitation->created_at,
                    'expires_at' => $invitation->expires_at,
                ],
                'analytics' => $analytics,
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Không thể tải thống kê lời mời',
                'error' => 'server_error'
            ], 500);
        }
    }

    /**
     * Get invitation success rate comparison
     * GET /api/groups/{group}/analytics/comparison
     */
    public function getInvitationComparison(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);

        if (!$this->canViewAnalytics(Auth::user(), $group)) {
            return response()->json([
                'message' => 'Bạn không có quyền xem thống kê',
                'error' => 'forbidden'
            ], 403);
        }

        try {
            $comparison = $this->calculateInvitationComparison($groupId);

            return response()->json([
                'group' => [
                    'id' => $group->id,
                    'name' => $group->name,
                ],
                'comparison' => $comparison,
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Không thể tải so sánh thống kê',
                'error' => 'server_error'
            ], 500);
        }
    }

    /**
     * Calculate comprehensive group analytics
     */
    private function calculateGroupAnalytics(int $groupId, string $startDate, string $endDate): array
    {
        $invitations = GroupInvitation::where('group_id', $groupId)
            ->whereBetween('created_at', [$startDate, $endDate])
            ->with('analytics')
            ->get();

        $totalInvitations = $invitations->count();
        $linkInvitations = $invitations->where('type', 'link')->count();
        $smsInvitations = $invitations->where('type', 'sms')->count();
        
        $pendingInvitations = $invitations->where('status', 'pending')->count();
        $usedInvitations = $invitations->where('status', 'used')->count();
        $expiredInvitations = $invitations->where('status', 'expired')->count();
        $revokedInvitations = $invitations->where('status', 'revoked')->count();

        // Analytics events
        $allAnalytics = $invitations->flatMap->analytics;
        $createdEvents = $allAnalytics->where('event', 'created')->count();
        $sentEvents = $allAnalytics->where('event', 'sent')->count();
        $clickedEvents = $allAnalytics->where('event', 'clicked')->count();
        $usedEvents = $allAnalytics->where('event', 'used')->count();

        // Success rates
        $clickRate = $sentEvents > 0 ? round(($clickedEvents / $sentEvents) * 100, 1) : 0;
        $conversionRate = $clickedEvents > 0 ? round(($usedEvents / $clickedEvents) * 100, 1) : 0;
        $overallSuccessRate = $totalInvitations > 0 ? round(($usedInvitations / $totalInvitations) * 100, 1) : 0;

        // Source breakdown
        $sourceStats = $allAnalytics->groupBy('source')->map(function ($events, $source) {
            return [
                'name' => $source ?: 'unknown',
                'count' => $events->count(),
                'events' => $events->groupBy('event')->map->count()->toArray(),
            ];
        })->values()->toArray();

        // Daily breakdown
        $dailyStats = $this->getDailyBreakdown($groupId, $startDate, $endDate);

        return [
            'overview' => [
                'total_invitations' => $totalInvitations,
                'link_invitations' => $linkInvitations,
                'sms_invitations' => $smsInvitations,
                'pending_invitations' => $pendingInvitations,
                'used_invitations' => $usedInvitations,
                'expired_invitations' => $expiredInvitations,
                'revoked_invitations' => $revokedInvitations,
            ],
            'events' => [
                'created' => $createdEvents,
                'sent' => $sentEvents,
                'clicked' => $clickedEvents,
                'used' => $usedEvents,
            ],
            'rates' => [
                'click_rate' => $clickRate,
                'conversion_rate' => $conversionRate,
                'overall_success_rate' => $overallSuccessRate,
            ],
            'sources' => $sourceStats,
            'daily_stats' => $dailyStats,
        ];
    }

    /**
     * Calculate member growth over time
     */
    private function calculateMemberGrowth(int $groupId, Carbon $startDate, string $period): array
    {
        $interval = match ($period) {
            '7d' => '1 day',
            '30d' => '1 day',
            '90d' => '1 week',
            '1y' => '1 month',
            default => '1 day',
        };

        // Get invitation usage data
        $usedInvitations = DB::table('group_invitations')
            ->join('invitation_analytics', 'group_invitations.id', '=', 'invitation_analytics.invitation_id')
            ->where('group_invitations.group_id', $groupId)
            ->where('invitation_analytics.event', 'used')
            ->where('invitation_analytics.occurred_at', '>=', $startDate)
            ->select('invitation_analytics.occurred_at')
            ->orderBy('invitation_analytics.occurred_at')
            ->get();

        // Group by time period
        $growth = [];
        $currentDate = $startDate->copy();
        $endDate = now();

        while ($currentDate <= $endDate) {
            $nextDate = $currentDate->copy()->add($this->getIntervalForPeriod($period));
            
            $newMembers = $usedInvitations->filter(function ($invitation) use ($currentDate, $nextDate) {
                $occurredAt = Carbon::parse($invitation->occurred_at);
                return $occurredAt >= $currentDate && $occurredAt < $nextDate;
            })->count();

            $growth[] = [
                'period' => $currentDate->format($this->getDateFormat($period)),
                'date' => $currentDate->toDateString(),
                'new_members' => $newMembers,
            ];

            $currentDate = $nextDate;
        }

        return $growth;
    }

    /**
     * Calculate analytics for a specific invitation
     */
    private function calculateInvitationAnalytics(GroupInvitation $invitation): array
    {
        $analytics = $invitation->analytics()
            ->select('event', 'source', 'occurred_at', 'metadata')
            ->orderBy('occurred_at')
            ->get();

        $eventCounts = $analytics->groupBy('event')->map->count()->toArray();
        $sourceCounts = $analytics->groupBy('source')->map->count()->toArray();

        // Timeline of events
        $timeline = $analytics->map(function ($event) {
            return [
                'event' => $event->event,
                'event_name' => $this->getEventName($event->event),
                'source' => $event->source,
                'source_name' => $this->getSourceName($event->source),
                'occurred_at' => $event->occurred_at,
                'metadata' => $event->metadata,
            ];
        })->values()->toArray();

        // Performance metrics
        $created = $eventCounts['created'] ?? 0;
        $sent = $eventCounts['sent'] ?? 0;
        $clicked = $eventCounts['clicked'] ?? 0;
        $used = $eventCounts['used'] ?? 0;

        $clickRate = $sent > 0 ? round(($clicked / $sent) * 100, 1) : 0;
        $conversionRate = $clicked > 0 ? round(($used / $clicked) * 100, 1) : 0;

        return [
            'events' => $eventCounts,
            'sources' => $sourceCounts,
            'performance' => [
                'click_rate' => $clickRate,
                'conversion_rate' => $conversionRate,
                'total_clicks' => $clicked,
                'successful_joins' => $used,
            ],
            'timeline' => $timeline,
        ];
    }

    /**
     * Get daily breakdown of invitation activity
     */
    private function getDailyBreakdown(int $groupId, string $startDate, string $endDate): array
    {
        $dailyStats = DB::table('invitation_analytics')
            ->join('group_invitations', 'invitation_analytics.invitation_id', '=', 'group_invitations.id')
            ->where('group_invitations.group_id', $groupId)
            ->whereBetween('invitation_analytics.occurred_at', [$startDate, $endDate])
            ->select(
                DB::raw('DATE(invitation_analytics.occurred_at) as date'),
                'invitation_analytics.event',
                DB::raw('COUNT(*) as count')
            )
            ->groupBy('date', 'event')
            ->orderBy('date')
            ->get();

        $dailyBreakdown = [];
        $currentDate = Carbon::parse($startDate);
        $endDateCarbon = Carbon::parse($endDate);

        while ($currentDate <= $endDateCarbon) {
            $dateStr = $currentDate->toDateString();
            $dayStats = $dailyStats->where('date', $dateStr);

            $dailyBreakdown[] = [
                'date' => $dateStr,
                'date_formatted' => $currentDate->format('d/m'),
                'events' => [
                    'created' => $dayStats->where('event', 'created')->sum('count'),
                    'sent' => $dayStats->where('event', 'sent')->sum('count'),
                    'clicked' => $dayStats->where('event', 'clicked')->sum('count'),
                    'used' => $dayStats->where('event', 'used')->sum('count'),
                ],
            ];

            $currentDate->addDay();
        }

        return $dailyBreakdown;
    }

    /**
     * Calculate invitation comparison by type
     */
    private function calculateInvitationComparison(int $groupId): array
    {
        $invitations = GroupInvitation::where('group_id', $groupId)
            ->with('analytics')
            ->get();

        $linkInvitations = $invitations->where('type', 'link');
        $smsInvitations = $invitations->where('type', 'sms');

        $linkStats = $this->getInvitationTypeStats($linkInvitations);
        $smsStats = $this->getInvitationTypeStats($smsInvitations);

        return [
            'link' => $linkStats,
            'sms' => $smsStats,
            'comparison' => [
                'better_click_rate' => $linkStats['click_rate'] > $smsStats['click_rate'] ? 'link' : 'sms',
                'better_conversion_rate' => $linkStats['conversion_rate'] > $smsStats['conversion_rate'] ? 'link' : 'sms',
                'more_successful' => $linkStats['used_count'] > $smsStats['used_count'] ? 'link' : 'sms',
            ],
        ];
    }

    /**
     * Get statistics for invitation type
     */
    private function getInvitationTypeStats($invitations): array
    {
        $total = $invitations->count();
        $used = $invitations->where('status', 'used')->count();
        
        $allAnalytics = $invitations->flatMap->analytics;
        $clicked = $allAnalytics->where('event', 'clicked')->count();
        $sent = $allAnalytics->where('event', 'sent')->count();

        $clickRate = $sent > 0 ? round(($clicked / $sent) * 100, 1) : 0;
        $conversionRate = $clicked > 0 ? round(($used / $clicked) * 100, 1) : 0;
        $successRate = $total > 0 ? round(($used / $total) * 100, 1) : 0;

        return [
            'total_count' => $total,
            'used_count' => $used,
            'clicked_count' => $clicked,
            'sent_count' => $sent,
            'click_rate' => $clickRate,
            'conversion_rate' => $conversionRate,
            'success_rate' => $successRate,
        ];
    }

    /**
     * Check if user can view analytics
     */
    private function canViewAnalytics($user, Group $group): bool
    {
        $membership = $group->memberships()
            ->where('user_id', $user->id)
            ->first();

        return $membership && in_array($membership->role, ['creator', 'admin', 'moderator']);
    }

    /**
     * Get start date for analytics period
     */
    private function getStartDateForPeriod(string $period): Carbon
    {
        return match ($period) {
            '7d' => now()->subDays(7),
            '30d' => now()->subDays(30),
            '90d' => now()->subDays(90),
            '1y' => now()->subYear(),
            default => now()->subDays(30),
        };
    }

    /**
     * Get interval for period grouping
     */
    private function getIntervalForPeriod(string $period): string
    {
        return match ($period) {
            '7d' => '1 day',
            '30d' => '1 day', 
            '90d' => '1 week',
            '1y' => '1 month',
            default => '1 day',
        };
    }

    /**
     * Get date format for period
     */
    private function getDateFormat(string $period): string
    {
        return match ($period) {
            '7d' => 'd/m',
            '30d' => 'd/m',
            '90d' => 'W/Y',
            '1y' => 'm/Y',
            default => 'd/m',
        };
    }

    /**
     * Get Vietnamese event names
     */
    private function getEventName(string $event): string
    {
        return match ($event) {
            'created' => 'Đã tạo',
            'sent' => 'Đã gửi',
            'clicked' => 'Đã nhấn',
            'used' => 'Đã sử dụng',
            'expired' => 'Hết hạn',
            'revoked' => 'Đã thu hồi',
            default => $event,
        };
    }

    /**
     * Get Vietnamese source names
     */
    private function getSourceName(?string $source): string
    {
        return match ($source) {
            'app' => 'Ứng dụng',
            'web' => 'Trang web',
            'sms' => 'Tin nhắn',
            'share' => 'Chia sẻ',
            'api' => 'API',
            default => $source ?? 'Không rõ',
        };
    }
}