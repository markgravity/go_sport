<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Group;
use App\Models\GroupInvitation;
use App\Models\InvitationAnalytics;
use App\Models\GroupJoinRequest;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class InvitationAnalyticsController extends Controller
{
    /**
     * Get analytics for a specific invitation
     */
    public function getInvitationAnalytics(Request $request, int $groupId, int $invitationId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        
        // Check permissions
        if (!$group->isAdmin(Auth::user()) && !$group->isModerator(Auth::user())) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền xem phân tích lời mời',
            ], 403);
        }

        $invitation = GroupInvitation::where('group_id', $groupId)
            ->where('id', $invitationId)
            ->firstOrFail();

        $summary = InvitationAnalytics::getSummary($invitationId);
        
        // Get recent events
        $recentEvents = InvitationAnalytics::where('invitation_id', $invitationId)
            ->orderBy('created_at', 'desc')
            ->take(20)
            ->get();

        // Get join requests from this invitation
        $joinRequests = GroupJoinRequest::where('invitation_id', $invitationId)
            ->with('user')
            ->get();

        return response()->json([
            'success' => true,
            'data' => [
                'invitation' => $invitation,
                'summary' => $summary,
                'recent_events' => $recentEvents,
                'join_requests' => $joinRequests,
                'performance' => [
                    'click_rate' => $summary['click_rate'] . '%',
                    'conversion_rate' => $summary['conversion_rate'] . '%',
                    'total_clicks' => $summary['clicked'],
                    'total_joins' => $summary['joined'],
                ],
            ],
        ]);
    }

    /**
     * Get overall group invitation analytics
     */
    public function getGroupAnalytics(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        
        // Check permissions
        if (!$group->isAdmin(Auth::user()) && !$group->isModerator(Auth::user())) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền xem phân tích nhóm',
            ], 403);
        }

        // Get date range from request (default last 30 days)
        $startDate = $request->input('start_date') 
            ? Carbon::parse($request->input('start_date')) 
            : Carbon::now()->subDays(30);
        $endDate = $request->input('end_date') 
            ? Carbon::parse($request->input('end_date')) 
            : Carbon::now();

        // Get all invitations for the group
        $invitations = GroupInvitation::where('group_id', $groupId)
            ->whereBetween('created_at', [$startDate, $endDate])
            ->get();

        // Aggregate analytics
        $totalSent = 0;
        $totalClicked = 0;
        $totalJoined = 0;
        $totalRejected = 0;
        
        $invitationPerformance = [];
        
        foreach ($invitations as $invitation) {
            $summary = InvitationAnalytics::getSummary($invitation->id);
            $totalSent += $summary['sent'];
            $totalClicked += $summary['clicked'];
            $totalJoined += $summary['joined'];
            $totalRejected += $summary['rejected'];
            
            $invitationPerformance[] = [
                'invitation_id' => $invitation->id,
                'created_by' => $invitation->creator->name ?? 'Unknown',
                'created_at' => $invitation->created_at,
                'status' => $invitation->status,
                'clicks' => $summary['clicked'],
                'joins' => $summary['joined'],
                'click_rate' => $summary['click_rate'],
                'conversion_rate' => $summary['conversion_rate'],
            ];
        }

        // Calculate overall rates
        $overallClickRate = $totalSent > 0 
            ? round(($totalClicked / $totalSent) * 100, 1) 
            : 0;
        $overallConversionRate = $totalClicked > 0 
            ? round(($totalJoined / $totalClicked) * 100, 1) 
            : 0;

        // Get join request stats
        $joinRequestStats = GroupJoinRequest::where('group_id', $groupId)
            ->whereBetween('created_at', [$startDate, $endDate])
            ->selectRaw('status, source, COUNT(*) as count')
            ->groupBy('status', 'source')
            ->get();

        // Get daily activity
        $dailyActivity = InvitationAnalytics::whereIn('invitation_id', $invitations->pluck('id'))
            ->whereBetween('created_at', [$startDate, $endDate])
            ->selectRaw('DATE(created_at) as date, event_type, COUNT(*) as count')
            ->groupBy('date', 'event_type')
            ->orderBy('date')
            ->get()
            ->groupBy('date');

        // Get top performers (invitations with highest conversion)
        $topPerformers = collect($invitationPerformance)
            ->sortByDesc('conversion_rate')
            ->take(5)
            ->values();

        return response()->json([
            'success' => true,
            'data' => [
                'period' => [
                    'start' => $startDate->format('Y-m-d'),
                    'end' => $endDate->format('Y-m-d'),
                ],
                'summary' => [
                    'total_invitations' => count($invitations),
                    'total_clicks' => $totalClicked,
                    'total_joins' => $totalJoined,
                    'total_rejected' => $totalRejected,
                    'click_rate' => $overallClickRate . '%',
                    'conversion_rate' => $overallConversionRate . '%',
                ],
                'join_request_stats' => $joinRequestStats,
                'daily_activity' => $dailyActivity,
                'top_performers' => $topPerformers,
                'all_invitations' => $invitationPerformance,
            ],
        ]);
    }

    /**
     * Get member growth analytics
     */
    public function getMemberGrowthAnalytics(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        
        // Check permissions
        if (!$group->isAdmin(Auth::user()) && !$group->isModerator(Auth::user())) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền xem phân tích tăng trưởng',
            ], 403);
        }

        // Get date range
        $startDate = $request->input('start_date') 
            ? Carbon::parse($request->input('start_date')) 
            : Carbon::now()->subDays(30);
        $endDate = $request->input('end_date') 
            ? Carbon::parse($request->input('end_date')) 
            : Carbon::now();

        // Get member joins over time
        $memberGrowth = DB::table('group_memberships')
            ->where('group_id', $groupId)
            ->whereBetween('joined_at', [$startDate, $endDate])
            ->selectRaw('DATE(joined_at) as date, COUNT(*) as new_members')
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        // Get member sources
        $memberSources = DB::table('group_memberships')
            ->where('group_id', $groupId)
            ->whereBetween('joined_at', [$startDate, $endDate])
            ->selectRaw('join_reason, COUNT(*) as count')
            ->groupBy('join_reason')
            ->get();

        // Get invitation effectiveness
        $invitationEffectiveness = DB::table('group_join_requests')
            ->where('group_id', $groupId)
            ->whereBetween('created_at', [$startDate, $endDate])
            ->selectRaw('source, status, COUNT(*) as count')
            ->groupBy('source', 'status')
            ->get()
            ->groupBy('source');

        // Calculate growth rate
        $previousPeriodStart = $startDate->copy()->subDays($startDate->diffInDays($endDate));
        $previousPeriodEnd = $startDate->copy()->subDay();
        
        $currentPeriodMembers = DB::table('group_memberships')
            ->where('group_id', $groupId)
            ->whereBetween('joined_at', [$startDate, $endDate])
            ->count();
            
        $previousPeriodMembers = DB::table('group_memberships')
            ->where('group_id', $groupId)
            ->whereBetween('joined_at', [$previousPeriodStart, $previousPeriodEnd])
            ->count();
            
        $growthRate = $previousPeriodMembers > 0 
            ? round((($currentPeriodMembers - $previousPeriodMembers) / $previousPeriodMembers) * 100, 1)
            : 100;

        return response()->json([
            'success' => true,
            'data' => [
                'period' => [
                    'start' => $startDate->format('Y-m-d'),
                    'end' => $endDate->format('Y-m-d'),
                ],
                'summary' => [
                    'new_members' => $currentPeriodMembers,
                    'growth_rate' => $growthRate . '%',
                    'current_total' => $group->current_members,
                    'capacity_usage' => round(($group->current_members / $group->max_members) * 100, 1) . '%',
                ],
                'daily_growth' => $memberGrowth,
                'member_sources' => $memberSources,
                'invitation_effectiveness' => $invitationEffectiveness,
            ],
        ]);
    }

    /**
     * Track an analytics event
     */
    public function trackEvent(Request $request): JsonResponse
    {
        $validatedData = $request->validate([
            'invitation_token' => ['required', 'string'],
            'event_type' => ['required', 'string', 'in:clicked,shared,copied'],
            'metadata' => ['nullable', 'array'],
        ]);

        $invitation = GroupInvitation::where('token', $validatedData['invitation_token'])->first();
        
        if (!$invitation) {
            return response()->json([
                'success' => false,
                'message' => 'Lời mời không tồn tại',
            ], 404);
        }

        InvitationAnalytics::track($invitation->id, $validatedData['event_type'], [
            'user_agent' => $request->userAgent(),
            'ip_address' => $request->ip(),
            'referrer' => $request->headers->get('referer'),
            'metadata' => $validatedData['metadata'] ?? null,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Sự kiện đã được ghi nhận',
        ]);
    }
}