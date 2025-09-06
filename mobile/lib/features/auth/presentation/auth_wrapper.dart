import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/feature_flags.dart';
import '../../../core/dependency_injection/injection_container.dart';
import '../providers/auth_provider.dart';
import 'viewmodels/auth_cubit.dart';
import 'viewmodels/auth_state.dart' as cubit_state;
import '../models/user_model.dart';

/// Authentication wrapper cho phép coexistence giữa Riverpod và Cubit
/// 
/// Dựa trên feature flag để quyết định sử dụng architecture nào:
/// - Riverpod AuthProvider (legacy)
/// - Cubit AuthCubit (new)
class AuthWrapper extends StatelessWidget {
  final Widget Function(BuildContext context, AuthWrapperState state) builder;

  const AuthWrapper({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (RuntimeFeatureFlags.useCubitAuth) {
      // Sử dụng Cubit architecture
      return BlocProvider(
        create: (context) => getIt.createAuthCubit(),
        child: BlocBuilder<AuthCubit, cubit_state.AuthState>(
          builder: (context, state) {
            final wrapperState = _cubitStateToWrapperState(state);
            return builder(context, wrapperState);
          },
        ),
      );
    } else {
      // Sử dụng Riverpod architecture (legacy)
      return Consumer(
        builder: (context, ref, child) {
          final authState = ref.watch(authProvider);
          final wrapperState = _riverpodStateToWrapperState(authState);
          return builder(context, wrapperState);
        },
      );
    }
  }

  /// Convert Cubit AuthState sang unified AuthWrapperState
  AuthWrapperState _cubitStateToWrapperState(cubit_state.AuthState state) {
    return state.when(
      unauthenticated: () => const AuthWrapperState.unauthenticated(),
      authenticating: (message) => AuthWrapperState.loading(message: message),
      authenticated: (user, tokens) => AuthWrapperState.authenticated(user: user),
      phoneVerificationRequired: (phoneNumber, verificationId) =>
          AuthWrapperState.phoneVerificationRequired(phoneNumber: phoneNumber),
      error: (message, errorCode) => AuthWrapperState.error(message: message),
      refreshingToken: (user, tokens) => AuthWrapperState.authenticated(user: user),
    );
  }

  /// Convert Riverpod AuthState sang unified AuthWrapperState
  AuthWrapperState _riverpodStateToWrapperState(
      dynamic riverpodState) {
    if (riverpodState.isLoading) {
      return const AuthWrapperState.loading();
    } else if (riverpodState.error != null) {
      return AuthWrapperState.error(message: riverpodState.error!);
    } else if (riverpodState.isAuthenticated && riverpodState.user != null) {
      return AuthWrapperState.authenticated(user: riverpodState.user!);
    } else {
      return const AuthWrapperState.unauthenticated();
    }
  }
}

/// Unified authentication state cho wrapper
/// 
/// Cung cấp common interface cho cả Riverpod và Cubit states
class AuthWrapperState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserModel? user;
  final String? error;
  final String? message;
  final bool requiresPhoneVerification;
  final String? phoneNumber;

  const AuthWrapperState._({
    required this.isLoading,
    required this.isAuthenticated,
    this.user,
    this.error,
    this.message,
    required this.requiresPhoneVerification,
    this.phoneNumber,
  });

  const AuthWrapperState.unauthenticated()
      : isLoading = false,
        isAuthenticated = false,
        user = null,
        error = null,
        message = null,
        requiresPhoneVerification = false,
        phoneNumber = null;

  const AuthWrapperState.loading({this.message})
      : isLoading = true,
        isAuthenticated = false,
        user = null,
        error = null,
        requiresPhoneVerification = false,
        phoneNumber = null;

  const AuthWrapperState.authenticated({required this.user})
      : isLoading = false,
        isAuthenticated = true,
        error = null,
        message = null,
        requiresPhoneVerification = false,
        phoneNumber = null;

  const AuthWrapperState.error({required String message})
      : isLoading = false,
        isAuthenticated = false,
        user = null,
        error = message,
        message = null,
        requiresPhoneVerification = false,
        phoneNumber = null;

  const AuthWrapperState.phoneVerificationRequired({required this.phoneNumber})
      : isLoading = false,
        isAuthenticated = false,
        user = null,
        error = null,
        message = null,
        requiresPhoneVerification = true;

  /// Convenience methods
  bool get hasError => error != null;
  String? get displayMessage => error ?? message;
}

/// Authentication controller wrapper
/// 
/// Cung cấp unified interface cho authentication actions
/// Tự động route calls đến Riverpod hoặc Cubit based on feature flag
class AuthController {
  final BuildContext context;
  
  AuthController(this.context);

  /// Login with phone number and password
  Future<bool> loginWithPassword({
    required String phoneNumber,
    required String password,
    bool rememberMe = false,
  }) async {
    if (RuntimeFeatureFlags.useCubitAuth) {
      // Sử dụng Cubit - For now, forward to SMS verification flow
      // This would need proper password authentication in the future
      final verificationId = await sendVerificationCode(phoneNumber);
      return verificationId != null;
    } else {
      // Sử dụng Riverpod
      // TODO: Implement password login in Riverpod provider
      return false;
    }
  }

  /// Send SMS verification code
  Future<String?> sendVerificationCode(String phoneNumber) async {
    if (RuntimeFeatureFlags.useCubitAuth) {
      // Sử dụng Cubit
      final authCubit = context.read<AuthCubit>();
      return await authCubit.sendVerificationCode(phoneNumber);
    } else {
      // Sử dụng Riverpod
      final container = ProviderScope.containerOf(context);
      final authNotifier = container.read(authProvider.notifier);
      return await authNotifier.sendVerificationCode(phoneNumber);
    }
  }

  /// Complete registration with SMS verification
  Future<bool> completeRegistration({
    required String phoneNumber,
    required String verificationId,
    required String smsCode,
    required String name,
    List<String>? preferredSports,
  }) async {
    if (RuntimeFeatureFlags.useCubitAuth) {
      // Sử dụng Cubit
      final authCubit = context.read<AuthCubit>();
      return await authCubit.completeRegistration(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        smsCode: smsCode,
        name: name,
        preferredSports: preferredSports,
      );
    } else {
      // Sử dụng Riverpod
      final container = ProviderScope.containerOf(context);
      final authNotifier = container.read(authProvider.notifier);
      return await authNotifier.completeRegistration(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        smsCode: smsCode,
        name: name,
        preferredSports: preferredSports,
      );
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    if (RuntimeFeatureFlags.useCubitAuth) {
      // Sử dụng Cubit
      final authCubit = context.read<AuthCubit>();
      await authCubit.signOut();
    } else {
      // Sử dụng Riverpod
      final container = ProviderScope.containerOf(context);
      final authNotifier = container.read(authProvider.notifier);
      await authNotifier.signOut();
    }
  }

  /// Clear current error
  void clearError() {
    if (RuntimeFeatureFlags.useCubitAuth) {
      // Sử dụng Cubit
      final authCubit = context.read<AuthCubit>();
      authCubit.clearError();
    } else {
      // Sử dụng Riverpod
      final container = ProviderScope.containerOf(context);
      final authNotifier = container.read(authProvider.notifier);
      authNotifier.clearError();
    }
  }

  /// Get current user
  UserModel? get currentUser {
    if (RuntimeFeatureFlags.useCubitAuth) {
      // Sử dụng Cubit
      final authCubit = context.read<AuthCubit>();
      return authCubit.currentUser;
    } else {
      // Sử dụng Riverpod
      final container = ProviderScope.containerOf(context);
      final authState = container.read(authProvider);
      return authState.user;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated {
    if (RuntimeFeatureFlags.useCubitAuth) {
      // Sử dụng Cubit
      final authCubit = context.read<AuthCubit>();
      return authCubit.isAuthenticated;
    } else {
      // Sử dụng Riverpod
      final container = ProviderScope.containerOf(context);
      final authState = container.read(authProvider);
      return authState.isAuthenticated;
    }
  }
}