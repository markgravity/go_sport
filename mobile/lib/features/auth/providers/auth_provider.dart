import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user_model.dart';
import '../models/auth_tokens.dart';
import '../services/firebase_auth_service.dart';
import '../services/api_service.dart';

// Firebase Auth Service Provider
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Current Firebase User Provider
final firebaseUserProvider = StreamProvider<firebase_auth.User?>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return authService.authStateChanges;
});

// Authentication State Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return AuthNotifier(firebaseAuthService, apiService);
});

// Authentication State
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserModel? user;
  final AuthTokens? tokens;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.tokens,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserModel? user,
    AuthTokens? tokens,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      tokens: tokens ?? this.tokens,
      error: error,
    );
  }

  AuthState clearError() {
    return copyWith(error: null);
  }

  AuthState loading() {
    return copyWith(isLoading: true, error: null);
  }

  AuthState success({
    UserModel? user,
    AuthTokens? tokens,
    bool? isAuthenticated,
  }) {
    return copyWith(
      isLoading: false,
      error: null,
      user: user ?? this.user,
      tokens: tokens ?? this.tokens,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  AuthState failure(String error) {
    return copyWith(
      isLoading: false,
      error: error,
    );
  }

  AuthState signOut() {
    return const AuthState(
      isLoading: false,
      isAuthenticated: false,
      user: null,
      tokens: null,
      error: null,
    );
  }
}

// Authentication State Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuthService _firebaseAuthService;
  final ApiService _apiService;

  AuthNotifier(this._firebaseAuthService, this._apiService) 
      : super(const AuthState()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    state = state.loading();
    
    try {
      final firebaseUser = _firebaseAuthService.currentFirebaseUser;
      
      if (firebaseUser != null) {
        // User is signed in to Firebase, check backend authentication
        await _authenticateWithBackend();
      } else {
        // No Firebase user, set as unauthenticated
        state = state.signOut();
      }
    } catch (e) {
      state = state.failure('Initialization failed: ${e.toString()}');
    }
  }

  Future<void> _authenticateWithBackend({
    String? name,
    List<String>? preferredSports,
  }) async {
    try {
      final user = await _firebaseAuthService.authenticateWithBackend(
        name: name,
        preferredSports: preferredSports,
      );

      if (user != null) {
        final idToken = await _firebaseAuthService.getIdToken();
        
        if (idToken != null) {
          final tokens = AuthTokens(
            firebaseIdToken: idToken,
            laravelToken: '', // This would be returned from backend
            firebaseUid: user.firebaseUid ?? '',
            expiresAt: DateTime.now().add(const Duration(hours: 1)),
          );

          state = state.success(
            user: user,
            tokens: tokens,
            isAuthenticated: true,
          );
        } else {
          throw Exception('Failed to get Firebase ID token');
        }
      } else {
        throw Exception('Backend authentication failed');
      }
    } catch (e) {
      state = state.failure('Authentication failed: ${e.toString()}');
      // Sign out from Firebase if backend auth fails
      await _firebaseAuthService.signOut();
    }
  }

  // Send SMS verification code
  Future<String?> sendVerificationCode(String phoneNumber) async {
    state = state.loading();
    
    try {
      String? verificationId;
      
      await _firebaseAuthService.sendSMSVerification(
        phoneNumber: phoneNumber,
        onCodeSent: (id) {
          verificationId = id;
          state = state.success();
        },
        onError: (error) {
          state = state.failure(error.message ?? 'Failed to send SMS');
        },
      );
      
      return verificationId;
    } catch (e) {
      state = state.failure('SMS sending failed: ${e.toString()}');
      return null;
    }
  }

  // Complete registration with SMS verification
  Future<bool> completeRegistration({
    required String phoneNumber,
    required String verificationId,
    required String smsCode,
    required String name,
    List<String>? preferredSports,
  }) async {
    state = state.loading();
    
    try {
      final user = await _firebaseAuthService.completeRegistration(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        smsCode: smsCode,
        name: name,
        preferredSports: preferredSports,
      );

      final idToken = await _firebaseAuthService.getIdToken();
      
      if (idToken != null) {
        final tokens = AuthTokens(
          firebaseIdToken: idToken,
          laravelToken: '', // This would be returned from backend
          firebaseUid: user.firebaseUid ?? '',
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );

        state = state.success(
          user: user,
          tokens: tokens,
          isAuthenticated: true,
        );
        
        return true;
      } else {
        throw Exception('Failed to get Firebase ID token');
      }
    } catch (e) {
      state = state.failure('Registration failed: ${e.toString()}');
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    state = state.loading();
    
    try {
      await _firebaseAuthService.signOut();
      state = state.signOut();
    } catch (e) {
      state = state.failure('Sign out failed: ${e.toString()}');
    }
  }

  // Delete account
  Future<bool> deleteAccount() async {
    state = state.loading();
    
    try {
      await _firebaseAuthService.deleteAccount();
      state = state.signOut();
      return true;
    } catch (e) {
      state = state.failure('Account deletion failed: ${e.toString()}');
      return false;
    }
  }

  // Refresh user data
  Future<void> refreshUser() async {
    if (!state.isAuthenticated || state.user == null) return;
    
    state = state.loading();
    
    try {
      // This would refresh user data from the backend
      // For now, we'll just refresh the Firebase token
      final idToken = await _firebaseAuthService.getIdToken(forceRefresh: true);
      
      if (idToken != null && state.tokens != null) {
        final updatedTokens = state.tokens!.copyWith(
          firebaseIdToken: idToken,
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );
        
        state = state.success(tokens: updatedTokens);
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      state = state.failure('Token refresh failed: ${e.toString()}');
    }
  }

  // Clear error
  void clearError() {
    state = state.clearError();
  }

  // Check if tokens are valid and not expired
  bool get hasValidTokens {
    return state.tokens != null && state.tokens!.isValid;
  }

  // Get current user
  UserModel? get currentUser => state.user;

  // Check authentication status
  bool get isAuthenticated => state.isAuthenticated && hasValidTokens;
}