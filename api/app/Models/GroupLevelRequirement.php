<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class GroupLevelRequirement extends Model
{
    protected $fillable = [
        'group_id',
        'sport_type',
        'level_key',
        'level_name',
        'level_description',
    ];

    protected $casts = [
        'group_id' => 'integer',
    ];

    /**
     * Get the group that owns this level requirement
     */
    public function group(): BelongsTo
    {
        return $this->belongsTo(Group::class);
    }

    /**
     * Get Vietnamese level name for display
     */
    public function getDisplayNameAttribute(): string
    {
        return $this->level_name;
    }

    /**
     * Get sport-specific level definitions
     */
    public static function getSportLevels(string $sportType): array
    {
        return match($sportType) {
            'badminton' => [
                'moi_bat_dau' => 'Mới bắt đầu',
                'so_cap' => 'Sơ cấp', 
                'trung_cap' => 'Trung cấp',
                'cao_cap' => 'Cao cấp',
                'chuyen_nghiep' => 'Chuyên nghiệp',
            ],
            'tennis' => [
                'moi_bat_dau' => 'Mới bắt đầu (1.5-2.0)',
                'so_cap' => 'Sơ cấp (2.5-3.0)',
                'trung_cap' => 'Trung cấp (3.5-4.0)', 
                'cao_cap' => 'Cao cấp (4.5-5.0)',
                'chuyen_nghiep' => 'Chuyên nghiệp (5.5+)',
            ],
            'football' => [
                'moi_bat_dau' => 'Mới bắt đầu',
                'so_cap' => 'Sơ cấp (Bronze)',
                'trung_cap' => 'Trung cấp (Silver)',
                'cao_cap' => 'Cao cấp (Gold)',
                'chuyen_nghiep' => 'Chuyên nghiệp (Elite)',
            ],
            'pickleball' => [
                'moi_bat_dau' => 'Mới bắt đầu (1.0-2.5)',
                'so_cap' => 'Sơ cấp (3.0)',
                'trung_cap' => 'Trung cấp (3.5-4.0)',
                'cao_cap' => 'Cao cấp (4.5)',
                'chuyen_nghiep' => 'Chuyên nghiệp (5.0+)',
            ],
            default => []
        };
    }

    /**
     * Check if a level key is valid for a sport
     */
    public static function isValidLevelForSport(string $sportType, string $levelKey): bool
    {
        $levels = self::getSportLevels($sportType);
        return array_key_exists($levelKey, $levels);
    }

    /**
     * Get validation rules
     */
    public static function getValidationRules(): array
    {
        return [
            'group_id' => 'required|exists:groups,id',
            'sport_type' => 'required|in:football,badminton,tennis,pickleball',
            'level_key' => 'required|in:moi_bat_dau,so_cap,trung_cap,cao_cap,chuyen_nghiep',
            'level_name' => 'required|string|max:255',
            'level_description' => 'nullable|string|max:1000',
        ];
    }
}