<?php

namespace App\Services;

class SportsConfigurationService
{
    /**
     * Get all supported sports with Vietnamese names and configurations
     */
    public static function getSupportedSports(): array
    {
        return [
            'football' => [
                'english_name' => 'Football',
                'vietnamese_name' => 'Bóng đá',
                'description' => 'Môn thể thao vua với 11 người mỗi đội',
                'icon' => 'football',
                'color' => '#4CAF50',
                'defaults' => [
                    'min_players' => 6, // Minimum for small-sided games
                    'max_members' => 22, // Full squad
                    'notification_hours_before' => 48, // 2 days notice
                    'typical_duration_minutes' => 90,
                    'field_type' => 'outdoor',
                ],
                'typical_locations' => [
                    'Sân bóng đá cỏ nhân tạo',
                    'Sân bóng đá mini',
                    'Sân bóng đá 7 người',
                    'Sân bóng đá 11 người',
                    'Sân bóng Thống Nhất',
                    'Sân bóng Rạch Miễu'
                ],
                'cultural_notes' => [
                    'Popular match days' => ['Thứ 7', 'Chủ nhật'],
                    'Popular times' => ['Sáng sớm', 'Chiều tối'],
                    'Common formats' => ['5v5', '7v7', '11v11']
                ]
            ],
            'badminton' => [
                'english_name' => 'Badminton',
                'vietnamese_name' => 'Cầu lông',
                'description' => 'Môn thể thao trong nhà phổ biến nhất Việt Nam',
                'icon' => 'badminton',
                'color' => '#FF9800',
                'defaults' => [
                    'min_players' => 2, // Singles
                    'max_members' => 8, // Multiple courts
                    'notification_hours_before' => 24, // 1 day notice
                    'typical_duration_minutes' => 60,
                    'field_type' => 'indoor',
                ],
                'typical_locations' => [
                    'Trung tâm thể thao cầu lông',
                    'Sân cầu lông Khánh Hội',
                    'Sân cầu lông Rạch Miễu',
                    'CLB cầu lông',
                    'Nhà thi đấu',
                    'Sân cầu lông cao cấp'
                ],
                'cultural_notes' => [
                    'Popular match days' => ['Tối trong tuần', 'Cuối tuần'],
                    'Popular times' => ['18:00-22:00', '06:00-10:00'],
                    'Common formats' => ['Đơn nam', 'Đơn nữ', 'Đôi nam', 'Đôi nữ', 'Đôi nam nữ']
                ]
            ],
            'tennis' => [
                'english_name' => 'Tennis',
                'vietnamese_name' => 'Tennis',
                'description' => 'Môn thể thao quý族 với kỹ thuật cao',
                'icon' => 'tennis',
                'color' => '#2196F3',
                'defaults' => [
                    'min_players' => 2, // Singles
                    'max_members' => 6, // Limited court access
                    'notification_hours_before' => 12, // Half day notice
                    'typical_duration_minutes' => 90,
                    'field_type' => 'outdoor',
                ],
                'typical_locations' => [
                    'Sân tennis Lan Anh',
                    'Câu lạc bộ Tennis',
                    'Sân tennis cao cấp',
                    'Trung tâm thể thao tennis',
                    'Sân tennis resort',
                    'Sân tennis công cộng'
                ],
                'cultural_notes' => [
                    'Popular match days' => ['Sáng cuối tuần', 'Chiều trong tuần'],
                    'Popular times' => ['06:00-09:00', '16:00-19:00'],
                    'Common formats' => ['Singles', 'Doubles']
                ]
            ],
            'pickleball' => [
                'english_name' => 'Pickleball',
                'vietnamese_name' => 'Pickleball',
                'description' => 'Môn thể thao mới nổi, dễ chơi cho mọi lứa tuổi',
                'icon' => 'pickleball',
                'color' => '#9C27B0',
                'defaults' => [
                    'min_players' => 2, // Singles
                    'max_members' => 8, // Multiple courts
                    'notification_hours_before' => 12, // Half day notice
                    'typical_duration_minutes' => 45,
                    'field_type' => 'outdoor',
                ],
                'typical_locations' => [
                    'Sân tennis đa năng',
                    'Sân pickleball chuyên dụng',
                    'Trung tâm thể thao đa năng',
                    'Sân thể thao công cộng',
                    'CLB pickleball',
                    'Sân pickleball resort'
                ],
                'cultural_notes' => [
                    'Popular match days' => ['Mọi ngày trong tuần'],
                    'Popular times' => ['Sáng sớm', 'Chiều tối'],
                    'Common formats' => ['Singles', 'Doubles', 'Mixed doubles']
                ]
            ]
        ];
    }

    /**
     * Get sport configuration by sport type
     */
    public static function getSportConfig(string $sportType): ?array
    {
        $sports = self::getSupportedSports();
        return $sports[$sportType] ?? null;
    }

    /**
     * Get Vietnamese name for sport
     */
    public static function getVietnameseName(string $sportType): string
    {
        $config = self::getSportConfig($sportType);
        return $config['vietnamese_name'] ?? $sportType;
    }

    /**
     * Get default settings for a sport
     */
    public static function getDefaultSettings(string $sportType): array
    {
        $config = self::getSportConfig($sportType);
        return $config['defaults'] ?? [];
    }

    /**
     * Get typical locations for a sport
     */
    public static function getTypicalLocations(string $sportType): array
    {
        $config = self::getSportConfig($sportType);
        return $config['typical_locations'] ?? [];
    }

    /**
     * Get Vietnamese naming suggestions for groups
     */
    public static function getVietnameseNameSuggestions(string $sportType, string $city = ''): array
    {
        $vietnameseName = self::getVietnameseName($sportType);
        
        $suggestions = [
            "CLB {$vietnameseName} " . ($city ? $city : 'Sài Gòn'),
            "Nhóm {$vietnameseName} Yêu Thích",
            "Đội {$vietnameseName} Phong Trào",
            "{$vietnameseName} Cuối Tuần",
            "CLB {$vietnameseName} Chuyên Nghiệp",
            "Nhóm {$vietnameseName} Giao Lưu",
        ];

        // Sport-specific suggestions
        switch ($sportType) {
            case 'football':
                $suggestions = array_merge($suggestions, [
                    'FC Sài Gòn United',
                    'Đội Bóng Phố',
                    'CLB Bóng Đá Dân Phố'
                ]);
                break;
            case 'badminton':
                $suggestions = array_merge($suggestions, [
                    'CLB Cầu Lông Phong Trào',
                    'Nhóm Cầu Lông Sài Gòn',
                    'Cầu Lông Yêu Đời'
                ]);
                break;
            case 'tennis':
                $suggestions = array_merge($suggestions, [
                    'Tennis Club Elite',
                    'CLB Tennis Sài Gòn',
                    'Nhóm Tennis Cao Cấp'
                ]);
                break;
            case 'pickleball':
                $suggestions = array_merge($suggestions, [
                    'Pickleball Sài Gòn',
                    'CLB Pickleball Việt Nam',
                    'Nhóm Pickleball Mới'
                ]);
                break;
        }

        return $suggestions;
    }

    /**
     * Get sport icons mapping
     */
    public static function getSportIcon(string $sportType): string
    {
        $config = self::getSportConfig($sportType);
        return $config['icon'] ?? 'sports';
    }

    /**
     * Get sport color theme
     */
    public static function getSportColor(string $sportType): string
    {
        $config = self::getSportConfig($sportType);
        return $config['color'] ?? '#607D8B';
    }

    /**
     * Validate sport type
     */
    public static function isValidSport(string $sportType): bool
    {
        return array_key_exists($sportType, self::getSupportedSports());
    }

    /**
     * Get all sport types as array
     */
    public static function getAllSportTypes(): array
    {
        return array_keys(self::getSupportedSports());
    }

    /**
     * Get sport options for forms (key => Vietnamese name)
     */
    public static function getSportOptions(): array
    {
        $sports = self::getSupportedSports();
        $options = [];
        
        foreach ($sports as $key => $config) {
            $options[$key] = $config['vietnamese_name'];
        }
        
        return $options;
    }
}