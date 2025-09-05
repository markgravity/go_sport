<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Session\Middleware\StartSession;

Route::get('/', function () {
    return view('welcome');
});

// Lightweight health endpoint (non-API prefix) skipping session/cookie middlewares
Route::middleware('api')
    ->withoutMiddleware([StartSession::class, EncryptCookies::class, AddQueuedCookiesToResponse::class])
    ->get('/health', function (Request $request) {
        return response()->json([
            'status' => 'OK',
            'path' => '/health',
        ], 200);
    });
