<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class VietnamesePhoneRule implements ValidationRule
{
    /**
     * Vietnamese mobile carriers and their number patterns
     */
    private const CARRIER_PREFIXES = [
        'Viettel' => ['032', '033', '034', '035', '036', '037', '038', '039'],
        'Vinaphone' => ['081', '082', '083', '084', '085', '088'],
        'MobiFone' => ['070', '071', '072', '073', '074', '075', '076', '077', '078', '079'],
        'Vietnamobile' => ['052', '056', '058'],
        'Gmobile' => ['059'],
        'Itelecom' => ['087'],
    ];

    /**
     * Complete regex for Vietnamese mobile numbers
     */
    private const MOBILE_REGEX = '/^(\+84|84|0)(32|33|34|35|36|37|38|39|81|82|83|84|85|88|70|71|72|73|74|75|76|77|78|79|52|56|58|59|87)[0-9]{7}$/';

    /**
     * Landline regex for Vietnamese fixed-line numbers
     */
    private const LANDLINE_REGEX = '/^(\+84|84|0)(24|28|22|26|27|29|25|23)[0-9]{7,8}$/';

    /**
     * Run the validation rule.
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if (!is_string($value)) {
            $fail('Số điện thoại phải là chuỗi ký tự.');
            return;
        }

        $cleaned = $this->cleanPhoneNumber($value);

        if (empty($cleaned)) {
            $fail('Vui lòng nhập số điện thoại.');
            return;
        }

        if (strlen($cleaned) < 9) {
            $fail('Số điện thoại quá ngắn.');
            return;
        }

        if (strlen($cleaned) > 12) {
            $fail('Số điện thoại quá dài.');
            return;
        }

        if (!$this->isValidVietnamesePhone($cleaned)) {
            $fail('Số điện thoại không đúng định dạng Việt Nam.');
            return;
        }
    }

    /**
     * Check if the phone number is a valid Vietnamese number (mobile or landline)
     */
    private function isValidVietnamesePhone(string $phone): bool
    {
        return $this->isValidVietnameseMobile($phone) || $this->isValidVietnameseLandline($phone);
    }

    /**
     * Check if the phone number is a valid Vietnamese mobile number
     */
    private function isValidVietnameseMobile(string $phone): bool
    {
        return preg_match(self::MOBILE_REGEX, $phone);
    }

    /**
     * Check if the phone number is a valid Vietnamese landline number
     */
    private function isValidVietnameseLandline(string $phone): bool
    {
        return preg_match(self::LANDLINE_REGEX, $phone);
    }

    /**
     * Clean phone number by removing all non-digit characters except +
     */
    private function cleanPhoneNumber(string $phone): string
    {
        return preg_replace('/[^\d+]/', '', $phone);
    }

    /**
     * Get the carrier name for a mobile number
     */
    public static function getCarrierName(string $phone): ?string
    {
        $instance = new self();
        if (!$instance->isValidVietnameseMobile($phone)) {
            return null;
        }

        $normalized = self::normalizePhoneNumber($phone);
        if (strlen($normalized) < 12) {
            return null;
        }

        $prefix = substr($normalized, 3, 3); // Get the 3-digit prefix after +84

        foreach (self::CARRIER_PREFIXES as $carrier => $prefixes) {
            if (in_array($prefix, $prefixes)) {
                return $carrier;
            }
        }

        return null;
    }

    /**
     * Normalize phone number to +84XXXXXXXXX format
     */
    public static function normalizePhoneNumber(string $phone): string
    {
        $cleaned = preg_replace('/[^\d+]/', '', $phone);
        
        // Remove country code variations and normalize to +84
        if (str_starts_with($cleaned, '+84')) {
            return $cleaned;
        } elseif (str_starts_with($cleaned, '84')) {
            return '+' . $cleaned;
        } elseif (str_starts_with($cleaned, '0')) {
            return '+84' . substr($cleaned, 1);
        } else {
            return '+84' . $cleaned;
        }
    }
}