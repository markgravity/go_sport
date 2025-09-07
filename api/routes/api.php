<?php

use App\Http\Controllers\Api\AttendanceController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\FirebaseAuthController;
use App\Http\Controllers\Api\GroupController;
use App\Http\Controllers\Api\HealthController;
use App\Http\Controllers\Api\ImageUploadController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\SportsController;
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

// Sports configuration (public endpoint)
Route::prefix('sports')->group(function () {
    Route::get('/', [SportsController::class, 'index']);
    Route::get('/{sportType}', [SportsController::class, 'show']);
    Route::get('/{sportType}/defaults', [SportsController::class, 'getDefaults']);
    Route::get('/{sportType}/locations', [SportsController::class, 'getLocationSuggestions']);
    Route::get('/{sportType}/name-suggestions', [SportsController::class, 'getNameSuggestions']);
    Route::get('/{sportType}/levels', [GroupController::class, 'getSportLevels']); // Get skill levels for sport
});

// Image upload (public endpoint for default avatars)
Route::prefix('images')->group(function () {
    Route::get('/default-avatars', [ImageUploadController::class, 'getDefaultAvatars']);
});

// Public routes (no authentication required)
Route::prefix('auth')->group(function () {
    // SMS-based authentication with rate limiting
    Route::post('/send-verification-code', [AuthController::class, 'sendVerificationCode']);
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login'])->middleware('rate_limit_login');
    
    // Password reset with rate limiting
    Route::post('/password-reset-request', [AuthController::class, 'requestPasswordReset'])->middleware('rate_limit_login');
    Route::post('/password-reset-confirm', [AuthController::class, 'confirmPasswordReset']);
    
    // Firebase-based authentication (recommended)
    Route::post('/firebase/authenticate', [FirebaseAuthController::class, 'authenticate']);
    Route::get('/firebase/status', [FirebaseAuthController::class, 'status']);
});

// Protected routes (authentication required)
Route::middleware(['auth:sanctum'])->group(function () {
    
    // Authentication management
    Route::post('/auth/logout', [AuthController::class, 'logout']);
    Route::post('/auth/refresh', [AuthController::class, 'refresh']);
    Route::get('/auth/me', [AuthController::class, 'me']);
    
    // Firebase authentication management
    Route::post('/auth/firebase/logout', [FirebaseAuthController::class, 'logout']);
    Route::get('/auth/firebase/me', [FirebaseAuthController::class, 'me']);
    Route::delete('/auth/firebase/delete-account', [FirebaseAuthController::class, 'deleteAccount']);

    // User management
    Route::prefix('user')->group(function () {
        Route::get('/profile', [UserController::class, 'profile']);
        Route::put('/profile', [UserController::class, 'updateProfile']);
        Route::delete('/account', [UserController::class, 'deleteAccount']);
    });

    // Group management  
    Route::get('groups', [GroupController::class, 'index']); // Public endpoint for discovery
    Route::get('groups/{group}', [GroupController::class, 'show']); // Public endpoint
    Route::put('groups/{group}', [GroupController::class, 'update'])
          ->middleware('group.permission:edit_group'); // Requires edit permission
    Route::delete('groups/{group}', [GroupController::class, 'destroy'])
          ->middleware('group.permission:delete_group'); // Requires delete permission
    Route::post('groups', [GroupController::class, 'store'])->middleware('throttle:5,60'); // 5 groups per hour
    Route::prefix('groups/{group}')->group(function () {
        Route::post('/join', [GroupController::class, 'join']);
        Route::post('/leave', [GroupController::class, 'leave']);
        Route::get('/members', [GroupController::class, 'members']);
        Route::get('/permissions', [GroupController::class, 'getUserPermissions']);
        
        // Role management - requires specific permissions
        Route::post('/members/{user}/role', [GroupController::class, 'updateMemberRole'])
              ->middleware('group.permission:change_member_roles');
        Route::delete('/members/{user}', [GroupController::class, 'removeMember'])
              ->middleware('group.permission:remove_members');
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

    // Image upload management
    Route::prefix('images')->group(function () {
        Route::post('/upload/group-avatar', [ImageUploadController::class, 'uploadGroupAvatar'])->middleware('throttle:10,60'); // 10 uploads per hour
        Route::delete('/delete', [ImageUploadController::class, 'deleteImage']);
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