<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;

class SmsService
{
    protected string $provider;
    protected array $config;

    public function __construct()
    {
        $this->provider = config('sms.default_provider', 'twilio');
        $this->config = config("sms.providers.{$this->provider}", []);
    }

    /**
     * Send SMS message
     */
    public function sendSms(string $phoneNumber, string $message, string $type = 'general'): bool
    {
        try {
            // Rate limiting check
            $rateLimitKey = "sms_rate_limit:{$phoneNumber}";
            $recentSms = Cache::get($rateLimitKey, 0);
            
            if ($recentSms >= 5) { // Max 5 SMS per hour per number
                Log::warning('SMS rate limit exceeded', [
                    'phone' => $phoneNumber,
                    'type' => $type
                ]);
                return false;
            }

            // Normalize phone number for international format
            $normalizedPhone = $this->normalizePhoneNumber($phoneNumber);
            
            if (!$this->validatePhoneNumber($normalizedPhone)) {
                Log::error('Invalid phone number format', [
                    'phone' => $phoneNumber,
                    'normalized' => $normalizedPhone
                ]);
                return false;
            }

            // Send via configured provider
            $result = match ($this->provider) {
                'twilio' => $this->sendViaTwilio($normalizedPhone, $message),
                'firebase' => $this->sendViaFirebase($normalizedPhone, $message),
                'mock' => $this->sendViaMock($normalizedPhone, $message),
                default => $this->sendViaMock($normalizedPhone, $message),
            };

            if ($result) {
                // Update rate limiting counter
                Cache::put($rateLimitKey, $recentSms + 1, 3600); // 1 hour

                Log::info('SMS sent successfully', [
                    'phone' => $normalizedPhone,
                    'type' => $type,
                    'provider' => $this->provider,
                    'message_length' => strlen($message)
                ]);
            }

            return $result;

        } catch (\Exception $e) {
            Log::error('SMS sending failed', [
                'phone' => $phoneNumber,
                'type' => $type,
                'error' => $e->getMessage(),
                'provider' => $this->provider
            ]);
            return false;
        }
    }

    /**
     * Send SMS via Twilio
     */
    private function sendViaTwilio(string $phone, string $message): bool
    {
        if (!isset($this->config['account_sid'], $this->config['auth_token'], $this->config['from'])) {
            Log::error('Twilio configuration incomplete');
            return false;
        }

        $url = "https://api.twilio.com/2010-04-01/Accounts/{$this->config['account_sid']}/Messages.json";
        
        $response = Http::asForm()
            ->withBasicAuth($this->config['account_sid'], $this->config['auth_token'])
            ->post($url, [
                'From' => $this->config['from'],
                'To' => '+' . $phone,
                'Body' => $message,
            ]);

        return $response->successful();
    }

    /**
     * Send SMS via Firebase (for development)
     */
    private function sendViaFirebase(string $phone, string $message): bool
    {
        // Firebase SMS is typically handled on the client side for verification
        // For invitation SMS, we'll use a mock implementation
        return $this->sendViaMock($phone, $message);
    }

    /**
     * Mock SMS sending for development/testing
     */
    private function sendViaMock(string $phone, string $message): bool
    {
        // Log the SMS that would be sent
        Log::info('Mock SMS sent', [
            'to' => $phone,
            'message' => $message,
            'timestamp' => now()->toISOString()
        ]);

        // Store in cache for testing purposes
        Cache::put("mock_sms:{$phone}:" . now()->timestamp, [
            'phone' => $phone,
            'message' => $message,
            'sent_at' => now(),
        ], 86400); // Store for 24 hours

        return true; // Always successful in mock mode
    }

    /**
     * Validate Vietnamese phone number
     */
    public function validatePhoneNumber(string $phone): bool
    {
        // Remove all non-numeric characters
        $cleanPhone = preg_replace('/[^0-9]/', '', $phone);
        
        // Check Vietnamese phone number patterns
        $patterns = [
            '/^84[35789]\d{8}$/',     // +84 format
            '/^0[35789]\d{8}$/',     // 0 prefix format
            '/^[35789]\d{8}$/',      // Without prefix
        ];

        foreach ($patterns as $pattern) {
            if (preg_match($pattern, $cleanPhone)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Normalize Vietnamese phone number to international format
     */
    public function normalizePhoneNumber(string $phone): string
    {
        // Remove all non-numeric characters
        $cleanPhone = preg_replace('/[^0-9]/', '', $phone);
        
        // Convert to international format (84XXXXXXXXX)
        if (preg_match('/^0([35789]\d{8})$/', $cleanPhone, $matches)) {
            return '84' . $matches[1];
        } elseif (preg_match('/^([35789]\d{8})$/', $cleanPhone)) {
            return '84' . $cleanPhone;
        } elseif (preg_match('/^84([35789]\d{8})$/', $cleanPhone)) {
            return $cleanPhone;
        }

        // Return original if no pattern matches
        return $cleanPhone;
    }

    /**
     * Get recent mock SMS messages for testing
     */
    public function getRecentMockSms(string $phone, int $hours = 24): array
    {
        $messages = [];
        $pattern = "mock_sms:{$phone}:*";
        
        // This is simplified - in production, you'd use Redis SCAN or similar
        // For now, we'll return empty array as this is mainly for development
        return $messages;
    }

    /**
     * Check SMS rate limit status
     */
    public function checkRateLimit(string $phone): array
    {
        $rateLimitKey = "sms_rate_limit:{$phone}";
        $count = Cache::get($rateLimitKey, 0);
        $remaining = max(0, 5 - $count);
        
        return [
            'count' => $count,
            'remaining' => $remaining,
            'limit' => 5,
            'reset_at' => now()->addHour(),
        ];
    }

    /**
     * Get SMS provider configuration info (without sensitive data)
     */
    public function getProviderInfo(): array
    {
        return [
            'provider' => $this->provider,
            'configured' => !empty($this->config),
            'rate_limit' => 5, // messages per hour per number
        ];
    }
}