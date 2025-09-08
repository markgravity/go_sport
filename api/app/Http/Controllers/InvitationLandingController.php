<?php

namespace App\Http\Controllers;

use App\Models\GroupInvitation;
use App\Models\GroupJoinRequest;
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

            $validatedData = $request->validate([
                'message' => ['nullable', 'string', 'max:500'],
            ]);

            // Store join request information in session for the mobile app
            session([
                'join_request_data' => [
                    'group_id' => $invitation->group_id,
                    'invitation_id' => $invitation->id,
                    'message' => $validatedData['message'] ?? null,
                    'source' => 'invitation',
                ]
            ]);

            // Track join attempt analytics
            InvitationAnalytics::track($invitation->id, 'join_attempted', [
                'user_agent' => $request->userAgent(),
                'ip_address' => $request->ip(),
                'has_message' => !empty($validatedData['message']),
            ]);

            // Show success message and redirect to app
            return view('invitation.join-success', [
                'invitation' => $invitation,
                'group' => $invitation->group,
                'appDownloadUrl' => 'https://play.google.com/store/apps', // Will be replaced with actual app store links
                'joinRequestData' => session('join_request_data'),
            ]);
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Có lỗi xảy ra khi xử lý yêu cầu tham gia nhóm');
        }
    }
}
