import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/auth_tokens.dart';
import 'api_service.dart';

class PhoneAuthService {
  final ApiService _apiService = ApiService();

  // Vietnamese phone number regex pattern
  static final RegExp _vietnamesePhoneRegex = RegExp(r'^(\+84|84|0)[3-9][0-9]{8}$');

  // Format phone number to Vietnamese standard (+84)
  static String formatVietnamesePhone(String phone) {
    // Remove all non-numeric characters
    phone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Convert 0x format to +84x format
    if (phone.startsWith('0')) {
      phone = '84${phone.substring(1)}';
    }
    
    // Add + prefix if not present
    if (!phone.startsWith('+')) {
      phone = '+$phone';
    }
    
    return phone;
  }

  // Format phone number for display
  static String formatPhoneForDisplay(String phone) {
    final formatted = formatVietnamesePhone(phone);
    if (formatted.startsWith('+84')) {
      final number = formatted.substring(3);
      if (number.length >= 9) {
        return '+84 ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6)}';
      }
    }
    return formatted;
  }

  // Validate Vietnamese phone number
  bool isValidVietnamesePhone(String phone) {
    final formatted = formatVietnamesePhone(phone);
    return _vietnamesePhoneRegex.hasMatch(formatted);
  }

  // Send SMS verification code
  Future<void> sendVerificationCode({
    required String phoneNumber,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      if (!isValidVietnamesePhone(phoneNumber)) {
        onError('Số điện thoại không đúng định dạng Việt Nam');
        return;
      }

      final formattedPhone = formatVietnamesePhone(phoneNumber);
      
      final response = await _apiService.sendVerificationCode(
        phone: formattedPhone,
      );

      if (response['success'] == true) {
        final message = response['message'] as String? ?? 'Mã xác thực đã được gửi';
        final expiresIn = response['expires_in'] as int? ?? 300;
        final developmentCode = response['development_code'] as String?;
        
        String successMessage = '$message (${expiresIn ~/ 60} phút)';
        if (kDebugMode && developmentCode != null) {
          successMessage += '\nMã phát triển: $developmentCode';
        }
        
        onSuccess(successMessage);
      } else {
        onError(response['message'] as String? ?? 'Không thể gửi mã xác thực');
      }
    } catch (e) {
      debugPrint('Send verification code error: $e');
      if (e is ApiException) {
        onError(e.vietnameseMessage);
      } else {
        onError('Không thể gửi mã xác thực. Vui lòng thử lại');
      }
    }
  }

  // Register user with phone verification
  Future<UserModel> registerUser({
    required String phoneNumber,
    required String verificationCode,
    required String name,
    required String password,
    List<String>? preferredSports,
  }) async {
    try {
      final formattedPhone = formatVietnamesePhone(phoneNumber);
      
      final response = await _apiService.registerWithPhone(
        phone: formattedPhone,
        verificationCode: verificationCode,
        name: name,
        password: password,
        preferredSports: preferredSports,
      );

      if (response['success'] == true) {
        final userData = response['user'] as Map<String, dynamic>;
        final token = response['token'] as String;
        
        // Create user model
        final user = UserModel.fromJson(userData);
        
        // Store auth tokens (you might want to use secure storage)
        final authTokens = AuthTokens(
          firebaseIdToken: '', // Not using Firebase
          laravelToken: token,
          firebaseUid: user.id.toString(), // Use user ID as UID
          expiresAt: DateTime.now().add(const Duration(days: 30)), // 30 days default
        );
        
        // Store tokens in secure storage or state management
        await _storeAuthTokens(authTokens);
        
        return user;
      } else {
        throw Exception(response['message'] ?? 'Registration failed');
      }
    } catch (e) {
      debugPrint('Register user error: $e');
      if (e is ApiException) {
        throw Exception(e.vietnameseMessage);
      } else {
        throw Exception('Không thể tạo tài khoản. Vui lòng thử lại');
      }
    }
  }

  // Login user with phone and password
  Future<UserModel> loginUser({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final formattedPhone = formatVietnamesePhone(phoneNumber);
      
      final response = await _apiService.loginWithPhone(
        phone: formattedPhone,
        password: password,
      );

      if (response['success'] == true) {
        final userData = response['user'] as Map<String, dynamic>;
        final token = response['token'] as String;
        
        // Create user model
        final user = UserModel.fromJson(userData);
        
        // Store auth tokens
        final authTokens = AuthTokens(
          firebaseIdToken: '', // Not using Firebase
          laravelToken: token,
          firebaseUid: user.id.toString(), // Use user ID as UID
          expiresAt: DateTime.now().add(const Duration(days: 30)), // 30 days default
        );
        
        await _storeAuthTokens(authTokens);
        
        return user;
      } else {
        throw Exception(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      debugPrint('Login user error: $e');
      if (e is ApiException) {
        throw Exception(e.vietnameseMessage);
      } else {
        throw Exception('Không thể đăng nhập. Vui lòng thử lại');
      }
    }
  }

  // Get current authenticated user
  Future<UserModel?> getCurrentUser() async {
    try {
      final authTokens = await _getStoredAuthTokens();
      if (authTokens == null) return null;
      
      final response = await _apiService.authenticatedRequest(
        method: 'GET',
        endpoint: '/auth/me',
        laravelToken: authTokens.laravelToken,
      );

      if (response['success'] == true) {
        final userData = response['user'] as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      }
      
      return null;
    } catch (e) {
      debugPrint('Get current user error: $e');
      return null;
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      final authTokens = await _getStoredAuthTokens();
      if (authTokens != null) {
        await _apiService.authenticatedRequest(
          method: 'POST',
          endpoint: '/auth/logout',
          laravelToken: authTokens.laravelToken,
        );
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      // Always clear local tokens
      await _clearAuthTokens();
    }
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final authTokens = await _getStoredAuthTokens();
    return authTokens != null;
  }

  // Private methods for token storage (implement with flutter_secure_storage)
  Future<void> _storeAuthTokens(AuthTokens tokens) async {
    // TODO: Implement secure token storage
    debugPrint('Storing auth tokens: ${tokens.laravelToken}');
  }

  Future<AuthTokens?> _getStoredAuthTokens() async {
    // TODO: Implement secure token retrieval
    return null;
  }

  Future<void> _clearAuthTokens() async {
    // TODO: Implement secure token clearing
    debugPrint('Clearing auth tokens');
  }

  // Vietnamese sports list for registration
  static const List<String> vietnameseSportsList = [
    'Bóng đá',
    'Bóng chuyền',
    'Bóng rổ',
    'Cầu lông',
    'Tennis',
    'Bóng bàn',
    'Bơi lội',
    'Chạy bộ',
    'Đạp xe',
    'Yoga',
    'Gym/Thể hình',
    'Võ thuật',
    'Golf',
    'Billiards',
    'Bowling',
  ];
}