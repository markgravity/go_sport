<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\FirebaseAuthService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class FirebaseAuthController extends Controller
{
    protected FirebaseAuthService $firebaseAuth;

    public function __construct(FirebaseAuthService $firebaseAuth)
    {
        $this->firebaseAuth = $firebaseAuth;
    }

    /**
     * Authenticate user with Firebase ID token and sync with Laravel
     */
    public function authenticate(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'id_token' => 'required|string',
            'name' => 'sometimes|string|max:255',
            'preferred_sports' => 'sometimes|array',
            'preferred_sports.*' => 'string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Verify Firebase ID token
            $firebaseUser = $this->firebaseAuth->verifyIdToken($request->id_token);
            
            if (!$firebaseUser) {
                return response()->json([
                    'success' => false,
                    'message' => 'Token xác thực không hợp lệ',
                ], 401);
            }

            // Validate Vietnamese phone number format
            if (!empty($firebaseUser['phone'])) {
                $phone = User::formatVietnamesePhone($firebaseUser['phone']);
                
                if (!preg_match('/^(\+84|84|0)[3-9][0-9]{8}$/', $phone)) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Số điện thoại không đúng định dạng Việt Nam',
                    ], 422);
                }
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Yêu cầu số điện thoại để đăng ký',
                ], 422);
            }

            // Find or create Laravel user
            $user = User::where('firebase_uid', $firebaseUser['uid'])->first();
            
            if (!$user && !empty($phone)) {
                // Check if user exists by phone
                $user = User::where('phone', $phone)->first();
                
                if ($user) {
                    // Link existing user to Firebase
                    $user->update(['firebase_uid' => $firebaseUser['uid']]);
                }
            }

            if (!$user) {
                // Create new user
                $user = User::create([
                    'firebase_uid' => $firebaseUser['uid'],
                    'name' => $request->name ?? 'Người dùng Go Sport',
                    'phone' => $phone,
                    'email' => null, // Phone-based registration
                    'password' => null, // Firebase handles authentication
                    'preferences' => [
                        'sports' => $request->preferred_sports ?? [],
                        'language' => 'vi',
                        'locale' => 'vi_VN',
                    ],
                    'status' => 'active',
                    'phone_verified_at' => now(), // Firebase already verified
                ]);

                Log::info('New Firebase user created', [
                    'user_id' => $user->id,
                    'firebase_uid' => $firebaseUser['uid'],
                    'phone' => $phone
                ]);
            } else {
                // Update existing user info if provided
                $updates = [];
                if ($request->name) {
                    $updates['name'] = $request->name;
                }
                if ($request->preferred_sports) {
                    $preferences = $user->preferences ?? [];
                    $preferences['sports'] = $request->preferred_sports;
                    $updates['preferences'] = $preferences;
                }
                
                if (!empty($updates)) {
                    $user->update($updates);
                }
            }

            // Set custom claims in Firebase
            $customClaims = array_merge(
                config('firebase.auth.custom_claims', []),
                [
                    'laravel_user_id' => $user->id,
                    'phone' => $user->phone,
                    'verified' => true,
                ]
            );
            
            $this->firebaseAuth->setCustomClaims($firebaseUser['uid'], $customClaims);

            // Create Laravel API token for additional API access
            $user->tokens()->delete(); // Remove old tokens
            $token = $user->createToken('mobile-app')->plainTextToken;

            return response()->json([
                'success' => true,
                'message' => 'Đăng nhập thành công',
                'user' => [
                    'id' => $user->id,
                    'firebase_uid' => $user->firebase_uid,
                    'name' => $user->name,
                    'phone' => $user->phone,
                    'phone_verified' => !empty($user->phone_verified_at),
                    'preferences' => $user->preferences,
                    'created_at' => $user->created_at,
                ],
                'tokens' => [
                    'laravel_token' => $token,
                    'firebase_uid' => $firebaseUser['uid'],
                ],
            ], 200);

        } catch (\Exception $e) {
            Log::error('Firebase authentication failed', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'success' => false,
                'message' => 'Xảy ra lỗi trong quá trình xác thực',
                'debug' => app()->environment('local') ? $e->getMessage() : null,
            ], 500);
        }
    }

    /**
     * Get current user information
     */
    public function me(Request $request): JsonResponse
    {
        $user = $request->user();

        // Optionally sync with Firebase user data
        if ($user->firebase_uid && config('firebase.auth.auto_sync_users')) {
            $firebaseUser = $this->firebaseAuth->getUserByUid($user->firebase_uid);
            
            if ($firebaseUser && $firebaseUser['phone'] !== $user->phone) {
                $user->update(['phone' => $firebaseUser['phone']]);
            }
        }

        return response()->json([
            'success' => true,
            'user' => [
                'id' => $user->id,
                'firebase_uid' => $user->firebase_uid,
                'name' => $user->name,
                'phone' => $user->phone,
                'phone_verified' => !empty($user->phone_verified_at),
                'email' => $user->email,
                'preferences' => $user->preferences,
                'status' => $user->status,
                'created_at' => $user->created_at,
                'updated_at' => $user->updated_at,
            ],
        ]);
    }

    /**
     * Logout user (revoke Laravel token, Firebase tokens handled client-side)
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Đăng xuất thành công',
        ]);
    }

    /**
     * Delete user account (both Firebase and Laravel)
     */
    public function deleteAccount(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'id_token' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Token xác thực bắt buộc',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Verify Firebase ID token
            $firebaseUser = $this->firebaseAuth->verifyIdToken($request->id_token);
            
            if (!$firebaseUser) {
                return response()->json([
                    'success' => false,
                    'message' => 'Token xác thực không hợp lệ',
                ], 401);
            }

            $user = $request->user();
            
            // Verify the token belongs to the authenticated user
            if ($user->firebase_uid !== $firebaseUser['uid']) {
                return response()->json([
                    'success' => false,
                    'message' => 'Token không khớp với tài khoản',
                ], 403);
            }

            // Delete from Firebase
            $firebaseDeleted = $this->firebaseAuth->deleteUser($firebaseUser['uid']);
            
            if (!$firebaseDeleted) {
                Log::warning('Firebase user deletion failed', [
                    'user_id' => $user->id,
                    'firebase_uid' => $firebaseUser['uid']
                ]);
            }

            // Delete Laravel user (cascade will handle related records)
            $user->delete();

            Log::info('User account deleted', [
                'user_id' => $user->id,
                'firebase_uid' => $firebaseUser['uid'],
                'firebase_deleted' => $firebaseDeleted
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Tài khoản đã được xóa thành công',
            ]);

        } catch (\Exception $e) {
            Log::error('Account deletion failed', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'success' => false,
                'message' => 'Không thể xóa tài khoản',
                'debug' => app()->environment('local') ? $e->getMessage() : null,
            ], 500);
        }
    }

    /**
     * Check Firebase service status
     */
    public function status(): JsonResponse
    {
        return response()->json([
            'success' => true,
            'firebase_configured' => $this->firebaseAuth->isConfigured(),
            'auto_sync_enabled' => config('firebase.auth.auto_sync_users'),
            'environment' => app()->environment(),
        ]);
    }
}