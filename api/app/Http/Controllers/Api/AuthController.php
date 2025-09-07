<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\FirebaseAuthService;
use App\Rules\VietnamesePhoneRule;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class AuthController extends Controller
{
    protected FirebaseAuthService $firebaseAuth;

    public function __construct(FirebaseAuthService $firebaseAuth)
    {
        $this->firebaseAuth = $firebaseAuth;
    }

    /**
     * Register user with Firebase SMS verification
     */
    public function register(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'phone' => [
                'required',
                'string',
                new VietnamesePhoneRule(),
            ],
            'password' => 'required|string|min:8|confirmed',
            'verification_id' => 'required|string',
            'sms_code' => 'required|string|size:6',
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

        $phone = User::formatVietnamesePhone($request->phone);

        // Validate phone number format
        if (!preg_match('/^(\+84|84|0)[3-9][0-9]{8}$/', $phone)) {
            return response()->json([
                'success' => false,
                'message' => 'Số điện thoại không đúng định dạng Việt Nam',
            ], 422);
        }

        // Validate verification ID format (basic check)
        if (empty($request->verification_id) || strlen($request->verification_id) < 10) {
            return response()->json([
                'success' => false,
                'message' => 'Mã xác thực Firebase không hợp lệ',
            ], 422);
        }

        // Validate SMS code format
        if (!preg_match('/^\d{6}$/', $request->sms_code)) {
            return response()->json([
                'success' => false,
                'message' => 'Mã SMS phải có đúng 6 số',
            ], 422);
        }

        // Verify with Firebase server
        if (!$this->firebaseAuth->verifyPhoneNumberForRegistration(
            $phone, 
            $request->verification_id, 
            $request->sms_code
        )) {
            return response()->json([
                'success' => false,
                'message' => 'Xác thực Firebase thất bại. Vui lòng kiểm tra mã xác thực.',
            ], 422);
        }

        // Check if user already exists
        $existingUser = User::findByPhone($phone);
        if ($existingUser) {
            return response()->json([
                'success' => false,
                'message' => 'Số điện thoại này đã được đăng ký',
            ], 409);
        }

        try {
            // Create user
            $user = User::create([
                'name' => $request->name,
                'phone' => $phone,
                'email' => null, // Phone-based registration doesn't require email
                'password' => Hash::make($request->password),
                'preferences' => [
                    'sports' => $request->preferred_sports ?? [],
                    'language' => 'vi',
                    'locale' => 'vi_VN',
                ],
                'status' => 'active',
                'phone_verified_at' => now(), // Firebase already verified
            ]);

            // Create API token
            $token = $user->createToken('mobile-app')->plainTextToken;

            return response()->json([
                'success' => true,
                'message' => 'Đăng ký thành công',
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'phone' => $user->phone,
                    'phone_verified' => true,
                    'preferences' => $user->preferences,
                    'created_at' => $user->created_at,
                ],
                'token' => $token,
            ], 201);

        } catch (\Exception $e) {
            // Log the actual error for debugging
            Log::error('User registration failed', [
                'phone' => $phone,
                'verification_id' => $request->verification_id,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'success' => false,
                'message' => 'Không thể tạo tài khoản. Vui lòng thử lại.',
                'debug' => app()->environment('local') ? $e->getMessage() : null,
            ], 500);
        }
    }

    /**
     * Login user with phone and password
     */
    public function login(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'phone' => [
                'required',
                'string',
                new VietnamesePhoneRule(),
            ],
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $validator->errors()
            ], 422);
        }

        $phone = User::formatVietnamesePhone($request->phone);
        
        $user = User::findByPhone($phone);

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Số điện thoại hoặc mật khẩu không đúng',
            ], 401);
        }

        if (!$user->isPhoneVerified()) {
            return response()->json([
                'success' => false,
                'message' => 'Số điện thoại chưa được xác thực',
            ], 403);
        }

        if ($user->status !== 'active') {
            return response()->json([
                'success' => false,
                'message' => 'Tài khoản đã bị vô hiệu hóa',
            ], 403);
        }

        // Revoke existing tokens for security
        $user->tokens()->delete();

        // Create new token with 7-day expiration
        $token = $user->createToken('mobile-app', ['*'], now()->addDays(7))->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Đăng nhập thành công',
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'phone' => $user->phone,
                'phone_verified' => $user->isPhoneVerified(),
                'preferred_sports' => $user->preferred_sports,
                'preferences' => $user->preferences,
            ],
            'token' => $token,
            'expires_in' => 7 * 24 * 60 * 60, // 7 days in seconds
        ]);
    }

    /**
     * Logout user (revoke token)
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
     * Get authenticated user information
     */
    public function me(Request $request): JsonResponse
    {
        $user = $request->user();

        return response()->json([
            'success' => true,
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'phone' => $user->phone,
                'phone_verified' => $user->isPhoneVerified(),
                'email' => $user->email,
                'preferred_sports' => $user->preferred_sports,
                'preferences' => $user->preferences,
                'created_at' => $user->created_at,
            ],
        ]);
    }

    /**
     * Refresh authentication token
     */
    public function refresh(Request $request): JsonResponse
    {
        $user = $request->user();

        // Revoke current token
        $request->user()->currentAccessToken()->delete();

        // Create new token with 7-day expiration
        $token = $user->createToken('mobile-app', ['*'], now()->addDays(7))->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Token đã được làm mới',
            'token' => $token,
            'expires_in' => 7 * 24 * 60 * 60, // 7 days in seconds
        ]);
    }
}