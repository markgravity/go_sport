<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Session\Middleware\StartSession;
use App\Http\Controllers\InvitationLandingController;
use App\Http\Controllers\Web\InviteController;

Route::get('/', function () {
    return view('welcome');
});

// Invitation landing pages (public access)
Route::prefix('invite')->name('invite.')->group(function () {
    Route::get('/{token}', [InviteController::class, 'show'])->name('show');
    Route::get('/{token}/success', [InviteController::class, 'success'])->name('success');
    Route::get('/{token}/register', [InviteController::class, 'register'])->name('register');
    Route::post('/{token}/join', [InviteController::class, 'join'])->name('join');
    Route::get('/{token}/data', [InviteController::class, 'getData'])->name('data');
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
