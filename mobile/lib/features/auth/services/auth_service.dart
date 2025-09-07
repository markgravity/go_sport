import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/network/api_client.dart';
import '../models/user_model.dart';

@injectable
class AuthService {
  final ApiClient _apiClient;
  
  AuthService(this._apiClient);
  
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
}