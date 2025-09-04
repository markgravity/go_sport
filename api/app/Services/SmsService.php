<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class SmsService
{
    protected $provider;
    protected $config;

    public function __construct()
    {
        $this->provider = config('sms.default_provider', 'log'); // Default to log for development
        $this->config = config('sms.providers.' . $this->provider, []);
    }

    /**
     * Send SMS verification code to Vietnamese phone number
     */
    public function sendVerificationCode(string $phone, string $code): bool
    {
        $message = $this->buildVerificationMessage($code);

        return match ($this->provider) {
            'viettel' => $this->sendViaViettel($phone, $message),
            'vnpt' => $this->sendViaVNPT($phone, $message),
            'twilio' => $this->sendViaTwilio($phone, $message),
            'log' => $this->sendViaLog($phone, $message),
            default => $this->sendViaLog($phone, $message),
        };
    }

    /**
     * Build Vietnamese verification message
     */
    protected function buildVerificationMessage(string $code): string
    {
        return "Ma xac thuc Go Sport cua ban la: {$code}. Ma co hieu luc trong 5 phut. Khong chia se ma nay voi bat ki ai.";
    }

    /**
     * Send SMS via Viettel SMS Gateway (Vietnamese provider)
     */
    protected function sendViaViettel(string $phone, string $message): bool
    {
        try {
            $response = Http::timeout(30)->post($this->config['api_url'], [
                'username' => $this->config['username'],
                'password' => $this->config['password'],
                'msisdn' => $phone,
                'message' => $message,
                'brandname' => $this->config['brandname'] ?? 'GoSport',
                'messagetype' => 'text',
            ]);

            if ($response->successful()) {
                $data = $response->json();
                Log::info('Viettel SMS sent successfully', [
                    'phone' => $phone,
                    'response' => $data
                ]);
                return true;
            }

            Log::error('Viettel SMS failed', [
                'phone' => $phone,
                'status' => $response->status(),
                'response' => $response->body()
            ]);
            return false;

        } catch (\Exception $e) {
            Log::error('Viettel SMS exception', [
                'phone' => $phone,
                'error' => $e->getMessage()
            ]);
            return false;
        }
    }

    /**
     * Send SMS via VNPT SMS Gateway (Vietnamese provider)
     */
    protected function sendViaVNPT(string $phone, string $message): bool
    {
        try {
            $response = Http::timeout(30)
                ->withHeaders([
                    'Authorization' => 'Bearer ' . $this->config['access_token'],
                    'Content-Type' => 'application/json',
                ])
                ->post($this->config['api_url'], [
                    'to' => $phone,
                    'content' => $message,
                    'sms_type' => $this->config['sms_type'] ?? 2, // Brandname SMS
                    'sender' => $this->config['sender'] ?? 'GoSport',
                ]);

            if ($response->successful()) {
                $data = $response->json();
                Log::info('VNPT SMS sent successfully', [
                    'phone' => $phone,
                    'response' => $data
                ]);
                return true;
            }

            Log::error('VNPT SMS failed', [
                'phone' => $phone,
                'status' => $response->status(),
                'response' => $response->body()
            ]);
            return false;

        } catch (\Exception $e) {
            Log::error('VNPT SMS exception', [
                'phone' => $phone,
                'error' => $e->getMessage()
            ]);
            return false;
        }
    }

    /**
     * Send SMS via Twilio (International backup)
     */
    protected function sendViaTwilio(string $phone, string $message): bool
    {
        try {
            $sid = $this->config['account_sid'];
            $token = $this->config['auth_token'];
            $from = $this->config['phone_number'];

            $response = Http::timeout(30)
                ->withBasicAuth($sid, $token)
                ->asForm()
                ->post("https://api.twilio.com/2010-04-01/Accounts/{$sid}/Messages.json", [
                    'From' => $from,
                    'To' => $phone,
                    'Body' => $message,
                ]);

            if ($response->successful()) {
                $data = $response->json();
                Log::info('Twilio SMS sent successfully', [
                    'phone' => $phone,
                    'message_sid' => $data['sid'] ?? null
                ]);
                return true;
            }

            Log::error('Twilio SMS failed', [
                'phone' => $phone,
                'status' => $response->status(),
                'response' => $response->body()
            ]);
            return false;

        } catch (\Exception $e) {
            Log::error('Twilio SMS exception', [
                'phone' => $phone,
                'error' => $e->getMessage()
            ]);
            return false;
        }
    }

    /**
     * Log SMS for development/testing (does not actually send SMS)
     */
    protected function sendViaLog(string $phone, string $message): bool
    {
        Log::info('SMS would be sent (log mode)', [
            'phone' => $phone,
            'message' => $message,
            'timestamp' => now()->toISOString()
        ]);

        // Always return true in log mode for development
        return true;
    }

    /**
     * Get the current SMS provider being used
     */
    public function getProvider(): string
    {
        return $this->provider;
    }

    /**
     * Check if the service is configured properly
     */
    public function isConfigured(): bool
    {
        if ($this->provider === 'log') {
            return true; // Log provider always works
        }

        return !empty($this->config) && 
               isset($this->config['api_url']) && 
               !empty($this->config['api_url']);
    }
}