<?php

namespace App\Services;

use App\Models\GroupInvitation;
use App\Models\InvitationAnalytics;
use App\Services\SmsService;
use Illuminate\Support\Facades\Log;

class SmsInvitationService
{
    protected SmsService $smsService;

    public function __construct(SmsService $smsService)
    {
        $this->smsService = $smsService;
    }

    /**
     * Send SMS invitation
     */
    public function sendInvitation(GroupInvitation $invitation): bool
    {
        try {
            if ($invitation->type !== 'sms' || !$invitation->recipient_phone) {
                throw new \InvalidArgumentException('Invalid invitation for SMS sending');
            }

            $group = $invitation->group;
            $creator = $invitation->creator;

            // Generate Vietnamese SMS message
            $message = $this->generateInvitationMessage($group, $creator, $invitation);

            // Send SMS
            $result = $this->smsService->sendSms(
                $invitation->recipient_phone,
                $message,
                'invitation'
            );

            // Track SMS sent event
            InvitationAnalytics::track($invitation->id, 'sent', [
                'source' => 'sms',
                'metadata' => [
                    'phone' => $invitation->recipient_phone,
                    'message_length' => strlen($message),
                    'sms_result' => $result,
                ],
            ]);

            if ($result) {
                Log::info('SMS invitation sent successfully', [
                    'invitation_id' => $invitation->id,
                    'phone' => $invitation->recipient_phone,
                    'group_id' => $group->id,
                ]);
            }

            return $result;

        } catch (\Exception $e) {
            Log::error('Failed to send SMS invitation', [
                'invitation_id' => $invitation->id,
                'phone' => $invitation->recipient_phone ?? 'unknown',
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);

            return false;
        }
    }

    /**
     * Generate Vietnamese invitation message
     */
    private function generateInvitationMessage($group, $creator, GroupInvitation $invitation): string
    {
        $invitationUrl = $invitation->getInvitationUrl();
        $groupName = $group->name;
        $sportName = $group->sport_name;
        $location = $group->location ? " tại {$group->location}" : "";
        $creatorName = $creator->display_name;

        // Check if invitation expires
        $expiryText = '';
        if ($invitation->expires_at) {
            $expiryDate = $invitation->expires_at->format('d/m/Y');
            $expiryText = " (hết hạn {$expiryDate})";
        }

        return "🏸 Mời tham gia nhóm {$sportName}!\n\n" .
               "'{$groupName}'{$location}\n" .
               "Người mời: {$creatorName}\n\n" .
               "Nhấn vào liên kết để tham gia{$expiryText}:\n" .
               "{$invitationUrl}\n\n" .
               "GoSport - Kết nối đam mê thể thao";
    }

    /**
     * Send bulk SMS invitations
     */
    public function sendBulkInvitations(array $invitations): array
    {
        $results = [];

        foreach ($invitations as $invitation) {
            if (!$invitation instanceof GroupInvitation) {
                $results[] = [
                    'invitation_id' => null,
                    'success' => false,
                    'error' => 'Invalid invitation object',
                ];
                continue;
            }

            $success = $this->sendInvitation($invitation);
            $results[] = [
                'invitation_id' => $invitation->id,
                'phone' => $invitation->recipient_phone,
                'success' => $success,
                'error' => $success ? null : 'Failed to send SMS',
            ];

            // Add small delay between SMS sends to avoid rate limiting
            usleep(100000); // 100ms delay
        }

        return $results;
    }

    /**
     * Get invitation message template variations
     */
    public function getMessageTemplates(): array
    {
        return [
            'default' => [
                'name' => 'Mặc định',
                'template' => "🏸 Mời tham gia nhóm {sport_name}!\n\n'{group_name}'{location}\nNgười mời: {creator_name}\n\nNhấn vào liên kết để tham gia{expiry}:\n{invitation_url}\n\nGoSport - Kết nối đam mê thể thao"
            ],
            'friendly' => [
                'name' => 'Thân thiện',
                'template' => "Chào bạn! 👋\n\n{creator_name} mời bạn tham gia nhóm {sport_name} '{group_name}'{location}.\n\nCùng chơi thể thao và kết bạn nhé!\n{invitation_url}{expiry}\n\nGoSport"
            ],
            'formal' => [
                'name' => 'Trang trọng',
                'template' => "Thư mời tham gia nhóm thể thao\n\nNhóm: {group_name}\nMôn: {sport_name}{location}\nNgười mời: {creator_name}\n\nVui lòng truy cập: {invitation_url}{expiry}\n\nTrân trọng,\nGoSport Team"
            ],
        ];
    }

    /**
     * Validate Vietnamese phone number for SMS
     */
    public function validatePhoneNumber(string $phone): bool
    {
        // Remove all non-numeric characters
        $cleanPhone = preg_replace('/[^0-9]/', '', $phone);
        
        // Check Vietnamese phone number patterns
        $patterns = [
            '/^84[35789]\d{8}$/',     // +84 format
            '/^0[35789]\d{8}$/',     // 0 prefix format
            '/^[35789]\d{8}$/',      // Without prefix
        ];

        foreach ($patterns as $pattern) {
            if (preg_match($pattern, $cleanPhone)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Normalize Vietnamese phone number for SMS sending
     */
    public function normalizePhoneNumber(string $phone): string
    {
        // Remove all non-numeric characters
        $cleanPhone = preg_replace('/[^0-9]/', '', $phone);
        
        // Convert to international format (+84)
        if (preg_match('/^0([35789]\d{8})$/', $cleanPhone, $matches)) {
            return '84' . $matches[1];
        } elseif (preg_match('/^([35789]\d{8})$/', $cleanPhone)) {
            return '84' . $cleanPhone;
        } elseif (preg_match('/^84([35789]\d{8})$/', $cleanPhone, $matches)) {
            return $cleanPhone;
        }

        // Return original if no pattern matches
        return $cleanPhone;
    }

    /**
     * Get SMS invitation delivery status
     */
    public function getDeliveryStatus(GroupInvitation $invitation): array
    {
        $analytics = $invitation->analytics()
            ->where('event', 'sent')
            ->where('source', 'sms')
            ->latest('occurred_at')
            ->first();

        if (!$analytics) {
            return [
                'status' => 'not_sent',
                'message' => 'Chưa gửi SMS',
            ];
        }

        $metadata = $analytics->metadata ?? [];
        $smsResult = $metadata['sms_result'] ?? false;

        return [
            'status' => $smsResult ? 'sent' : 'failed',
            'message' => $smsResult ? 'SMS đã gửi thành công' : 'Gửi SMS thất bại',
            'sent_at' => $analytics->occurred_at,
            'phone' => $invitation->recipient_phone,
            'metadata' => $metadata,
        ];
    }

    /**
     * Resend SMS invitation
     */
    public function resendInvitation(GroupInvitation $invitation): bool
    {
        if ($invitation->type !== 'sms') {
            return false;
        }

        if (!$invitation->isValid()) {
            return false;
        }

        return $this->sendInvitation($invitation);
    }

    /**
     * Get SMS invitation statistics
     */
    public function getInvitationStats(int $groupId): array
    {
        $invitations = GroupInvitation::where('group_id', $groupId)
            ->where('type', 'sms')
            ->with('analytics')
            ->get();

        $totalSent = 0;
        $totalClicked = 0;
        $totalUsed = 0;
        $failedSends = 0;

        foreach ($invitations as $invitation) {
            $sentEvents = $invitation->analytics->where('event', 'sent')->where('source', 'sms');
            $clickedEvents = $invitation->analytics->where('event', 'clicked');
            $usedEvents = $invitation->analytics->where('event', 'used');

            if ($sentEvents->count() > 0) {
                $lastSent = $sentEvents->sortByDesc('occurred_at')->first();
                $smsResult = $lastSent->metadata['sms_result'] ?? false;
                
                if ($smsResult) {
                    $totalSent++;
                } else {
                    $failedSends++;
                }
            }

            if ($clickedEvents->count() > 0) {
                $totalClicked++;
            }

            if ($usedEvents->count() > 0) {
                $totalUsed++;
            }
        }

        $clickRate = $totalSent > 0 ? round(($totalClicked / $totalSent) * 100, 1) : 0;
        $conversionRate = $totalClicked > 0 ? round(($totalUsed / $totalClicked) * 100, 1) : 0;

        return [
            'total_invitations' => $invitations->count(),
            'total_sent' => $totalSent,
            'failed_sends' => $failedSends,
            'total_clicked' => $totalClicked,
            'total_used' => $totalUsed,
            'click_rate' => $clickRate,
            'conversion_rate' => $conversionRate,
            'success_rate' => $totalSent > 0 ? round((($totalSent - $failedSends) / $totalSent) * 100, 1) : 0,
        ];
    }
}