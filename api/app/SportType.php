<?php

namespace App;

enum SportType: string
{
    case FOOTBALL = 'football';
    case BADMINTON = 'badminton';
    case TENNIS = 'tennis';
    case PICKLEBALL = 'pickleball';

    /**
     * Get Vietnamese name for the sport
     */
    public function getVietnameseName(): string
    {
        return match($this) {
            self::FOOTBALL => 'Bóng đá',
            self::BADMINTON => 'Cầu lông',
            self::TENNIS => 'Tennis',
            self::PICKLEBALL => 'Pickleball',
        };
    }

    /**
     * Get all sport types as array of strings
     */
    public static function values(): array
    {
        return array_column(self::cases(), 'value');
    }

    /**
     * Get options for forms (value => Vietnamese name)
     */
    public static function options(): array
    {
        $options = [];
        foreach (self::cases() as $case) {
            $options[$case->value] = $case->getVietnameseName();
        }
        return $options;
    }
}
