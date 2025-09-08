<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\GroupInvitation;
use App\Models\InvitationAnalytics;
use Illuminate\Http\Request;
use Illuminate\View\View;

class InviteController extends Controller
{
    /**
     * Show the invitation preview page
     * GET /invite/{token}
     */
    public function show(Request $request, string $token): View
    {
        $invitation = GroupInvitation::with(['group.creator', 'group.memberships'])
            ->where('token', $token)
            ->first();

        if (!$invitation) {
            return view('invite.not-found', [
                'title' => 'Lời mời không tồn tại - GoSport',
                'token' => $token,
            ]);
        }

        // Track click event
        InvitationAnalytics::track($invitation->id, 'clicked', [
            'source' => 'web',
            'user_agent' => $request->header('User-Agent'),
            'ip_address' => $request->ip(),
        ]);

        // Check if invitation is valid
        if (!$invitation->isValid()) {
            $isExpired = $invitation->isExpired();
            return view('invite.invalid', [
                'title' => $isExpired ? 'Lời mời đã hết hạn - GoSport' : 'Lời mời không hợp lệ - GoSport',
                'invitation' => $invitation,
                'group' => $invitation->group,
                'is_expired' => $isExpired,
                'error_message' => $isExpired 
                    ? 'Lời mời này đã hết hạn' 
                    : 'Lời mời này không còn hợp lệ',
            ]);
        }

        $group = $invitation->group;
        $memberCount = $group->memberships()->count();
        
        return view('invite.preview', [
            'title' => "Mời tham gia {$group->name} - GoSport",
            'invitation' => $invitation,
            'group' => $group,
            'creator' => $invitation->creator,
            'member_count' => $memberCount,
            'meta' => [
                'description' => "Tham gia nhóm {$group->sport_name} '{$group->name}'" . 
                    ($group->location ? " tại {$group->location}" : '') . 
                    ". Hiện có {$memberCount} thành viên.",
                'og_title' => "Mời tham gia nhóm {$group->sport_name}",
                'og_description' => "'{$group->name}'" . ($group->location ? " - {$group->location}" : ''),
                'og_image' => $group->avatar_url ?? asset('images/default-group-avatar.png'),
            ]
        ]);
    }

    /**
     * Show the invitation success page (after joining)
     * GET /invite/{token}/success
     */
    public function success(Request $request, string $token): View
    {
        $invitation = GroupInvitation::with(['group', 'creator'])
            ->where('token', $token)
            ->first();

        if (!$invitation) {
            return redirect()->route('invite.show', ['token' => $token]);
        }

        return view('invite.success', [
            'title' => 'Tham gia thành công - GoSport',
            'invitation' => $invitation,
            'group' => $invitation->group,
            'creator' => $invitation->creator,
        ]);
    }

    /**
     * Show the registration prompt page
     * GET /invite/{token}/register
     */
    public function register(Request $request, string $token): View
    {
        $invitation = GroupInvitation::with(['group'])
            ->where('token', $token)
            ->first();

        if (!$invitation || !$invitation->isValid()) {
            return redirect()->route('invite.show', ['token' => $token]);
        }

        return view('invite.register', [
            'title' => 'Đăng ký để tham gia - GoSport',
            'invitation' => $invitation,
            'group' => $invitation->group,
            'token' => $token,
        ]);
    }

    /**
     * Handle the join request from the invitation page
     * POST /invite/{token}/join
     */
    public function join(Request $request, string $token)
    {
        $invitation = GroupInvitation::with(['group'])
            ->where('token', $token)
            ->first();

        if (!$invitation || !$invitation->isValid()) {
            return response()->json([
                'success' => false,
                'message' => 'Lời mời không hợp lệ hoặc đã hết hạn',
            ], 422);
        }

        // Check if user is authenticated
        if (!auth()->check()) {
            return response()->json([
                'success' => false,
                'message' => 'Vui lòng đăng nhập để tham gia nhóm',
                'redirect' => route('invite.register', ['token' => $token]),
            ], 401);
        }

        $user = auth()->user();
        $group = $invitation->group;

        // Check if user is already a member
        $existingMembership = $group->memberships()
            ->where('user_id', $user->id)
            ->first();

        if ($existingMembership) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn đã là thành viên của nhóm này',
            ], 422);
        }

        try {
            // Create group membership
            $group->memberships()->create([
                'user_id' => $user->id,
                'role' => 'member',
                'joined_at' => now(),
            ]);

            // Mark invitation as used
            $invitation->markAsUsed($user->id);

            // Track usage analytics
            InvitationAnalytics::track($invitation->id, 'used', [
                'source' => 'web',
                'user_agent' => $request->header('User-Agent'),
                'ip_address' => $request->ip(),
                'metadata' => [
                    'user_id' => $user->id,
                ],
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Tham gia nhóm thành công!',
                'redirect' => route('invite.success', ['token' => $token]),
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Có lỗi xảy ra khi tham gia nhóm. Vui lòng thử lại.',
            ], 500);
        }
    }

    /**
     * Get invitation data for JavaScript (API endpoint)
     * GET /invite/{token}/data
     */
    public function getData(string $token)
    {
        $invitation = GroupInvitation::with(['group.creator'])
            ->where('token', $token)
            ->first();

        if (!$invitation) {
            return response()->json([
                'error' => 'invitation_not_found',
                'message' => 'Lời mời không tồn tại'
            ], 404);
        }

        if (!$invitation->isValid()) {
            return response()->json([
                'error' => 'invitation_invalid',
                'message' => $invitation->isExpired() ? 'Lời mời đã hết hạn' : 'Lời mời không hợp lệ',
                'invitation' => [
                    'status' => $invitation->status,
                    'expires_at' => $invitation->expires_at,
                ]
            ], 422);
        }

        $group = $invitation->group;

        return response()->json([
            'invitation' => [
                'id' => $invitation->id,
                'token' => $invitation->token,
                'type' => $invitation->type,
                'expires_at' => $invitation->expires_at,
            ],
            'group' => [
                'id' => $group->id,
                'name' => $group->name,
                'sport_type' => $group->sport_type,
                'sport_name' => $group->sport_name,
                'location' => $group->location,
                'description' => $group->description,
                'avatar_url' => $group->avatar_url,
                'member_count' => $group->memberships()->count(),
                'created_at' => $group->created_at,
            ],
            'creator' => [
                'id' => $invitation->creator->id,
                'display_name' => $invitation->creator->display_name,
                'avatar_url' => $invitation->creator->avatar_url,
            ],
            'is_authenticated' => auth()->check(),
            'is_member' => auth()->check() ? $group->memberships()
                ->where('user_id', auth()->id())
                ->exists() : false,
        ]);
    }
}