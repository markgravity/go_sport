<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class InvitationAnalytics extends Model
{
    protected $fillable = [
        'invitation_id',
        'event_type',
        'user_agent',
        'ip_address',
        'referrer',
        'metadata',
    ];

    protected $casts = [
        'metadata' => 'array',
    ];

    /**
     * Get the invitation that owns the analytics event
     */
    public function invitation(): BelongsTo
    {
        return $this->belongsTo(GroupInvitation::class, 'invitation_id');
    }

    /**
     * Create an analytics event
     */
    public static function track(int $invitationId, string $eventType, array $data = []): self
    {
        return self::create([
            'invitation_id' => $invitationId,
            'event_type' => $eventType,
            'user_agent' => $data['user_agent'] ?? null,
            'ip_address' => $data['ip_address'] ?? null,
            'referrer' => $data['referrer'] ?? null,
            'metadata' => $data['metadata'] ?? null,
        ]);
    }

    /**
     * Get analytics summary for an invitation
     */
    public static function getSummary(int $invitationId): array
    {
        $events = self::where('invitation_id', $invitationId)
                     ->selectRaw('event_type, COUNT(*) as count')
                     ->groupBy('event_type')
                     ->pluck('count', 'event_type')
                     ->toArray();

        return [
            'sent' => $events['sent'] ?? 0,
            'clicked' => $events['clicked'] ?? 0,
            'registered' => $events['registered'] ?? 0,
            'joined' => $events['joined'] ?? 0,
            'rejected' => $events['rejected'] ?? 0,
            'click_rate' => $events['sent'] > 0 ? round(($events['clicked'] ?? 0) / $events['sent'] * 100, 1) : 0,
            'conversion_rate' => $events['clicked'] > 0 ? round(($events['joined'] ?? 0) / $events['clicked'] * 100, 1) : 0,
        ];
    }

    /**
     * Vietnamese event type names
     */
    public function getEventTypeNameAttribute(): string
    {
        return match($this->event_type) {
            'sent' => 'Đã gửi',
            'clicked' => 'Đã nhấn',
            'registered' => 'Đã đăng ký',
            'joined' => 'Đã tham gia',
            'rejected' => 'Đã từ chối',
            default => $this->event_type,
        };
    }
}
