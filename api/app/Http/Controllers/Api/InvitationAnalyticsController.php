<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Group;
use App\Models\GroupInvitation;
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
        try {
            $group = Group::findOrFail($groupId);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Nhóm không tồn tại',
            ], 404);
        }
        
        // Check permissions - creator, admin, or moderator can access analytics
        if (!$group->canManage(Auth::user())) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền xem thống kê nhóm này',
            ], 403);
        }

        try {
            $invitation = GroupInvitation::where('group_id', $groupId)
                ->where('id', $invitationId)
                ->firstOrFail();
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Lời mời không tồn tại hoặc không thuộc nhóm này',
            ], 404);
        }

        // Calculate summary from invitation metadata
        $metadata = $invitation->metadata ?? [];
        $totalClicks = $metadata['click_count'] ?? 0;
        $isUsed = $invitation->status === 'used';
        
        $summary = [
            'total_clicks' => $totalClicks,
            'conversion_rate' => $totalClicks > 0 && $isUsed ? 100.0 : 0.0,
            'time_to_use' => $isUsed && $invitation->used_at ? 
                $invitation->created_at->diffInHours($invitation->used_at) . ' giờ' : null,
            'click_timeline' => []
        ];
        
        // Create simple events
        $recentEvents = [
            [
                'event_name' => 'Lời mời được tạo',
                'created_at' => $invitation->created_at->toISOString()
            ]
        ];
        
        if ($invitation->used_at) {
            $recentEvents[] = [
                'event_name' => 'Lời mời được sử dụng',
                'created_at' => $invitation->used_at->toISOString()
            ];
        }

        return response()->json([
            'success' => true,
            'data' => [
                'invitation' => [
                    'id' => $invitation->id,
                    'type' => $invitation->type,
                    'status' => $invitation->status,
                    'created_at' => $invitation->created_at->toISOString(),
                    'used_at' => $invitation->used_at ? $invitation->used_at->toISOString() : null
                ],
                'performance' => [
                    'total_clicks' => $summary['total_clicks'],
                    'conversion_rate' => $summary['conversion_rate'],
                    'time_to_use' => $summary['time_to_use'],
                    'click_timeline' => $summary['click_timeline']
                ],
                'timeline' => $recentEvents
            ],
        ]);
    }

    /**
     * Get overall group invitation analytics
     */
    public function getGroupAnalytics(Request $request, int $groupId): JsonResponse
    {
        try {
            $group = Group::findOrFail($groupId);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Nhóm không tồn tại',
            ], 404);
        }
        
        // Check permissions - creator, admin, or moderator can access analytics
        if (!$group->canManage(Auth::user())) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền xem thống kê nhóm này',
            ], 403);
        }

        // Get all invitations for the group
        $invitations = GroupInvitation::where('group_id', $groupId)
            ->with('creator')
            ->get();

        // Calculate simple analytics from invitation data
        $analytics = [
            'total_invitations' => $invitations->count(),
            'pending_invitations' => $invitations->where('status', 'pending')->count(),
            'used_invitations' => $invitations->where('status', 'used')->count(), 
            'expired_invitations' => $invitations->where('status', 'expired')->count(),
            'revoked_invitations' => $invitations->where('status', 'revoked')->count(),
        ];

        // Calculate click rates from metadata
        $totalClicks = 0;
        $totalInvitations = $invitations->count();
        
        foreach ($invitations as $invitation) {
            $metadata = $invitation->metadata ?? [];
            $clicks = $metadata['click_count'] ?? 0;
            $totalClicks += $clicks;
        }
        
        $analytics['overall_click_rate'] = $totalInvitations > 0 ? round($totalClicks / $totalInvitations, 2) : 0.0;
        $analytics['overall_conversion_rate'] = $totalInvitations > 0 ? round(($analytics['used_invitations'] / $totalInvitations) * 100, 2) : 0.0;

        // Create events timeline
        $events = [];
        foreach ($invitations as $invitation) {
            $events[] = [
                'event_name' => 'Lời mời được tạo (' . $invitation->typeName . ')',
                'created_at' => $invitation->created_at->toISOString(),
                'creator' => $invitation->creator->name ?? 'N/A'
            ];
            
            if ($invitation->used_at) {
                $events[] = [
                    'event_name' => 'Lời mời được sử dụng',
                    'created_at' => $invitation->used_at->toISOString(),
                    'creator' => $invitation->creator->name ?? 'N/A'
                ];
            }
            
            if ($invitation->status == 'expired') {
                $events[] = [
                    'event_name' => 'Lời mời hết hạn',
                    'created_at' => $invitation->updated_at->toISOString(),
                    'creator' => $invitation->creator->name ?? 'N/A'
                ];
            }
            
            if ($invitation->status == 'revoked') {
                $events[] = [
                    'event_name' => 'Lời mời bị thu hồi',
                    'created_at' => $invitation->updated_at->toISOString(),
                    'creator' => $invitation->creator->name ?? 'N/A'
                ];
            }
        }

        // Sort events by date
        usort($events, function($a, $b) {
            return strtotime($b['created_at']) - strtotime($a['created_at']);
        });

        // Calculate rates by type
        $linkInvitations = $invitations->where('type', 'link');
        $smsInvitations = $invitations->where('type', 'sms');
        
        $rates = [
            'click_rate_by_type' => [
                'link' => $linkInvitations->count() > 0 ? 
                    round($linkInvitations->sum(function($inv) { return $inv->metadata['click_count'] ?? 0; }) / $linkInvitations->count(), 2) : 0,
                'sms' => $smsInvitations->count() > 0 ? 
                    round($smsInvitations->sum(function($inv) { return $inv->metadata['click_count'] ?? 0; }) / $smsInvitations->count(), 2) : 0,
            ],
            'conversion_rate_by_type' => [
                'link' => $linkInvitations->count() > 0 ? 
                    round(($linkInvitations->where('status', 'used')->count() / $linkInvitations->count()) * 100, 2) : 0,
                'sms' => $smsInvitations->count() > 0 ? 
                    round(($smsInvitations->where('status', 'used')->count() / $smsInvitations->count()) * 100, 2) : 0,
            ]
        ];

        // Simple sources data
        $sources = [
            'link' => $linkInvitations->count(),
            'sms' => $smsInvitations->count()
        ];

        // Daily stats (simple grouping by date)
        $dailyStats = [];
        $grouped = $invitations->groupBy(function($invitation) {
            return $invitation->created_at->format('Y-m-d');
        });
        
        foreach ($grouped as $date => $dayInvitations) {
            $dailyStats[] = [
                'date' => $date,
                'invitations_created' => $dayInvitations->count(),
                'invitations_used' => $dayInvitations->where('status', 'used')->count(),
                'total_clicks' => $dayInvitations->sum(function($inv) { return $inv->metadata['click_count'] ?? 0; })
            ];
        }

        return response()->json([
            'success' => true,
            'data' => [
                'overview' => $analytics,
                'events' => array_slice($events, 0, 20), // Latest 20 events
                'rates' => $rates,
                'sources' => $sources,
                'daily_stats' => $dailyStats
            ],
        ]);
    }

    /**
     * Get member growth analytics
     */
    public function getMemberGrowthAnalytics(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        
        // Check permissions - creator, admin, or moderator can access analytics
        if (!$group->canManage(Auth::user())) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền xem phân tích tăng trưởng',
            ], 403);
        }

        // Validate input parameters
        $validated = $request->validate([
            'period' => 'sometimes|integer|min:1|max:365',
            'type' => 'sometimes|in:members,invitations'
        ]);

        $period = $validated['period'] ?? 30;
        $type = $validated['type'] ?? 'members';

        // Simple growth analytics using invitations
        $invitations = GroupInvitation::where('group_id', $groupId)
            ->whereBetween('created_at', [Carbon::now()->subDays($period), Carbon::now()])
            ->get();

        $groupedByDate = $invitations->groupBy(function($invitation) {
            return $invitation->created_at->format('Y-m-d');
        });

        $growthData = [];
        for ($i = $period - 1; $i >= 0; $i--) {
            $date = Carbon::now()->subDays($i)->format('Y-m-d');
            $dayInvitations = $groupedByDate->get($date, collect());
            
            $growthData[] = [
                'date' => $date,
                'new_invitations' => $dayInvitations->count(),
                'used_invitations' => $dayInvitations->where('status', 'used')->count()
            ];
        }

        $totalGrowth = $invitations->count();
        $averageDailyGrowth = $period > 0 ? round($totalGrowth / $period, 2) : 0;
        $peakGrowthDay = collect($growthData)->sortByDesc('new_invitations')->first();

        return response()->json([
            'success' => true,
            'data' => [
                'period' => $period,
                'total_members' => $group->current_members,
                'growth_data' => $growthData,
                'summary' => [
                    'total_growth' => $totalGrowth,
                    'average_daily_growth' => $averageDailyGrowth,
                    'peak_growth_day' => $peakGrowthDay ? $peakGrowthDay['date'] : null
                ]
            ]
        ]);
    }

    /**
     * Get invitation type comparison analytics
     */
    public function getInvitationComparison(Request $request, int $groupId): JsonResponse
    {
        $group = Group::findOrFail($groupId);
        
        // Check permissions - creator, admin, or moderator can access analytics
        if (!$group->canManage(Auth::user())) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn không có quyền xem phân tích so sánh',
            ], 403);
        }

        $invitations = GroupInvitation::where('group_id', $groupId)->get();
        
        $linkInvitations = $invitations->where('type', 'link');
        $smsInvitations = $invitations->where('type', 'sms');

        // Calculate metrics for link invitations
        $linkMetrics = [
            'count' => $linkInvitations->count(),
            'click_rate' => $linkInvitations->count() > 0 ? 
                round($linkInvitations->sum(function($inv) { return $inv->metadata['click_count'] ?? 0; }) / $linkInvitations->count(), 2) : 0,
            'conversion_rate' => $linkInvitations->count() > 0 ? 
                round(($linkInvitations->where('status', 'used')->count() / $linkInvitations->count()) * 100, 2) : 0,
            'avg_time_to_use' => $linkInvitations->where('status', 'used')->count() > 0 ? 
                round($linkInvitations->where('status', 'used')->avg(function($inv) {
                    return $inv->used_at ? $inv->created_at->diffInHours($inv->used_at) : 0;
                }), 1) . ' giờ' : 'N/A'
        ];

        // Calculate metrics for SMS invitations  
        $smsMetrics = [
            'count' => $smsInvitations->count(),
            'click_rate' => $smsInvitations->count() > 0 ?
                round($smsInvitations->sum(function($inv) { return $inv->metadata['click_count'] ?? 0; }) / $smsInvitations->count(), 2) : 0,
            'conversion_rate' => $smsInvitations->count() > 0 ?
                round(($smsInvitations->where('status', 'used')->count() / $smsInvitations->count()) * 100, 2) : 0,
            'avg_time_to_use' => $smsInvitations->where('status', 'used')->count() > 0 ?
                round($smsInvitations->where('status', 'used')->avg(function($inv) {
                    return $inv->used_at ? $inv->created_at->diffInHours($inv->used_at) : 0;
                }), 1) . ' giờ' : 'N/A'
        ];

        // Generate recommendation
        $recommendation = '';
        if ($smsMetrics['conversion_rate'] > $linkMetrics['conversion_rate']) {
            $recommendation = 'SMS có tỷ lệ chuyển đổi tốt hơn. Nên ưu tiên sử dụng SMS để mời thành viên mới.';
        } else if ($linkMetrics['conversion_rate'] > $smsMetrics['conversion_rate']) {
            $recommendation = 'Lời mời qua link có tỷ lệ chuyển đổi tốt hơn. Nên ưu tiên sử dụng link để mời thành viên.';
        } else {
            $recommendation = 'Cả hai loại lời mời đều có hiệu quả tương tự. Có thể sử dụng cả hai tùy theo tình huống.';
        }

        return response()->json([
            'success' => true,
            'data' => [
                'link' => $linkMetrics,
                'sms' => $smsMetrics,
                'recommendation' => $recommendation
            ]
        ]);
    }
}