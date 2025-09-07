import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/viewmodels/auth_cubit.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/phone_registration_screen.dart';
import '../features/auth/screens/sms_verification_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/groups/screens/create_group_screen.dart';
import '../features/groups/screens/groups_list/groups_list_screen.dart';
import '../features/groups/screens/group_details/group_details_screen.dart';
import '../core/dependency_injection/injection_container.dart';

part 'auto_router.gr.dart';

/// AutoRoute configuration for Vietnamese sports app
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Authentication routes
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
    
    // Groups routes - protected by auth guard
    AutoRoute(
      page: GroupsListRoute.page,
      path: '/groups',
    ),
    AutoRoute(
      page: GroupDetailsRoute.page,
      path: '/groups/:groupId',
    ),
    AutoRoute(
      page: CreateGroupRoute.page,
      path: '/groups/create',
    ),
    
    // Default route - redirects based on auth state
    AutoRoute(
      page: WrapperRoute.page,
      path: '/',
      initial: true,
    ),
  ];
}

/// Authentication guard for protected routes
/// TODO: Implement proper authentication checking
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // For now, allow all navigation
    // TODO: Add proper authentication checking
    resolver.next();
  }
}

/// Page definitions for AutoRoute code generation
@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const LoginScreen();
}

@RoutePage()
class PhoneRegistrationPage extends StatelessWidget {
  const PhoneRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) => const PhoneRegistrationScreen();
}

@RoutePage()
class SmsVerificationPage extends StatelessWidget {
  final String phoneNumber;
  final String userName;
  final String password;
  final List<String> selectedSports;
  
  const SmsVerificationPage({
    super.key,
    @queryParam required this.phoneNumber,
    @queryParam required this.userName, 
    @queryParam required this.password,
    @queryParam this.selectedSports = const [],
  });

  @override
  Widget build(BuildContext context) => SmsVerificationScreen(
    phoneNumber: phoneNumber,
    userName: userName,
    password: password,
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

@RoutePage()
class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple wrapper - default to login screen
    // TODO: Add proper authentication state checking
    return const LoginPage();
  }
}