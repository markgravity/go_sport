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
        'current_members',
        'membership_fee',
        'privacy',
        'status',
        'avatar',
        'rules',
        'creator_id'
    ];

    protected $casts = [
        'schedule' => 'array',
        'rules' => 'array',
        'latitude' => 'decimal:8',
        'longitude' => 'decimal:8',
        'membership_fee' => 'decimal:2',
        'max_members' => 'integer',
        'current_members' => 'integer',
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
            'cau_long' => 'Cầu lông',
            'bong_da' => 'Bóng đá',
            'bong_ro' => 'Bóng rổ',
            'tennis' => 'Tennis',
            'bong_chuyen' => 'Bóng chuyền',
            'bong_ban' => 'Bóng bàn',
            'chay_bo' => 'Chạy bộ',
            'dap_xe' => 'Đạp xe',
            'boi_loi' => 'Bơi lội',
            'yoga' => 'Yoga',
            'gym' => 'Gym',
            'khac' => 'Khác',
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
            'cau_long' => [
                'min_players' => 2,
                'max_players' => 4,
                'notification_hours' => 24,
                'typical_locations' => ['Sân cầu lông', 'Trung tâm thể thao']
            ],
            'bong_da' => [
                'min_players' => 10,
                'max_players' => 22,
                'notification_hours' => 48,
                'typical_locations' => ['Sân bóng đá', 'Sân cỏ nhân tạo']
            ],
            'bong_ro' => [
                'min_players' => 8,
                'max_players' => 12,
                'notification_hours' => 24,
                'typical_locations' => ['Sân bóng rổ', 'Nhà thi đấu']
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
}
