<?php

use App\Http\Controllers\Api\AttendanceController;
use App\Http\Controllers\Api\GroupController;
use App\Http\Controllers\Api\HealthController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Health Check Endpoint
Route::get('/health', [HealthController::class, 'check']);

// Public routes (no authentication required)
Route::prefix('auth')->group(function () {
    Route::post('/register', [UserController::class, 'register']);
    Route::post('/login', [UserController::class, 'login']);
    Route::post('/verify-phone', [UserController::class, 'verifyPhone']);
    Route::post('/resend-verification', [UserController::class, 'resendVerification']);
});

// Protected routes (authentication required)
Route::middleware(['auth:sanctum'])->group(function () {
    
    // User management
    Route::prefix('user')->group(function () {
        Route::get('/profile', [UserController::class, 'profile']);
        Route::put('/profile', [UserController::class, 'updateProfile']);
        Route::post('/logout', [UserController::class, 'logout']);
        Route::delete('/account', [UserController::class, 'deleteAccount']);
    });

    // Group management
    Route::apiResource('groups', GroupController::class);
    Route::prefix('groups/{group}')->group(function () {
        Route::post('/join', [GroupController::class, 'join']);
        Route::post('/leave', [GroupController::class, 'leave']);
        Route::get('/members', [GroupController::class, 'members']);
        Route::post('/members/{user}/role', [GroupController::class, 'updateMemberRole']);
        Route::delete('/members/{user}', [GroupController::class, 'removeMember']);
    });

    // Attendance management
    Route::prefix('attendance')->group(function () {
        Route::get('/sessions', [AttendanceController::class, 'sessions']);
        Route::post('/sessions', [AttendanceController::class, 'createSession']);
        Route::get('/sessions/{session}', [AttendanceController::class, 'getSession']);
        Route::post('/sessions/{session}/checkin', [AttendanceController::class, 'checkIn']);
        Route::post('/sessions/{session}/checkout', [AttendanceController::class, 'checkOut']);
        Route::get('/history', [AttendanceController::class, 'history']);
        Route::get('/groups/{group}/stats', [AttendanceController::class, 'groupStats']);
    });

    // Payment management
    Route::prefix('payments')->group(function () {
        Route::get('/requests', [PaymentController::class, 'requests']);
        Route::post('/requests', [PaymentController::class, 'createRequest']);
        Route::get('/requests/{request}', [PaymentController::class, 'getRequest']);
        Route::post('/requests/{request}/pay', [PaymentController::class, 'processPayment']);
        Route::get('/history', [PaymentController::class, 'history']);
        Route::get('/groups/{group}/stats', [PaymentController::class, 'groupStats']);
        Route::post('/{payment}/confirm', [PaymentController::class, 'confirmPayment']);
        Route::post('/{payment}/refund', [PaymentController::class, 'refundPayment']);
    });

    // Notification management
    Route::prefix('notifications')->group(function () {
        Route::get('/', [NotificationController::class, 'index']);
        Route::get('/unread', [NotificationController::class, 'unread']);
        Route::post('/{notification}/read', [NotificationController::class, 'markAsRead']);
        Route::post('/mark-all-read', [NotificationController::class, 'markAllAsRead']);
        Route::delete('/{notification}', [NotificationController::class, 'delete']);
    });
});

// Fallback route for API not found
Route::fallback(function () {
    return response()->json([
        'message' => 'API endpoint not found',
        'status' => 'error',
        'code' => 404
    ], 404);
});