<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie'],

    'allowed_methods' => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],

    'allowed_origins' => [
        'http://localhost:3000',    // Flutter web dev server
        'http://127.0.0.1:3000',   // Flutter web dev server alternative
        'http://localhost:8080',   // Flutter web build
        'http://127.0.0.1:8080',   // Flutter web build alternative
        // Add production domains when deploying
    ],

    'allowed_origins_patterns' => [
        // Allow local development on any port
        '/^http:\/\/localhost:\d+$/',
        '/^http:\/\/127\.0\.0\.1:\d+$/',
    ],

    'allowed_headers' => [
        'Accept',
        'Authorization',
        'Content-Type',
        'X-Requested-With',
        'X-CSRF-TOKEN',
    ],

    'exposed_headers' => [
        'Authorization',
    ],

    'max_age' => 86400, // Cache preflight for 24 hours

    'supports_credentials' => true, // Enable for Sanctum authentication

];
