import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/network/api_client.dart';
import '../models/user_model.dart';

@injectable
class AuthService {
  final ApiClient _apiClient;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  AuthService(this._apiClient);
  
  // Vietnamese phone number format validation
  static final RegExp _vietnamesePhoneRegex = 
      RegExp(r'^(\+84|84|0)[3-9][0-9]{8}$');
  
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _biometricPhoneKey = 'biometric_phone';
  
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Format Vietnamese phone number to +84 format
  String formatVietnamesePhone(String phone) {
    // Remove all non-digit characters
    String digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    // Handle different Vietnamese phone formats
    if (digitsOnly.startsWith('0') && digitsOnly.length == 10) {
      // 0xxxxxxxxx -> +84xxxxxxxxx
      return '+84${digitsOnly.substring(1)}';
    } else if (digitsOnly.startsWith('84') && digitsOnly.length == 11) {
      // 84xxxxxxxxx -> +84xxxxxxxxx
      return '+$digitsOnly';
    } else if (digitsOnly.startsWith('84') && digitsOnly.length == 12) {
      // +84xxxxxxxxx (already correct format)
      return '+$digitsOnly';
    }
    
    // Return as-is if format doesn't match expected patterns
    return phone;
  }

  // Validate Vietnamese phone number
  bool isValidVietnamesePhone(String phone) {
    return _vietnamesePhoneRegex.hasMatch(phone);
  }

  /// Login with phone and password
  Future<void> login({
    required String phoneNumber,
    required String password,
    bool rememberMe = false,
    required Function(UserModel user, String message) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      if (kDebugMode) {
        print('AuthService.login called with phone: $phoneNumber');
        print('Using ApiClient for login request');
      }

      final response = await _apiClient.post(
        '/auth/login',
        data: {
          'phone': phoneNumber,
          'password': password,
        },
      );

      if (kDebugMode) {
        print('Login response status: ${response.statusCode}');
        print('Login response data: ${response.data}');
      }

      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 && data['success'] == true) {
        // Store authentication data
        await _storeAuthData(data['token'], data['user']);
        
        // Enable biometric login if remember me is checked
        if (rememberMe) {
          await _enableBiometricLogin(phoneNumber);
        }
        
        final user = UserModel.fromJson(data['user']);
        onSuccess(user, data['message'] ?? 'Đăng nhập thành công');
      } else {
        onError(data['message'] ?? 'Đăng nhập thất bại');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      onError('Lỗi kết nối mạng. Vui lòng thử lại.');
    }
  }

  /// Login with biometric authentication
  Future<void> loginWithBiometric({
    required Function(UserModel user, String message) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      // Check if biometric is enabled
      final isBiometricEnabled = await isBiometricLoginEnabled();
      if (!isBiometricEnabled) {
        onError('Xác thực sinh trắc học chưa được thiết lập');
        return;
      }

      // Check biometric availability
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        onError('Thiết bị không hỗ trợ xác thực sinh trắc học');
        return;
      }

      // Perform biometric authentication
      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Xác thực để đăng nhập vào Go Sport',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (isAuthenticated) {
        // Get stored token and validate
        final token = await _storage.read(key: _tokenKey);
        if (token != null) {
          final userJson = await _storage.read(key: _userKey);
          if (userJson != null) {
            final user = UserModel.fromJson(jsonDecode(userJson));
            onSuccess(user, 'Đăng nhập thành công');
            return;
          }
        }
        
        onError('Token không hợp lệ. Vui lòng đăng nhập lại.');
      } else {
        onError('Xác thực sinh trắc học thất bại');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Biometric login error: $e');
      }
      onError('Lỗi xác thực sinh trắc học');
    }
  }

  /// Logout user
  Future<void> logout({
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      final token = await getAuthToken();
      if (token != null) {
        // Call logout API
        try {
          await _apiClient.post(
            '/auth/logout',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          );
        } catch (e) {
          if (kDebugMode) {
            print('Logout API error: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Logout API error: $e');
      }
    } finally {
      // Always clear local data
      await clearAuthData();
      onSuccess?.call();
    }
  }

  /// Refresh authentication token
  Future<bool> refreshToken() async {
    try {
      final token = await getAuthToken();
      if (token == null) return false;

      final response = await _apiClient.post(
        '/auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 && data['success'] == true) {
        // Store new token
        await _storage.write(key: _tokenKey, value: data['token']);
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Token refresh error: $e');
      }
    }
    
    return false;
  }

  /// Get current authenticated user
  Future<UserModel?> getCurrentUser() async {
    try {
      final userJson = await _storage.read(key: _userKey);
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Get current user error: $e');
      }
    }
    return null;
  }

  /// Get authentication token
  Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getAuthToken();
    return token != null;
  }

  /// Check if biometric login is enabled
  Future<bool> isBiometricLoginEnabled() async {
    final enabled = await _storage.read(key: _biometricEnabledKey);
    return enabled == 'true';
  }

  /// Enable biometric login
  Future<void> _enableBiometricLogin(String phoneNumber) async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (isAvailable) {
        await _storage.write(key: _biometricEnabledKey, value: 'true');
        await _storage.write(key: _biometricPhoneKey, value: phoneNumber);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Enable biometric login error: $e');
      }
    }
  }

  /// Disable biometric login
  Future<void> disableBiometricLogin() async {
    await _storage.delete(key: _biometricEnabledKey);
    await _storage.delete(key: _biometricPhoneKey);
  }

  /// Store authentication data
  Future<void> _storeAuthData(String token, Map<String, dynamic> userData) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _userKey, value: jsonEncode(userData));
  }

  /// Clear all authentication data
  Future<void> clearAuthData() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
    await _storage.delete(key: _biometricEnabledKey);
    await _storage.delete(key: _biometricPhoneKey);
  }

  /// Check biometric capabilities
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      if (kDebugMode) {
        print('Get available biometrics error: $e');
      }
      return [];
    }
  }

  /// Send SMS verification code - returns verification ID or throws exception
  Future<String> sendSMSVerification({
    required String phoneNumber,
    Function(PhoneAuthCredential credential)? onAutoVerify,
  }) async {
    final formattedPhone = formatVietnamesePhone(phoneNumber);
    
    if (!isValidVietnamesePhone(formattedPhone)) {
      throw FirebaseAuthException(
        code: 'invalid-phone-number',
        message: 'Số điện thoại không đúng định dạng Việt Nam',
      );
    }

    // Use a Completer to convert callback-based API to Future-based
    final completer = Completer<String>();
    
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) {
          debugPrint('Phone verification completed automatically');
          if (onAutoVerify != null) {
            onAutoVerify(credential);
          }
          // For auto-verification, we complete with a special identifier
          if (!completer.isCompleted) {
            completer.complete('auto-verified:${credential.verificationId ?? 'instant'}');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('Phone verification failed: ${e.code} - ${e.message}');
          if (!completer.isCompleted) {
            completer.completeError(e);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint('SMS code sent to $formattedPhone');
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('Code auto-retrieval timeout');
          // Don't complete here as this is just a timeout notification
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      debugPrint('SMS verification error: $e');
      if (!completer.isCompleted) {
        if (e is FirebaseAuthException) {
          completer.completeError(e);
        } else {
          completer.completeError(FirebaseAuthException(
            code: 'unknown',
            message: e.toString(),
          ));
        }
      }
    }

    return completer.future;
  }

  /// Register with Firebase SMS verification and API call
  Future<UserModel> register({
    required String phoneNumber,
    required String name,
    required String password,
    required String smsCode,
    List<String>? preferredSports,
    String? verificationId,
  }) async {
    try {
      // Step 1: Get verification ID (either provided or generate new one)
      String actualVerificationId;
      if (verificationId != null && verificationId.isNotEmpty) {
        actualVerificationId = verificationId;
      } else {
        // Generate new verification ID by sending SMS
        actualVerificationId = await sendSMSVerification(phoneNumber: phoneNumber);
      }
      
      // Step 2: Call backend registration API
      final response = await _apiClient.post(
        '/auth/register',
        data: {
          'name': name,
          'phone': phoneNumber,
          'password': password,
          'password_confirmation': password,
          'verification_id': actualVerificationId,
          'sms_code': smsCode,
          'preferred_sports': preferredSports ?? [],
        },
      );

      final data = response.data as Map<String, dynamic>;
      
      if (response.statusCode == 201 && data['success'] == true) {
        // Store authentication data
        await _storeAuthData(data['token'], data['user']);
        
        return UserModel.fromJson(data['user']);
      } else {
        throw Exception(data['message'] ?? 'Registration failed');
      }
    } catch (e) {
      debugPrint('Registration error: $e');
      rethrow;
    }
  }
}