import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApiService {
  // TODO: Move to environment configuration
  static const String _baseUrl = kDebugMode
      ? 'http://localhost:8000/api' // Development
      : 'https://api.gosport.vn/api'; // Production

  static const Duration _timeout = Duration(seconds: 30);

  // HTTP headers for JSON requests
  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // HTTP headers with authentication
  Map<String, String> _headersWithAuth(String token) => {
        ..._defaultHeaders,
        'Authorization': 'Bearer $token',
      };

  // Generic HTTP request handler
  Future<Map<String, dynamic>> _makeRequest({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final requestHeaders = headers ?? _defaultHeaders;

      debugPrint('$method $uri');
      if (body != null) {
        debugPrint('Request body: ${jsonEncode(body)}');
      }

      late http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response =
              await http.get(uri, headers: requestHeaders).timeout(_timeout);
          break;
        case 'POST':
          response = await http
              .post(
                uri,
                headers: requestHeaders,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(_timeout);
          break;
        case 'PUT':
          response = await http
              .put(
                uri,
                headers: requestHeaders,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(_timeout);
          break;
        case 'DELETE':
          response =
              await http.delete(uri, headers: requestHeaders).timeout(_timeout);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseData;
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: responseData['message'] as String? ?? 'Unknown error',
          errors: responseData['errors'] as Map<String, dynamic>?,
        );
      }
    } catch (e) {
      debugPrint('API request error: $e');
      if (e is ApiException) {
        rethrow;
      } else {
        throw ApiException(
          statusCode: 0,
          message: e.toString(),
        );
      }
    }
  }

  // Check Firebase service status
  Future<Map<String, dynamic>> checkFirebaseStatus() async {
    return _makeRequest(
      method: 'GET',
      endpoint: '/auth/firebase/status',
    );
  }

  // Authenticate with Firebase ID token
  Future<Map<String, dynamic>> authenticateWithFirebase({
    required String idToken,
    String? name,
    List<String>? preferredSports,
  }) async {
    final body = <String, dynamic>{
      'id_token': idToken,
    };

    if (name != null && name.isNotEmpty) {
      body['name'] = name;
    }

    if (preferredSports != null && preferredSports.isNotEmpty) {
      body['preferred_sports'] = preferredSports;
    }

    return _makeRequest(
      method: 'POST',
      endpoint: '/auth/firebase/authenticate',
      body: body,
    );
  }

  // Get authenticated user info
  Future<Map<String, dynamic>> getCurrentUser(String laravelToken) async {
    return _makeRequest(
      method: 'GET',
      endpoint: '/auth/firebase/me',
      headers: _headersWithAuth(laravelToken),
    );
  }

  // Logout user
  Future<Map<String, dynamic>> logout(String laravelToken) async {
    return _makeRequest(
      method: 'POST',
      endpoint: '/auth/firebase/logout',
      headers: _headersWithAuth(laravelToken),
    );
  }

  // Delete Firebase account
  Future<Map<String, dynamic>> deleteFirebaseAccount({
    required String idToken,
  }) async {
    // This requires a Laravel token, so we need to authenticate first
    // or handle it differently in the backend
    return _makeRequest(
      method: 'DELETE',
      endpoint: '/auth/firebase/delete-account',
      body: {'id_token': idToken},
    );
  }

  // Health check endpoint
  Future<Map<String, dynamic>> healthCheck() async {
    return _makeRequest(
      method: 'GET',
      endpoint: '/api/health',
    );
  }

  // Generic authenticated API call
  Future<Map<String, dynamic>> authenticatedRequest({
    required String method,
    required String endpoint,
    required String laravelToken,
    Map<String, dynamic>? body,
  }) async {
    return _makeRequest(
      method: method,
      endpoint: endpoint,
      body: body,
      headers: _headersWithAuth(laravelToken),
    );
  }

  // Update user profile
  Future<Map<String, dynamic>> updateUserProfile({
    required String laravelToken,
    String? name,
    List<String>? preferredSports,
    Map<String, dynamic>? preferences,
  }) async {
    final body = <String, dynamic>{};

    if (name != null) body['name'] = name;
    if (preferredSports != null) body['preferred_sports'] = preferredSports;
    if (preferences != null) body['preferences'] = preferences;

    return authenticatedRequest(
      method: 'PUT',
      endpoint: '/user/profile',
      laravelToken: laravelToken,
      body: body,
    );
  }

  // Test API connectivity
  Future<bool> testConnection() async {
    try {
      await healthCheck();
      return true;
    } catch (e) {
      debugPrint('API connectivity test failed: $e');
      return false;
    }
  }

  // Phone-based registration methods

  // Send SMS verification code
  Future<Map<String, dynamic>> sendVerificationCode({
    required String phone,
  }) async {
    return _makeRequest(
      method: 'POST',
      endpoint: '/auth/send-verification-code',
      body: {'phone': phone},
    );
  }

  // Register user with phone verification
  Future<Map<String, dynamic>> registerWithPhone({
    required String phone,
    required String verificationCode,
    required String name,
    required String password,
    List<String>? preferredSports,
  }) async {
    final body = <String, dynamic>{
      'phone': phone,
      'verification_code': verificationCode,
      'name': name,
      'password': password,
      'password_confirmation': password,
    };

    if (preferredSports != null && preferredSports.isNotEmpty) {
      body['preferred_sports'] = preferredSports;
    }

    return _makeRequest(
      method: 'POST',
      endpoint: '/auth/register',
      body: body,
    );
  }

  // Login with phone and password
  Future<Map<String, dynamic>> loginWithPhone({
    required String phone,
    required String password,
  }) async {
    return _makeRequest(
      method: 'POST',
      endpoint: '/auth/login',
      body: {
        'phone': phone,
        'password': password,
      },
    );
  }

  // Check if API is Firebase-enabled
  Future<bool> isFirebaseEnabled() async {
    try {
      final status = await checkFirebaseStatus();
      return status['firebase_configured'] as bool? ?? false;
    } catch (e) {
      debugPrint('Firebase status check failed: $e');
      return false;
    }
  }
}

// Custom exception for API errors
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? errors;

  ApiException({
    required this.statusCode,
    required this.message,
    this.errors,
  });

  @override
  String toString() {
    String result = 'ApiException($statusCode): $message';
    if (errors != null && errors!.isNotEmpty) {
      result += '\nErrors: ${jsonEncode(errors)}';
    }
    return result;
  }

  // Get user-friendly error message in Vietnamese
  String get vietnameseMessage {
    switch (statusCode) {
      case 400:
        return 'Dữ liệu gửi lên không hợp lệ';
      case 401:
        return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại';
      case 403:
        return 'Bạn không có quyền thực hiện thao tác này';
      case 404:
        return 'Không tìm thấy thông tin yêu cầu';
      case 422:
        return message.isNotEmpty ? message : 'Dữ liệu không hợp lệ';
      case 429:
        return 'Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau';
      case 500:
        return 'Lỗi hệ thống. Vui lòng thử lại sau';
      case 0:
        return 'Không thể kết nối đến máy chủ. Kiểm tra kết nối mạng';
      default:
        return message.isNotEmpty ? message : 'Có lỗi xảy ra. Vui lòng thử lại';
    }
  }

  // Get validation errors for form fields
  Map<String, List<String>> get validationErrors {
    if (errors == null) return {};

    final Map<String, List<String>> result = {};
    errors!.forEach((key, value) {
      if (value is List) {
        result[key] = value.cast<String>();
      } else if (value is String) {
        result[key] = [value];
      }
    });

    return result;
  }
}
