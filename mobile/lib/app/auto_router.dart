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
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: GroupDetailsRoute.page,
      path: '/groups/:groupId',
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: CreateGroupRoute.page,
      path: '/groups/create',
      guards: [AuthGuard],
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
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // For now, create a new AuthCubit instance to check state
    // In a real app, you'd want to use a persistent auth state check
    final authCubit = getIt.createAuthCubit();
    
    authCubit.state.when(
      unauthenticated: () {
        // Redirect to login if not authenticated
        authCubit.close(); // Clean up
        router.pushAndClearStack(const LoginRoute());
      },
      authenticating: () {
        // Show loading or redirect to login
        authCubit.close(); // Clean up
        router.pushAndClearStack(const LoginRoute());
      },
      authenticated: (_) {
        // Allow navigation to protected route
        authCubit.close(); // Clean up
        resolver.next();
      },
      phoneVerificationRequired: (_, __) {
        // Redirect to SMS verification
        authCubit.close(); // Clean up
        router.pushAndClearStack(const SmsVerificationRoute());
      },
      error: (_, __) {
        // Redirect to login on error
        authCubit.close(); // Clean up
        router.pushAndClearStack(const LoginRoute());
      },
    );
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
  const SmsVerificationPage({super.key});

  @override
  Widget build(BuildContext context) => const SmsVerificationScreen();
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
    // This wrapper decides the initial route based on auth state
    final authCubit = getIt<AuthCubit>();
    
    return StreamBuilder(
      stream: authCubit.stream,
      builder: (context, snapshot) {
        final state = authCubit.state;
        
        return state.when(
          unauthenticated: () => const LoginPage(),
          authenticating: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          authenticated: (_) => const GroupsListPage(),
          phoneVerificationRequired: (_, __) => const SmsVerificationPage(),
          error: (_, __) => const LoginPage(),
        );
      },
    );
  }
}