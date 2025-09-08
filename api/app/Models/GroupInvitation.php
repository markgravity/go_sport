<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Str;
use Carbon\Carbon;

class GroupInvitation extends Model
{
    protected $fillable = [
        'group_id',
        'created_by',
        'token',
        'type',
        'status',
        'expires_at',
        'used_at',
        'used_by',
        'metadata',
    ];

    protected $casts = [
        'expires_at' => 'datetime',
        'used_at' => 'datetime',
        'metadata' => 'array',
    ];

    /**
     * Boot the model
     */
    protected static function boot()
    {
        parent::boot();
        
        static::creating(function ($invitation) {
            if (empty($invitation->token)) {
                $invitation->token = self::generateUniqueToken();
            }
        });
    }

    /**
     * Generate a unique invitation token
     */
    public static function generateUniqueToken(): string
    {
        do {
            $token = Str::random(32);
        } while (self::where('token', $token)->exists());
        
        return $token;
    }

    /**
     * Check if invitation is valid
     */
    public function isValid(): bool
    {
        return $this->status === 'pending' 
            && ($this->expires_at === null || $this->expires_at->isFuture());
    }

    /**
     * Check if invitation is expired
     */
    public function isExpired(): bool
    {
        return $this->expires_at !== null && $this->expires_at->isPast();
    }

    /**
     * Mark invitation as used
     */
    public function markAsUsed(int $userId): void
    {
        $this->update([
            'status' => 'used',
            'used_at' => now(),
            'used_by' => $userId,
        ]);
    }

    /**
     * Mark invitation as revoked
     */
    public function revoke(): void
    {
        $this->update(['status' => 'revoked']);
    }

    /**
     * Generate invitation URL
     */
    public function getInvitationUrl(): string
    {
        return url("/api/invitations/preview/{$this->token}");
    }

    /**
     * Get the group that owns the invitation
     */
    public function group(): BelongsTo
    {
        return $this->belongsTo(Group::class);
    }

    /**
     * Get the user who created the invitation
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    /**
     * Get the user who used the invitation
     */
    public function usedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'used_by');
    }

    /**
     * Get the analytics for this invitation
     */
    public function analytics(): HasMany
    {
        return $this->hasMany(InvitationAnalytics::class, 'invitation_id');
    }

    /**
     * Scope to get valid invitations
     */
    public function scopeValid($query)
    {
        return $query->where('status', 'pending')
                    ->where(function ($q) {
                        $q->whereNull('expires_at')
                          ->orWhere('expires_at', '>', now());
                    });
    }

    /**
     * Scope to get expired invitations
     */
    public function scopeExpired($query)
    {
        return $query->where('expires_at', '<=', now())
                    ->where('status', 'pending');
    }

    /**
     * Vietnamese status name
     */
    public function getStatusNameAttribute(): string
    {
        return match($this->status) {
            'pending' => 'Đang chờ',
            'used' => 'Đã sử dụng',
            'expired' => 'Hết hạn',
            'revoked' => 'Đã thu hồi',
            default => $this->status,
        };
    }

    /**
     * Vietnamese type name
     */
    public function getTypeNameAttribute(): string
    {
        return match($this->type) {
            'link' => 'Liên kết',
            default => $this->type,
        };
    }
}
