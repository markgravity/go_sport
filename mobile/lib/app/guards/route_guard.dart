import 'package:flutter/material.dart';

import '../../core/dependency_injection/injection_container.dart';

/// Base class for route guards
/// 
/// Provides common functionality for protecting routes based on authentication state
abstract class RouteGuard {
  /// Check if navigation should be allowed
  bool shouldAllowNavigation(BuildContext context);
  
  /// Get the redirect route if navigation is not allowed
  String? getRedirectRoute(BuildContext context);
}

/// Guard to protect routes that require authentication
/// 
/// Checks if user is logged in, redirects to login if not
/// Uses AuthCubit to check authentication state
class AuthGuard extends RouteGuard {
  @override
  bool shouldAllowNavigation(BuildContext context) {
    try {
      // Try to get AuthCubit from GetIt (fallback approach)
      final authCubit = getIt.createAuthCubit();
      final isAuthenticated = authCubit.isAuthenticated;
      authCubit.close(); // Clean up temporary instance
      return isAuthenticated;
    } catch (e) {
      // If we can't check auth state, assume not authenticated
      return false;
    }
  }

  @override
  String? getRedirectRoute(BuildContext context) {
    if (!shouldAllowNavigation(context)) {
      return '/login';
    }
    return null;
  }
}

/// Guard to protect routes for authenticated users only
/// 
/// Prevents authenticated users from accessing auth screens
/// Redirects authenticated users to home screen
class GuestOnlyGuard extends RouteGuard {
  @override
  bool shouldAllowNavigation(BuildContext context) {
    try {
      // Try to get AuthCubit from GetIt (fallback approach)
      final authCubit = getIt.createAuthCubit();
      final isAuthenticated = authCubit.isAuthenticated;
      authCubit.close(); // Clean up temporary instance
      return !isAuthenticated; // Allow only if NOT authenticated
    } catch (e) {
      // If we can't check auth state, assume not authenticated (allow)
      return true;
    }
  }

  @override
  String? getRedirectRoute(BuildContext context) {
    if (!shouldAllowNavigation(context)) {
      return '/'; // Redirect to home
    }
    return null;
  }
}

/// Helper extension to apply guards to routes
extension RouteGuardExtension on RouteGuard {
  /// Apply the guard to a widget builder
  Widget guardedWidget(
    BuildContext context,
    Widget Function(BuildContext) builder,
  ) {
    if (shouldAllowNavigation(context)) {
      return builder(context);
    } else {
      final redirectRoute = getRedirectRoute(context);
      if (redirectRoute != null) {
        // Schedule navigation for next frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(redirectRoute);
        });
      }
      
      // Show loading while redirecting
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}