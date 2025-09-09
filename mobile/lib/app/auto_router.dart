import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../core/dependency_injection/injection_container.dart';
import '../features/auth/services/auth_service.dart';
import '../features/auth/screens/login/login_screen.dart';
import '../features/auth/screens/phone_registration/phone_registration_screen.dart';
import '../features/auth/screens/sms_verification/sms_verification_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/groups/screens/create_group/create_group_screen.dart';
import '../features/groups/screens/groups_list/groups_list_screen.dart';
import '../features/groups/screens/group_details/group_details_screen.dart';
import '../features/groups/screens/invitation_management/invitation_management_screen.dart';

part 'auto_router.gr.dart';

/// AutoRoute configuration for Vietnamese sports app
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  // Singleton instance of AuthGuard
  final AuthGuard authGuard = AuthGuard();
  
  @override
  List<AutoRoute> get routes => [
    // Authentication routes (public - no guard needed)
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: PhoneRegistrationRoute.page,
      path: '/register',
    ),
    AutoRoute(
      page: SmsVerificationRoute.page,
      path: '/verify-sms',
    ),
    AutoRoute(
      page: ForgotPasswordRoute.page,
      path: '/forgot-password',
    ),
    
    // Groups routes - PROTECTED by auth guard
    AutoRoute(
      page: GroupsListRoute.page,
      path: '/groups',
      guards: [authGuard],
    ),
    AutoRoute(
      page: GroupDetailsRoute.page,
      path: '/groups/:groupId',
      guards: [authGuard],
    ),
    AutoRoute(
      page: CreateGroupRoute.page,
      path: '/groups/create',
      guards: [authGuard],
    ),
    AutoRoute(
      page: InvitationManagementRoute.page,
      path: '/groups/:groupId/invitations',
      guards: [authGuard],
    ),
    
    // Default route - check auth and redirect accordingly
    AutoRoute(
      page: GroupsListRoute.page,
      path: '/',
      initial: true,
      guards: [authGuard],
    ),
  ];
}

/// Authentication guard for protected routes
/// Verifies user authentication before allowing access to protected routes
@injectable
class AuthGuard extends AutoRouteGuard {
  final AuthService _authService;
  
  AuthGuard() : _authService = getIt<AuthService>();
  
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Check if user is authenticated
    final isAuthenticated = await _authService.isLoggedIn();
    
    if (isAuthenticated) {
      // User is authenticated, allow navigation
      resolver.next(true);
    } else {
      // User is not authenticated, redirect to login
      // Save the original route for redirect after login
      final redirectRoute = resolver.route;
      
      // Navigate to login screen
      router.push(
        LoginRoute(
          redirectRoute: redirectRoute.path,
        ),
      );
      
      // Resolve navigation as handled (we redirected)
      resolver.next(false);
    }
  }
}

/// Page definitions for AutoRoute code generation
@RoutePage()
class LoginPage extends StatelessWidget {
  final String? redirectRoute;
  
  const LoginPage({
    super.key,
    @queryParam this.redirectRoute,
  });

  @override
  Widget build(BuildContext context) => LoginScreen(
    redirectRoute: redirectRoute,
  );
}

@RoutePage()
class PhoneRegistrationPage extends StatelessWidget {
  const PhoneRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) => const PhoneRegistrationScreen();
}

@RoutePage()
class SmsVerificationPage extends StatelessWidget {
  final String? phoneNumber;
  final String? userName;
  final String? password;
  final List<String> selectedSports;
  
  const SmsVerificationPage({
    super.key,
    @queryParam this.phoneNumber,
    @queryParam this.userName, 
    @queryParam this.password,
    @queryParam this.selectedSports = const [],
  });

  @override
  Widget build(BuildContext context) => SmsVerificationScreen(
    phoneNumber: phoneNumber ?? '',
    userName: userName ?? '',
    password: password ?? '',
    selectedSports: selectedSports,
  );
}

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) => const ForgotPasswordScreen();
}

@RoutePage()
class GroupsListPage extends StatelessWidget {
  const GroupsListPage({super.key});

  @override
  Widget build(BuildContext context) => const GroupsListScreen();
}

@RoutePage()
class GroupDetailsPage extends StatelessWidget {
  final String groupId;
  
  const GroupDetailsPage({
    super.key,
    @pathParam required this.groupId,
  });

  @override
  Widget build(BuildContext context) => GroupDetailsScreen(groupId: groupId);
}

@RoutePage()
class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({super.key});

  @override
  Widget build(BuildContext context) => const CreateGroupScreen();
}

// InvitationManagementPage removed - using InvitationManagementScreen directly with @RoutePage annotation

