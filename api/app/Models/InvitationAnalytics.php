<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class InvitationAnalytics extends Model
{
    protected $fillable = [
        'invitation_id',
        'event',
        'source',
        'user_agent',
        'ip_address',
        'metadata',
        'occurred_at',
    ];

    protected $casts = [
        'metadata' => 'array',
        'occurred_at' => 'datetime',
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
    public static function track(int $invitationId, string $event, array $data = []): self
    {
        return self::create([
            'invitation_id' => $invitationId,
            'event' => $event,
            'source' => $data['source'] ?? null,
            'user_agent' => $data['user_agent'] ?? null,
            'ip_address' => $data['ip_address'] ?? null,
            'metadata' => $data['metadata'] ?? null,
            'occurred_at' => $data['occurred_at'] ?? now(),
        ]);
    }

    /**
     * Get analytics summary for an invitation
     */
    public static function getSummary(int $invitationId): array
    {
        $events = self::where('invitation_id', $invitationId)
                     ->selectRaw('event, COUNT(*) as count')
                     ->groupBy('event')
                     ->pluck('count', 'event')
                     ->toArray();

        return [
            'created' => $events['created'] ?? 0,
            'sent' => $events['sent'] ?? 0,
            'clicked' => $events['clicked'] ?? 0,
            'used' => $events['used'] ?? 0,
            'expired' => $events['expired'] ?? 0,
            'revoked' => $events['revoked'] ?? 0,
            'click_rate' => $events['sent'] > 0 ? round(($events['clicked'] ?? 0) / $events['sent'] * 100, 1) : 0,
            'conversion_rate' => $events['clicked'] > 0 ? round(($events['used'] ?? 0) / $events['clicked'] * 100, 1) : 0,
        ];
    }

    /**
     * Vietnamese event names
     */
    public function getEventNameAttribute(): string
    {
        return match($this->event) {
            'created' => 'Đã tạo',
            'sent' => 'Đã gửi',
            'clicked' => 'Đã nhấn',
            'used' => 'Đã sử dụng',
            'expired' => 'Hết hạn',
            'revoked' => 'Đã thu hồi',
            default => $this->event,
        };
    }
}
