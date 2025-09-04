<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Firebase Service Account Configuration
    |--------------------------------------------------------------------------
    |
    | Path to the Firebase service account JSON file. This file contains the
    | credentials needed to authenticate with Firebase Admin SDK.
    |
    */
    'service_account_path' => env('FIREBASE_SERVICE_ACCOUNT_PATH', storage_path('app/firebase/service-account.json')),

    /*
    |--------------------------------------------------------------------------
    | Firebase Project Configuration
    |--------------------------------------------------------------------------
    |
    | Your Firebase project configuration. These values can be found in your
    | Firebase project settings.
    |
    */
    'project_id' => env('FIREBASE_PROJECT_ID'),
    'database_url' => env('FIREBASE_DATABASE_URL'),
    'storage_bucket' => env('FIREBASE_STORAGE_BUCKET'),

    /*
    |--------------------------------------------------------------------------
    | Authentication Configuration
    |--------------------------------------------------------------------------
    |
    | Configuration for Firebase Authentication integration with Laravel.
    |
    */
    'auth' => [
        // Enable automatic user sync between Firebase and Laravel
        'auto_sync_users' => env('FIREBASE_AUTO_SYNC_USERS', true),
        
        // Cache Firebase user data for performance
        'cache_user_data' => env('FIREBASE_CACHE_USER_DATA', true),
        'cache_ttl' => env('FIREBASE_CACHE_TTL', 3600), // 1 hour
        
        // Custom claims for Vietnamese users
        'custom_claims' => [
            'locale' => 'vi',
            'country' => 'VN',
            'app' => 'go_sport',
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Vietnamese Phone Number Configuration
    |--------------------------------------------------------------------------
    |
    | Configuration for Vietnamese phone number handling with Firebase Auth.
    |
    */
    'phone' => [
        'country_code' => '+84',
        'validation_regex' => '/^(\+84|84|0)[3-9][0-9]{8}$/',
        'format_for_firebase' => true, // Always format as +84xxxxxxxxx
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
        'log_token_verification' => env('FIREBASE_LOG_TOKEN_VERIFICATION', false),
        'mock_auth' => env('FIREBASE_MOCK_AUTH', false),
        'test_uid' => env('FIREBASE_TEST_UID', 'test-user-123'),
    ],
];