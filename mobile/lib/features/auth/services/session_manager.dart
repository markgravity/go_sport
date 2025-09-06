import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_service.dart';

class SessionManager {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _lastActivityKey = 'last_activity';
  static const String _sessionTimeoutKey = 'session_timeout';
  static const int _defaultTimeoutMinutes = 30; // 30 minutes default timeout
  
  final AuthService _authService = AuthService();
  Timer? _sessionTimer;
  Timer? _refreshTimer;
  
  // Session timeout callbacks
  Function()? onSessionTimeout;
  Function()? onSessionWarning;
  
  /// Initialize session manager with timeout settings
  void initialize({
    Function()? onTimeout,
    Function()? onWarning,
    int timeoutMinutes = _defaultTimeoutMinutes,
  }) {
    onSessionTimeout = onTimeout;
    onSessionWarning = onWarning;
    
    _startSessionMonitoring(timeoutMinutes);
    _startTokenRefreshTimer();
  }

  /// Update last activity timestamp
  Future<void> updateLastActivity() async {
    final now = DateTime.now().millisecondsSinceEpoch.toString();
    await _storage.write(key: _lastActivityKey, value: now);
  }

  /// Check if session is expired
  Future<bool> isSessionExpired() async {
    final lastActivityStr = await _storage.read(key: _lastActivityKey);
    if (lastActivityStr == null) return true;

    final lastActivity = DateTime.fromMillisecondsSinceEpoch(int.parse(lastActivityStr));
    final timeoutStr = await _storage.read(key: _sessionTimeoutKey);
    final timeoutMinutes = timeoutStr != null ? int.parse(timeoutStr) : _defaultTimeoutMinutes;
    
    final now = DateTime.now();
    final timeSinceLastActivity = now.difference(lastActivity);
    
    return timeSinceLastActivity.inMinutes > timeoutMinutes;
  }

  /// Get remaining session time in minutes
  Future<int> getRemainingSessionTime() async {
    final lastActivityStr = await _storage.read(key: _lastActivityKey);
    if (lastActivityStr == null) return 0;

    final lastActivity = DateTime.fromMillisecondsSinceEpoch(int.parse(lastActivityStr));
    final timeoutStr = await _storage.read(key: _sessionTimeoutKey);
    final timeoutMinutes = timeoutStr != null ? int.parse(timeoutStr) : _defaultTimeoutMinutes;
    
    final now = DateTime.now();
    final timeSinceLastActivity = now.difference(lastActivity);
    final remainingTime = timeoutMinutes - timeSinceLastActivity.inMinutes;
    
    return remainingTime > 0 ? remainingTime : 0;
  }

  /// Extend session timeout
  Future<void> extendSession() async {
    await updateLastActivity();
    if (kDebugMode) {
      print('Session extended');
    }
  }

  /// Start session monitoring timer
  void _startSessionMonitoring(int timeoutMinutes) {
    _storage.write(key: _sessionTimeoutKey, value: timeoutMinutes.toString());
    
    // Check session every minute
    _sessionTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      final isExpired = await isSessionExpired();
      
      if (isExpired) {
        await _handleSessionTimeout();
        timer.cancel();
      } else {
        // Check if we should show warning (5 minutes before timeout)
        final remainingTime = await getRemainingSessionTime();
        if (remainingTime <= 5 && remainingTime > 0) {
          onSessionWarning?.call();
        }
      }
    });
  }

  /// Start automatic token refresh timer
  void _startTokenRefreshTimer() {
    // Refresh token every 6 days (tokens expire in 7 days)
    _refreshTimer = Timer.periodic(const Duration(days: 6), (timer) async {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        final refreshed = await _authService.refreshToken();
        if (!refreshed) {
          // Token refresh failed, logout user
          await _handleSessionTimeout();
          timer.cancel();
        }
      } else {
        timer.cancel();
      }
    });
  }

  /// Handle session timeout
  Future<void> _handleSessionTimeout() async {
    if (kDebugMode) {
      print('Session timeout - logging out user');
    }

    // Clear session data
    await _authService.clearAuthData();
    await _storage.delete(key: _lastActivityKey);
    
    // Stop timers
    _sessionTimer?.cancel();
    _refreshTimer?.cancel();
    
    // Notify app of timeout
    onSessionTimeout?.call();
  }

  /// Logout user with confirmation
  Future<void> logout({
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      // Stop timers
      _sessionTimer?.cancel();
      _refreshTimer?.cancel();
      
      // Call auth service logout
      await _authService.logout(
        onSuccess: () {
          _storage.delete(key: _lastActivityKey);
          _storage.delete(key: _sessionTimeoutKey);
          onSuccess?.call();
        },
        onError: onError,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
      onError?.call('Đăng xuất thất bại');
    }
  }

  /// Check if user needs to re-authenticate
  Future<bool> requiresReAuthentication() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (!isLoggedIn) return true;

    final isExpired = await isSessionExpired();
    return isExpired;
  }

  /// Get current session info
  Future<Map<String, dynamic>> getSessionInfo() async {
    final user = await _authService.getCurrentUser();
    final remainingTime = await getRemainingSessionTime();
    final lastActivityStr = await _storage.read(key: _lastActivityKey);
    
    DateTime? lastActivity;
    if (lastActivityStr != null) {
      lastActivity = DateTime.fromMillisecondsSinceEpoch(int.parse(lastActivityStr));
    }

    return {
      'user': user?.toJson(),
      'remainingTimeMinutes': remainingTime,
      'lastActivity': lastActivity?.toIso8601String(),
      'isLoggedIn': await _authService.isLoggedIn(),
      'isBiometricEnabled': await _authService.isBiometricLoginEnabled(),
    };
  }

  /// Set custom session timeout
  Future<void> setSessionTimeout(int minutes) async {
    await _storage.write(key: _sessionTimeoutKey, value: minutes.toString());
    
    // Restart monitoring with new timeout
    _sessionTimer?.cancel();
    _startSessionMonitoring(minutes);
  }

  /// Dispose of resources
  void dispose() {
    _sessionTimer?.cancel();
    _refreshTimer?.cancel();
  }
}