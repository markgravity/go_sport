<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Group extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'name',
        'vietnamese_name',
        'description',
        'sport_type',
        'skill_level',
        'location',
        'city',
        'district',
        'latitude',
        'longitude',
        'schedule',
        'max_members',
        'min_players',
        'current_members',
        'membership_fee',
        'privacy',
        'auto_approve_members',
        'status',
        'avatar',
        'rules',
        'notification_hours_before',
        'default_locations',
        'sport_specific_settings',
        'creator_id'
    ];

    protected $casts = [
        'schedule' => 'array',
        'rules' => 'array',
        'default_locations' => 'array',
        'sport_specific_settings' => 'array',
        'latitude' => 'decimal:8',
        'longitude' => 'decimal:8',
        'membership_fee' => 'decimal:2',
        'max_members' => 'integer',
        'min_players' => 'integer',
        'current_members' => 'integer',
        'notification_hours_before' => 'integer',
        'auto_approve_members' => 'boolean',
    ];

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'creator_id');
    }

    public function memberships(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'group_memberships')
                    ->withPivot(['role', 'status', 'joined_at', 'left_at', 'join_reason', 'leave_reason', 'total_paid', 'attendance_count', 'member_notes'])
                    ->withTimestamps();
    }

    public function activeMembers(): BelongsToMany
    {
        return $this->memberships()->wherePivot('status', 'hoat_dong');
    }

    public function pendingMembers(): BelongsToMany
    {
        return $this->memberships()->wherePivot('status', 'pending');
    }

    public function getSportNameAttribute(): string
    {
        return match($this->sport_type) {
            'badminton' => 'Cầu lông',
            'football' => 'Bóng đá',
            'tennis' => 'Tennis',
            'pickleball' => 'Pickleball',
            default => $this->sport_type
        };
    }

    public function getSkillLevelNameAttribute(): string
    {
        return match($this->skill_level) {
            'moi_bat_dau' => 'Mới bắt đầu',
            'trung_binh' => 'Trung bình',
            'gioi' => 'Giỏi',
            'chuyen_nghiep' => 'Chuyên nghiệp',
            default => $this->skill_level
        };
    }

    public function getPrivacyNameAttribute(): string
    {
        return match($this->privacy) {
            'cong_khai' => 'Công khai',
            'rieng_tu' => 'Riêng tư',
            default => $this->privacy
        };
    }

    public function getStatusNameAttribute(): string
    {
        return match($this->status) {
            'hoat_dong' => 'Hoạt động',
            'tam_dung' => 'Tạm dừng',
            'dong_cua' => 'Đóng cửa',
            default => $this->status
        };
    }

    public function getDefaultSettings(): array
    {
        return match($this->sport_type) {
            'badminton' => [
                'min_players' => 2,
                'max_players' => 4,
                'notification_hours' => 24,
                'typical_locations' => ['Sân cầu lông', 'Trung tâm thể thao']
            ],
            'football' => [
                'min_players' => 10,
                'max_players' => 22,
                'notification_hours' => 48,
                'typical_locations' => ['Sân bóng đá', 'Sân cỏ nhân tạo']
            ],
            'pickleball' => [
                'min_players' => 2,
                'max_players' => 4,
                'notification_hours' => 12,
                'typical_locations' => ['Sân pickleball', 'Sân tennis đa năng']
            ],
            'tennis' => [
                'min_players' => 2,
                'max_players' => 4,
                'notification_hours' => 12,
                'typical_locations' => ['Sân tennis', 'Câu lạc bộ tennis']
            ],
            default => [
                'min_players' => 2,
                'notification_hours' => 24,
                'typical_locations' => []
            ]
        ];
    }

    public function getAdmins(): BelongsToMany
    {
        return $this->activeMembers()->wherePivot('role', 'admin');
    }

    public function getModerators(): BelongsToMany
    {
        return $this->activeMembers()->wherePivot('role', 'moderator');
    }

    public function isAdmin(User $user): bool
    {
        return $this->memberships()
                    ->where('user_id', $user->id)
                    ->wherePivot('role', 'admin')
                    ->wherePivot('status', 'hoat_dong')
                    ->exists();
    }

    public function isModerator(User $user): bool
    {
        return $this->memberships()
                    ->where('user_id', $user->id)
                    ->wherePivot('role', 'moderator')
                    ->wherePivot('status', 'hoat_dong')
                    ->exists();
    }

    public function isMember(User $user): bool
    {
        return $this->memberships()
                    ->where('user_id', $user->id)
                    ->wherePivot('status', 'hoat_dong')
                    ->exists();
    }

    public function canManage(User $user): bool
    {
        return $user->id === $this->creator_id || $this->isAdmin($user) || $this->isModerator($user);
    }

    /**
     * Get validation rules for group creation
     */
    public static function getValidationRules(): array
    {
        return [
            'name' => 'required|string|max:255',
            'vietnamese_name' => 'nullable|string|max:255',
            'description' => 'nullable|string|max:1000',
            'sport_type' => 'required|in:football,badminton,tennis,pickleball',
            'skill_level' => 'required|in:moi_bat_dau,trung_binh,gioi,chuyen_nghiep',
            'location' => 'required|string|max:500',
            'city' => 'required|string|max:100',
            'district' => 'nullable|string|max:100',
            'latitude' => 'nullable|numeric|between:-90,90',
            'longitude' => 'nullable|numeric|between:-180,180',
            'schedule' => 'nullable|array',
            'max_members' => 'required|integer|min:2|max:50',
            'min_players' => 'nullable|integer|min:1',
            'membership_fee' => 'nullable|numeric|min:0',
            'privacy' => 'required|in:cong_khai,rieng_tu',
            'auto_approve_members' => 'nullable|boolean',
            'status' => 'in:hoat_dong,tam_dung,dong_cua',
            'rules' => 'nullable|array',
            'notification_hours_before' => 'nullable|integer|min:1|max:168',
            'default_locations' => 'nullable|array',
            'sport_specific_settings' => 'nullable|array',
        ];
    }

    /**
     * Get sport-specific validation rules
     */
    public static function getSportSpecificValidationRules(string $sportType): array
    {
        $baseRules = self::getValidationRules();
        
        return match($sportType) {
            'football' => array_merge($baseRules, [
                'min_players' => 'nullable|integer|min:6|max:11',
                'max_members' => 'required|integer|min:10|max:30',
            ]),
            'badminton' => array_merge($baseRules, [
                'min_players' => 'nullable|integer|min:2|max:2',
                'max_members' => 'required|integer|min:2|max:8',
            ]),
            'tennis' => array_merge($baseRules, [
                'min_players' => 'nullable|integer|min:2|max:2',
                'max_members' => 'required|integer|min:2|max:6',
            ]),
            'pickleball' => array_merge($baseRules, [
                'min_players' => 'nullable|integer|min:2|max:2',
                'max_members' => 'required|integer|min:2|max:8',
            ]),
            default => $baseRules
        };
    }

    /**
     * Validate Vietnamese name pattern
     */
    public static function isValidVietnameseName(string $name): bool
    {
        // Allow Vietnamese characters, numbers, spaces, and common punctuation
        return preg_match('/^[\p{L}\p{N}\s\-_.()]+$/u', $name) === 1;
    }
}
