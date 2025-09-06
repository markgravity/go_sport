<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class PhoneVerification extends Model
{
    protected $fillable = [
        'phone',
        'code',
        'type',
        'expires_at',
        'verified_at',
        'ip_address',
        'attempts'
    ];

    protected $casts = [
        'expires_at' => 'datetime',
        'verified_at' => 'datetime',
    ];

    /**
     * Generate a 6-digit verification code
     */
    public static function generateCode(): string
    {
        return str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT);
    }

    /**
     * Create a new phone verification record
     */
    public static function createForPhone(string $phone, ?string $ipAddress = null): self
    {
        // Clean up old verification records for this phone and type
        self::where('phone', $phone)
            ->where('type', 'registration')
            ->delete();

        return self::create([
            'phone' => $phone,
            'code' => self::generateCode(),
            'type' => 'registration',
            'expires_at' => Carbon::now()->addMinutes(5), // 5-minute expiration
            'ip_address' => $ipAddress,
        ]);
    }

    /**
     * Create a new password reset verification record
     */
    public static function createForPasswordReset(string $phone, ?string $ipAddress = null): self
    {
        // Clean up old password reset records for this phone
        self::where('phone', $phone)
            ->where('type', 'password_reset')
            ->delete();

        return self::create([
            'phone' => $phone,
            'code' => self::generateCode(),
            'type' => 'password_reset',
            'expires_at' => Carbon::now()->addMinutes(15), // 15-minute expiration for password reset
            'ip_address' => $ipAddress,
        ]);
    }

    /**
     * Check if the verification code is valid
     */
    public function isValid(): bool
    {
        return $this->verified_at === null && 
               $this->expires_at->isFuture() && 
               $this->attempts < 3;
    }

    /**
     * Mark as verified
     */
    public function markAsVerified(): void
    {
        $this->update([
            'verified_at' => Carbon::now()
        ]);
    }

    /**
     * Increment attempts counter
     */
    public function incrementAttempts(): void
    {
        $this->increment('attempts');
    }

    /**
     * Get recent verification attempts for rate limiting
     */
    public static function getRecentAttemptsForPhone(string $phone, int $minutes = 15, ?string $type = null): int
    {
        $query = self::where('phone', $phone)
                     ->where('created_at', '>', Carbon::now()->subMinutes($minutes));
        
        if ($type) {
            $query->where('type', $type);
        }
        
        return $query->count();
    }
}
