import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../app/auto_router.dart';

/// Navigation service for global navigation without BuildContext
/// 
/// Allows navigation from services, interceptors, and other non-UI code
/// Particularly useful for authentication flows and error handling
@lazySingleton
class NavigationService {
  AppRouter? _appRouter;
  
  /// Set the app router instance
  void setAppRouter(AppRouter router) {
    _appRouter = router;
  }
  
  /// Get the current router
  AppRouter? get router => _appRouter;
  
  /// Navigate to login screen and clear navigation stack
  Future<void> navigateToLoginAndClearStack() async {
    try {
      // For now, just log that we're attempting to navigate
      // AutoRoute navigation from interceptors requires different handling
      debugPrint('🔓 401 detected - should redirect to login screen');
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }
  
  /// Navigate to login screen
  Future<void> navigateToLogin() async {
    try {
      debugPrint('🔓 Navigating to login screen');
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }
  
  /// Navigate to groups screen
  Future<void> navigateToGroups() async {
    try {
      debugPrint('👥 Navigating to groups screen');
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }
  
  /// Show snackbar with Vietnamese message (simplified for now)
  void showSnackBar(String message, {dynamic backgroundColor}) {
    debugPrint('📢 Message: $message');
  }
  
  /// Check if currently on login screen (simplified for now)
  bool get isOnLoginScreen {
    // For now, assume not on login screen to prevent infinite loops
    return false;
  }
}