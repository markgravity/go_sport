<?php

namespace App\Services;

class SportsConfigService
{
    public static function getAvailableSports(): array
    {
        return [
            'cau_long' => [
                'name' => 'C�u l�ng',
                'english_name' => 'Badminton',
                'icon' => 'badminton',
                'defaults' => [
                    'max_members' => 8,
                    'min_players' => 2,
                    'max_players' => 4,
                    'notification_hours' => 24,
                    'typical_duration' => 120, // minutes
                    'typical_locations' => [
                        'S�n c�u l�ng',
                        'Trung t�m th� thao',
                        'Nh� thi �u',
                        'C�u l�c b� c�u l�ng'
                    ],
                    'equipment_needed' => [
                        'V�t c�u l�ng',
                        'Qu� c�u',
                        'Gi�y th� thao'
                    ]
                ],
                'skill_levels' => [
                    'moi_bat_dau' => 'M�i b�t �u',
                    'trung_binh' => 'Trung b�nh', 
                    'gioi' => 'Gi�i',
                    'chuyen_nghiep' => 'Chuy�n nghi�p'
                ]
            ],
            'bong_da' => [
                'name' => 'B�ng �',
                'english_name' => 'Football/Soccer',
                'icon' => 'soccer',
                'defaults' => [
                    'max_members' => 22,
                    'min_players' => 10,
                    'max_players' => 22,
                    'notification_hours' => 48,
                    'typical_duration' => 90, // minutes
                    'typical_locations' => [
                        'S�n b�ng �',
                        'S�n c� nh�n t�o',
                        'S�n c� t� nhi�n',
                        'Trung t�m th� thao'
                    ],
                    'equipment_needed' => [
                        'B�ng �',
                        'Gi�y � b�ng',
                        'T�t b�ng �',
                        '�o �u'
                    ]
                ],
                'skill_levels' => [
                    'moi_bat_dau' => 'M�i b�t �u',
                    'trung_binh' => 'Trung b�nh',
                    'gioi' => 'Gi�i',
                    'chuyen_nghiep' => 'Chuy�n nghi�p'
                ]
            ],
            'bong_ro' => [
                'name' => 'B�ng r�',
                'english_name' => 'Basketball',
                'icon' => 'basketball',
                'defaults' => [
                    'max_members' => 15,
                    'min_players' => 8,
                    'max_players' => 12,
                    'notification_hours' => 24,
                    'typical_duration' => 120, // minutes
                    'typical_locations' => [
                        'S�n b�ng r�',
                        'Nh� thi �u',
                        'Trung t�m th� thao',
                        'S�n tr��ng h�c'
                    ],
                    'equipment_needed' => [
                        'B�ng r�',
                        'Gi�y th� thao',
                        'Qu�n �o th� thao'
                    ]
                ],
                'skill_levels' => [
                    'moi_bat_dau' => 'M�i b�t �u',
                    'trung_binh' => 'Trung b�nh',
                    'gioi' => 'Gi�i',
                    'chuyen_nghiep' => 'Chuy�n nghi�p'
                ]
            ],
            'tennis' => [
                'name' => 'Tennis',
                'english_name' => 'Tennis',
                'icon' => 'tennis',
                'defaults' => [
                    'max_members' => 8,
                    'min_players' => 2,
                    'max_players' => 4,
                    'notification_hours' => 12,
                    'typical_duration' => 90, // minutes
                    'typical_locations' => [
                        'S�n tennis',
                        'C�u l�c b� tennis',
                        'Trung t�m th� thao',
                        'Resort c� s�n tennis'
                    ],
                    'equipment_needed' => [
                        'V�t tennis',
                        'B�ng tennis',
                        'Gi�y tennis',
                        'Qu�n �o th� thao'
                    ]
                ],
                'skill_levels' => [
                    'moi_bat_dau' => 'M�i b�t �u',
                    'trung_binh' => 'Trung b�nh',
                    'gioi' => 'Gi�i',
                    'chuyen_nghiep' => 'Chuy�n nghi�p'
                ]
            ],
            'bong_chuyen' => [
                'name' => 'B�ng chuy�n',
                'english_name' => 'Volleyball',
                'icon' => 'volleyball',
                'defaults' => [
                    'max_members' => 16,
                    'min_players' => 6,
                    'max_players' => 12,
                    'notification_hours' => 24,
                    'typical_duration' => 90, // minutes
                    'typical_locations' => [
                        'S�n b�ng chuy�n',
                        'B�i bi�n',
                        'Nh� thi �u',
                        'Trung t�m th� thao'
                    ],
                    'equipment_needed' => [
                        'B�ng chuy�n',
                        'L��i b�ng chuy�n',
                        'Gi�y th� thao',
                        'Qu�n �o th� thao'
                    ]
                ],
                'skill_levels' => [
                    'moi_bat_dau' => 'M�i b�t �u',
                    'trung_binh' => 'Trung b�nh',
                    'gioi' => 'Gi�i',
                    'chuyen_nghiep' => 'Chuy�n nghi�p'
                ]
            ]
        ];
    }

    public static function getSportConfig(string $sportType): ?array
    {
        $sports = self::getAvailableSports();
        return $sports[$sportType] ?? null;
    }

    public static function getSportDefaults(string $sportType): array
    {
        $config = self::getSportConfig($sportType);
        return $config['defaults'] ?? [];
    }

    public static function getSportName(string $sportType): string
    {
        $config = self::getSportConfig($sportType);
        return $config['name'] ?? $sportType;
    }

    public static function getPopularSports(): array
    {
        return ['cau_long', 'bong_da', 'bong_ro', 'tennis', 'bong_chuyen'];
    }

    public static function getSportsByCategory(): array
    {
        return [
            'racket_sports' => [
                'name' => 'M�n th� thao v�t',
                'sports' => ['cau_long', 'tennis', 'bong_ban']
            ],
            'ball_sports' => [
                'name' => 'M�n th� thao b�ng',
                'sports' => ['bong_da', 'bong_ro', 'bong_chuyen']
            ],
            'individual_sports' => [
                'name' => 'Th� thao c� nh�n',
                'sports' => ['chay_bo', 'dap_xe', 'boi_loi', 'yoga', 'gym']
            ]
        ];
    }

    public static function getLocationSuggestions(string $sportType, string $city = null): array
    {
        $defaults = self::getSportDefaults($sportType);
        $locations = $defaults['typical_locations'] ?? [];

        // Add city-specific locations if provided
        if ($city) {
            $citySpecific = self::getCitySpecificLocations($sportType, $city);
            $locations = array_merge($locations, $citySpecific);
        }

        return array_unique($locations);
    }

    private static function getCitySpecificLocations(string $sportType, string $city): array
    {
        $cityLocations = [
            'H� N�i' => [
                'cau_long' => ['C�u l�ng M� �nh', 'Trung t�m c�u l�ng L�ng H�'],
                'bong_da' => ['S�n M� �nh', 'S�n b�ng H�ng �u'],
                'tennis' => ['S�n tennis L�ng H�', 'CLB Tennis M� �nh']
            ],
            'TP.HCM' => [
                'cau_long' => ['C�u l�ng Phan �nh Ph�ng', 'Trung t�m c�u l�ng Q7'],
                'bong_da' => ['S�n Th�ng Nh�t', 'S�n b�ng R�ch Mi�u'],
                'tennis' => ['S�n tennis Lan Anh', 'CLB Tennis Saigon']
            ]
        ];

        return $cityLocations[$city][$sportType] ?? [];
    }

    public static function validateSportData(array $data): array
    {
        $errors = [];
        
        if (empty($data['sport_type'])) {
            $errors[] = 'Vui l�ng ch�n m�n th� thao';
        } elseif (!array_key_exists($data['sport_type'], self::getAvailableSports())) {
            $errors[] = 'M�n th� thao kh�ng h�p l�';
        }

        if (!empty($data['max_members'])) {
            $sportDefaults = self::getSportDefaults($data['sport_type'] ?? '');
            $maxAllowed = $sportDefaults['max_players'] ?? 50;
            
            if ($data['max_members'] > $maxAllowed) {
                $errors[] = "S� th�nh vi�n t�i a cho {$data['sport_type']} kh�ng ��c v��t qu� {$maxAllowed}";
            }
        }

        return $errors;
    }
}