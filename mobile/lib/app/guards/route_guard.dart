import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';

/// Base class for route guards
/// 
/// Provides common functionality for protecting routes based on authentication state
abstract class RouteGuard {
  /// Check if navigation should be allowed
  bool shouldAllowNavigation(BuildContext context, WidgetRef ref);
  
  /// Get the redirect route if navigation is not allowed
  String? getRedirectRoute(BuildContext context, WidgetRef ref);
}

/// Guard để bảo vệ các route cần authentication
/// 
/// Kiểm tra user đã đăng nhập chưa, nếu chưa thì redirect về login
/// Sử dụng Riverpod provider hiện tại để check auth state
class AuthGuard extends RouteGuard {
  @override
  bool shouldAllowNavigation(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authProvider);
    return authState.isAuthenticated;
  }

  @override
  String? getRedirectRoute(BuildContext context, WidgetRef ref) {
    if (!shouldAllowNavigation(context, ref)) {
      return '/login';
    }
    return null;
  }
}

/// Guard để bảo vệ các route chỉ dành cho user chưa đăng nhập
/// 
/// Kiểm tra user đã đăng nhập chưa, nếu đã đăng nhập thì redirect về home
/// Sử dụng cho các trang login, register để tránh user đã login vào lại
class UnauthGuard extends RouteGuard {
  @override
  bool shouldAllowNavigation(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authProvider);
    return !authState.isAuthenticated;
  }

  @override
  String? getRedirectRoute(BuildContext context, WidgetRef ref) {
    if (!shouldAllowNavigation(context, ref)) {
      return '/';
    }
    return null;
  }
}

/// Utility methods for applying route guards
class RouteGuardUtil {
  /// Apply route guard to a navigation action
  static bool applyGuard({
    required BuildContext context,
    required WidgetRef ref,
    required RouteGuard guard,
    VoidCallback? onRedirect,
  }) {
    if (!guard.shouldAllowNavigation(context, ref)) {
      final redirectRoute = guard.getRedirectRoute(context, ref);
      if (redirectRoute != null) {
        Navigator.pushReplacementNamed(context, redirectRoute);
        onRedirect?.call();
      }
      return false;
    }
    return true;
  }
}

/// Route guard middleware template
/// 
/// This demonstrates how guards can be integrated with routing
/// In a full AutoRoute implementation, this would be more sophisticated
class RoutingMiddleware {
  static final _authGuard = AuthGuard();
  static final _unauthGuard = UnauthGuard();

  /// Check if route requires authentication
  static bool requiresAuth(String route) {
    const protectedRoutes = ['/profile', '/groups', '/settings'];
    return protectedRoutes.any((protected) => route.startsWith(protected));
  }

  /// Check if route is for unauthenticated users only
  static bool requiresUnauth(String route) {
    const unauthRoutes = ['/login', '/register'];
    return unauthRoutes.contains(route);
  }

  /// Apply appropriate guard to route
  static bool canNavigateTo({
    required String route,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    if (requiresAuth(route)) {
      return RouteGuardUtil.applyGuard(
        context: context,
        ref: ref,
        guard: _authGuard,
      );
    }

    if (requiresUnauth(route)) {
      return RouteGuardUtil.applyGuard(
        context: context,
        ref: ref,
        guard: _unauthGuard,
      );
    }

    return true; // Allow navigation to public routes
  }
}