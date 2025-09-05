<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'email',
        'phone',
        'phone_hash',
        'phone_verified_at',
        'password',
        'firebase_uid',
        'date_of_birth',
        'gender',
        'address',
        'city',
        'province',
        'avatar',
        'status',
        'fcm_token',
        'preferences',
        'preferred_sports',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
        'phone_hash', // Hide phone_hash for security
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'phone_verified_at' => 'datetime',
            'password' => 'hashed',
            'date_of_birth' => 'date',
            'preferences' => 'array',
            'preferred_sports' => 'array',
        ];
    }

    /**
     * Format phone number to Vietnamese standard (+84)
     */
    public static function formatVietnamesePhone(string $phone): string
    {
        // Remove all non-numeric characters
        $phone = preg_replace('/[^0-9]/', '', $phone);
        
        // Convert 0x format to +84x format
        if (str_starts_with($phone, '0')) {
            $phone = '84' . substr($phone, 1);
        }
        
        // Add + prefix if not present
        if (!str_starts_with($phone, '+')) {
            $phone = '+' . $phone;
        }
        
        return $phone;
    }

    /**
     * Check if phone number is verified
     */
    public function isPhoneVerified(): bool
    {
        return !is_null($this->phone_verified_at);
    }

    /**
     * Mark phone as verified
     */
    public function markPhoneAsVerified(): void
    {
        $this->phone_verified_at = now();
        $this->save();
    }

    /**
     * Generate phone hash for secure indexing
     */
    public static function generatePhoneHash(string $phone): string
    {
        return hash('sha256', $phone . config('app.key'));
    }

    /**
     * Set phone attribute with encryption and hashing
     */
    public function setPhoneAttribute(string $value): void
    {
        $formattedPhone = self::formatVietnamesePhone($value);
        
        // Store encrypted phone number
        $this->attributes['phone'] = encrypt($formattedPhone);
        
        // Generate and store phone hash for indexing
        $this->attributes['phone_hash'] = self::generatePhoneHash($formattedPhone);
    }

    /**
     * Get phone attribute with decryption
     */
    public function getPhoneAttribute($value): ?string
    {
        if (empty($value)) {
            return null;
        }

        try {
            return decrypt($value);
        } catch (\Exception $e) {
            // If decryption fails, assume it's plain text (for backward compatibility)
            return $value;
        }
    }

    /**
     * Find user by phone number (using hash for performance)
     */
    public static function findByPhone(string $phone): ?User
    {
        $formattedPhone = self::formatVietnamesePhone($phone);
        $phoneHash = self::generatePhoneHash($formattedPhone);
        
        return self::where('phone_hash', $phoneHash)->first();
    }
}
