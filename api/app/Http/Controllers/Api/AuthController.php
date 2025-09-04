<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\PhoneVerification;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class AuthController extends Controller
{
    /**
     * Send SMS verification code for phone registration
     */
    public function sendVerificationCode(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'phone' => [
                'required',
                'string',
                'regex:/^(\+84|84|0)[3-9][0-9]{8}$/', // Vietnamese phone format
            ]
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Số điện thoại không hợp lệ',
                'errors' => $validator->errors()
            ], 422);
        }

        $phone = User::formatVietnamesePhone($request->phone);

        // Check rate limiting (max 3 attempts per 15 minutes)
        $recentAttempts = PhoneVerification::getRecentAttemptsForPhone($phone, 15);
        if ($recentAttempts >= 3) {
            return response()->json([
                'success' => false,
                'message' => 'Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau 15 phút.',
            ], 429);
        }

        // Check if phone is already registered
        $existingUser = User::where('phone', $phone)->first();
        if ($existingUser && $existingUser->isPhoneVerified()) {
            return response()->json([
                'success' => false,
                'message' => 'Số điện thoại này đã được đăng ký',
            ], 409);
        }

        try {
            // Create verification record
            $verification = PhoneVerification::createForPhone($phone, $request->ip());

            // TODO: Send SMS via Vietnamese SMS provider
            // For now, we'll just return the code in development
            $smsCode = app()->environment('local') ? $verification->code : null;

            return response()->json([
                'success' => true,
                'message' => 'Mã xác thực đã được gửi đến số điện thoại của bạn',
                'expires_in' => 300, // 5 minutes
                'development_code' => $smsCode, // Remove in production
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Không thể gửi mã xác thực. Vui lòng thử lại.',
            ], 500);
        }
    }

    /**
     * Register user with phone verification
     */
    public function register(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'phone' => [
                'required',
                'string',
                'regex:/^(\+84|84|0)[3-9][0-9]{8}$/',
            ],
            'verification_code' => 'required|string|size:6',
            'name' => 'required|string|max:255',
            'password' => 'required|string|min:8|confirmed',
            'preferred_sports' => 'array',
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

        // Verify the SMS code
        $verification = PhoneVerification::where('phone', $phone)
            ->where('code', $request->verification_code)
            ->first();

        if (!$verification) {
            return response()->json([
                'success' => false,
                'message' => 'Mã xác thực không hợp lệ',
            ], 422);
        }

        if (!$verification->isValid()) {
            $verification->incrementAttempts();
            
            if ($verification->expires_at->isPast()) {
                $message = 'Mã xác thực đã hết hạn';
            } else {
                $message = 'Mã xác thực không đúng';
            }

            return response()->json([
                'success' => false,
                'message' => $message,
            ], 422);
        }

        // Check if user already exists
        $existingUser = User::where('phone', $phone)->first();
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
                ],
                'status' => 'active',
            ]);

            // Mark phone as verified
            $user->markPhoneAsVerified();
            
            // Mark verification as used
            $verification->markAsVerified();

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
                ],
                'token' => $token,
            ], 201);

        } catch (\Exception $e) {
            // Log the actual error for debugging
            \Log::error('User registration failed', [
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
                'regex:/^(\+84|84|0)[3-9][0-9]{8}$/',
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
        
        $user = User::where('phone', $phone)->first();

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

        // Create new token
        $token = $user->createToken('mobile-app')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Đăng nhập thành công',
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'phone' => $user->phone,
                'phone_verified' => $user->isPhoneVerified(),
                'preferences' => $user->preferences,
            ],
            'token' => $token,
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
                'preferences' => $user->preferences,
                'created_at' => $user->created_at,
            ],
        ]);
    }
}