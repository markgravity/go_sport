<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Session\Middleware\StartSession;
use App\Http\Controllers\InvitationLandingController;

Route::get('/', function () {
    return view('welcome');
});

// Invitation landing pages (public access)
Route::prefix('invite')->group(function () {
    Route::get('/{token}', [InvitationLandingController::class, 'show'])->name('invitation.landing');
    Route::post('/{token}/join', [InvitationLandingController::class, 'join'])->name('invitation.join');
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
