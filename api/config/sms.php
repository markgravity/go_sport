<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Default SMS Provider
    |--------------------------------------------------------------------------
    |
    | This option controls the default SMS provider that will be used to send
    | verification codes. Vietnamese providers like Viettel and VNPT are
    | preferred for better delivery rates and lower costs within Vietnam.
    |
    | Supported: "viettel", "vnpt", "twilio", "log"
    |
    */

    'default_provider' => env('SMS_PROVIDER', 'log'),

    /*
    |--------------------------------------------------------------------------
    | SMS Provider Configurations
    |--------------------------------------------------------------------------
    |
    | Here you can configure the settings for each SMS provider. Make sure to
    | set the appropriate environment variables for the provider you choose.
    |
    */

    'providers' => [

        'viettel' => [
            'api_url' => env('VIETTEL_SMS_API_URL', 'https://cloudsms4.viettel.vn/api/02/send-sms'),
            'username' => env('VIETTEL_SMS_USERNAME'),
            'password' => env('VIETTEL_SMS_PASSWORD'),
            'brandname' => env('VIETTEL_SMS_BRANDNAME', 'GoSport'),
            'message_type' => 'text',
        ],

        'vnpt' => [
            'api_url' => env('VNPT_SMS_API_URL', 'https://cloudsms.vnpt.vn/api/push-brandname-otp'),
            'access_token' => env('VNPT_SMS_ACCESS_TOKEN'),
            'sender' => env('VNPT_SMS_SENDER', 'GoSport'),
            'sms_type' => env('VNPT_SMS_TYPE', 2), // 2 = Brandname SMS
        ],

        'twilio' => [
            'account_sid' => env('TWILIO_ACCOUNT_SID'),
            'auth_token' => env('TWILIO_AUTH_TOKEN'),
            'phone_number' => env('TWILIO_PHONE_NUMBER'),
        ],

        'log' => [
            // Log provider doesn't need configuration
            // Used for development and testing
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | SMS Templates
    |--------------------------------------------------------------------------
    |
    | These are the message templates used for different types of SMS.
    | Messages are optimized for Vietnamese users and mobile carriers.
    |
    */

    'templates' => [
        'verification' => 'Ma xac thuc Go Sport cua ban la: {code}. Ma co hieu luc trong 5 phut. Khong chia se ma nay voi bat ki ai.',
        'welcome' => 'Chao mung ban den voi Go Sport! Tai khoan cua ban da duoc tao thanh cong.',
        'password_reset' => 'Ma dat lai mat khau Go Sport: {code}. Ma co hieu luc trong 10 phut.',
        'invitation' => '🏸 Mời tham gia nhóm {sport_name}!\n\n"{group_name}"{location}\nNgười mời: {creator_name}\n\nNhấn vào liên kết để tham gia{expiry}:\n{invitation_url}\n\nGoSport - Kết nối đam mê thể thao',
        'invitation_friendly' => 'Chào bạn! 👋\n\n{creator_name} mời bạn tham gia nhóm {sport_name} "{group_name}"{location}.\n\nCùng chơi thể thao và kết bạn nhé!\n{invitation_url}{expiry}\n\nGoSport',
        'invitation_formal' => 'Thư mời tham gia nhóm thể thao\n\nNhóm: {group_name}\nMôn: {sport_name}{location}\nNgười mời: {creator_name}\n\nVui lòng truy cập: {invitation_url}{expiry}\n\nTrân trọng,\nGoSport Team',
    ],

    /*
    |--------------------------------------------------------------------------
    | Vietnamese Carrier Settings
    |--------------------------------------------------------------------------
    |
    | Optimizations for Vietnamese mobile carriers to improve delivery rates
    | and reduce costs. These settings are provider-specific.
    |
    */

    'vietnamese_carriers' => [
        'viettel' => ['prefixes' => ['86', '96', '97', '98', '32', '33', '34', '35', '36', '37', '38', '39']],
        'vinaphone' => ['prefixes' => ['91', '94', '88', '83', '84', '85', '81', '82']],
        'mobifone' => ['prefixes' => ['90', '93', '70', '79', '77', '76', '78']],
        'vietnamobile' => ['prefixes' => ['92', '56', '58']],
        'gmobile' => ['prefixes' => ['99', '59']],
    ],

    /*
    |--------------------------------------------------------------------------
    | Rate Limiting
    |--------------------------------------------------------------------------
    |
    | SMS rate limiting configuration to prevent abuse and manage costs.
    | These limits are enforced in addition to the application-level limits.
    |
    */

    'rate_limits' => [
        'per_phone_per_hour' => 5,
        'per_phone_per_day' => 10,
        'global_per_minute' => 100,
    ],

    /*
    |--------------------------------------------------------------------------
    | Development Settings
    |--------------------------------------------------------------------------
    |
    | Settings for development and testing environments.
    |
    */

    'development' => [
        'log_all_attempts' => env('SMS_LOG_ALL_ATTEMPTS', true),
        'simulate_failures' => env('SMS_SIMULATE_FAILURES', false),
        'failure_rate' => env('SMS_FAILURE_RATE', 0.1), // 10% failure rate for testing
    ],
];