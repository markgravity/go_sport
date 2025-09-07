import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Authentication interceptor that automatically adds Bearer tokens to requests
/// 
/// This interceptor:
/// - Adds stored auth tokens to protected API requests
/// - Skips token for public endpoints (auth, health, etc.)
/// - Handles token refresh on 401 responses
/// - Provides Vietnamese error messages
class AuthInterceptor extends Interceptor {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  static const String _tokenKey = 'auth_token';
  
  // Public endpoints that don't need authentication
  static const List<String> _publicEndpoints = [
    '/health',
    '/auth/login',
    '/auth/register',
    '/auth/send-verification-code',
    '/auth/password-reset-request',
    '/auth/password-reset-confirm',
    '/auth/firebase/authenticate',
    '/auth/firebase/status',
    '/sports',
    '/images/default-avatars',
  ];
  
  // Note: /groups endpoints ARE protected and require authentication

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Check if this endpoint needs authentication
    final needsAuth = !_isPublicEndpoint(options.path);
    
    if (needsAuth) {
      // Get stored token
      final token = await _storage.read(key: _tokenKey);
      
      if (token != null && token.isNotEmpty) {
        // Add Bearer token to headers
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized responses
    if (err.response?.statusCode == 401) {
      // Token refresh failed or no token - clear auth data
      await _clearAuthData();
      
      // Return Vietnamese error message
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
          type: DioExceptionType.badResponse,
        ),
      );
    }
    
    super.onError(err, handler);
  }

  /// Check if endpoint is public (doesn't need authentication)
  bool _isPublicEndpoint(String path) {
    for (final publicPath in _publicEndpoints) {
      if (path.startsWith(publicPath)) {
        return true;
      }
    }
    return false;
  }


  /// Clear all authentication data
  Future<void> _clearAuthData() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: 'user_data');
    await _storage.delete(key: 'biometric_enabled');
    await _storage.delete(key: 'biometric_phone');
  }
}