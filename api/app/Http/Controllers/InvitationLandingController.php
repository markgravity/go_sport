<?php

namespace App\Http\Controllers;

use App\Models\GroupInvitation;
use App\Models\InvitationAnalytics;
use Illuminate\Http\Request;
use Illuminate\View\View;

class InvitationLandingController extends Controller
{
    /**
     * Show invitation landing page
     */
    public function show(Request $request, string $token): View
    {
        try {
            // Find invitation by token
            $invitation = GroupInvitation::where('token', $token)
                ->with(['group.creator', 'creator'])
                ->first();

            // Track click analytics
            if ($invitation) {
                InvitationAnalytics::track($invitation->id, 'clicked', [
                    'user_agent' => $request->userAgent(),
                    'ip_address' => $request->ip(),
                    'referrer' => $request->headers->get('referer'),
                ]);
            }

            return view('invitation.landing', [
                'invitation' => $invitation,
                'group' => $invitation?->group,
                'creator' => $invitation?->creator,
                'isValid' => $invitation?->isValid() ?? false,
                'isExpired' => $invitation?->isExpired() ?? false,
                'token' => $token,
            ]);
        } catch (\Exception $e) {
            return view('invitation.error', [
                'error' => 'Có lỗi xảy ra khi tải trang mời',
                'token' => $token,
            ]);
        }
    }

    /**
     * Handle join request from landing page
     */
    public function join(Request $request, string $token)
    {
        try {
            $invitation = GroupInvitation::where('token', $token)
                ->with('group')
                ->first();

            if (!$invitation || !$invitation->isValid()) {
                return redirect()->back()->with('error', 'Lời mời không hợp lệ hoặc đã hết hạn');
            }

            // For now, redirect to app download or show success message
            // In a real implementation, this would integrate with user authentication
            return view('invitation.join-success', [
                'invitation' => $invitation,
                'group' => $invitation->group,
                'appDownloadUrl' => 'https://example.com/download-app',
            ]);
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Có lỗi xảy ra khi tham gia nhóm');
        }
    }
}
