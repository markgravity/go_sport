import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../app/auto_router.dart';

/// Navigation service for global navigation without BuildContext
/// 
/// Allows navigation from services, interceptors, and other non-UI code
/// Particularly useful for authentication flows and error handling
@lazySingleton
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  /// Get the current router
  StackRouter? get router {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return context.router;
    }
    return null;
  }
  
  /// Navigate to login screen and clear navigation stack
  Future<void> navigateToLoginAndClearStack() async {
    final currentRouter = router;
    if (currentRouter != null) {
      // Clear all routes and navigate to login
      await currentRouter.pushAndClearStack(const LoginRoute());
    }
  }
  
  /// Navigate to login screen
  Future<void> navigateToLogin() async {
    final currentRouter = router;
    if (currentRouter != null) {
      await currentRouter.push(const LoginRoute());
    }
  }
  
  /// Navigate to groups screen
  Future<void> navigateToGroups() async {
    final currentRouter = router;
    if (currentRouter != null) {
      await currentRouter.push(const GroupsListRoute());
    }
  }
  
  /// Show snackbar with Vietnamese message
  void showSnackBar(String message, {Color? backgroundColor}) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor ?? Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }
  
  /// Check if currently on login screen
  bool get isOnLoginScreen {
    final context = navigatorKey.currentContext;
    if (context != null) {
      final route = ModalRoute.of(context);
      return route?.settings.name == '/login';
    }
    return false;
  }
}