import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/dependency_injection/injection_container.dart';
import 'viewmodels/auth_cubit.dart';
import 'viewmodels/auth_state.dart' as cubit_state;
import '../models/user_model.dart';

/// Authentication wrapper using Cubit architecture
/// 
/// Provides consistent auth state management across the app
class AuthWrapper extends StatelessWidget {
  final Widget Function(BuildContext context, AuthWrapperState state) builder;

  const AuthWrapper({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.createAuthCubit(),
      child: BlocBuilder<AuthCubit, cubit_state.AuthState>(
        builder: (context, state) {
          final wrapperState = _cubitStateToWrapperState(state);
          return builder(context, wrapperState);
        },
      ),
    );
  }

  /// Convert Cubit AuthState to unified AuthWrapperState
  AuthWrapperState _cubitStateToWrapperState(cubit_state.AuthState state) {
    return state.when(
      unauthenticated: () => const AuthWrapperState.unauthenticated(),
      authenticating: (message) => AuthWrapperState.loading(message: message),
      authenticated: (user, tokens) => AuthWrapperState.authenticated(user: user),
      phoneVerificationRequired: (phoneNumber, verificationId) => 
          AuthWrapperState.phoneVerificationRequired(phoneNumber: phoneNumber),
      error: (message, errorCode) => AuthWrapperState.error(message: message),
      refreshingToken: (user, tokens) => AuthWrapperState.loading(
        message: 'Refreshing session...'
      ),
    );
  }
}

/// Unified authentication state for the wrapper
/// 
/// Provides consistent interface regardless of underlying architecture
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
/// Provides unified interface for authentication actions using Cubit
class AuthController {
  final BuildContext context;
  
  AuthController(this.context);

  /// Login with phone number and password
  Future<bool> loginWithPassword({
    required String phoneNumber,
    required String password,
    bool rememberMe = false,
  }) async {
    // For now, forward to SMS verification flow
    // This would need proper password authentication in the future
    final verificationId = await sendVerificationCode(phoneNumber);
    return verificationId != null;
  }

  /// Send SMS verification code
  Future<String?> sendVerificationCode(String phoneNumber) async {
    // Try to read from context, fallback to GetIt if not available
    try {
      final authCubit = context.read<AuthCubit>();
      return await authCubit.sendVerificationCode(phoneNumber);
    } catch (e) {
      // Fallback: Create temporary instance for this operation
      final authCubit = getIt.createAuthCubit();
      final result = await authCubit.sendVerificationCode(phoneNumber);
      authCubit.close();
      return result;
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
    // Try to read from context, fallback to GetIt if not available
    try {
      final authCubit = context.read<AuthCubit>();
      return await authCubit.completeRegistration(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        smsCode: smsCode,
        name: name,
        preferredSports: preferredSports,
      );
    } catch (e) {
      // Fallback: Create temporary instance for this operation
      final authCubit = getIt.createAuthCubit();
      final result = await authCubit.completeRegistration(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        smsCode: smsCode,
        name: name,
        preferredSports: preferredSports,
      );
      authCubit.close();
      return result;
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    // Try to read from context, fallback to GetIt if not available
    try {
      final authCubit = context.read<AuthCubit>();
      await authCubit.signOut();
    } catch (e) {
      // Fallback: Create temporary instance for this operation
      final authCubit = getIt.createAuthCubit();
      await authCubit.signOut();
      authCubit.close();
    }
  }

  /// Clear current error
  void clearError() {
    // Try to read from context, fallback to GetIt if not available
    try {
      final authCubit = context.read<AuthCubit>();
      authCubit.clearError();
    } catch (e) {
      // Fallback: For clearError, we can skip if no context available
      // since error clearing is not critical for functionality
    }
  }

  /// Get current user
  UserModel? get currentUser {
    // Try to read from context, fallback to GetIt if not available
    try {
      final authCubit = context.read<AuthCubit>();
      return authCubit.currentUser;
    } catch (e) {
      // Fallback: Return null if no context available
      return null;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated {
    // Try to read from context, fallback to GetIt if not available
    try {
      final authCubit = context.read<AuthCubit>();
      return authCubit.isAuthenticated;
    } catch (e) {
      // Fallback: Return false if no context available
      return false;
    }
  }
}