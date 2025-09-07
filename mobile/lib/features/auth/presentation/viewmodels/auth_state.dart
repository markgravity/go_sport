import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/user_model.dart';
import '../../models/auth_tokens.dart';

part 'auth_state.freezed.dart';

/// Authentication state for Go Sport app
/// 
/// Uses Freezed to create immutable state classes with type safety
/// Includes all authentication states needed for Vietnamese users
@freezed
class AuthState with _$AuthState {
  /// Unauthenticated state - initial state
  const factory AuthState.unauthenticated() = _Unauthenticated;
  
  /// Processing authentication state with optional message
  /// 
  /// [message] - Loading message in Vietnamese
  /// Example: "Đang gửi mã xác thực...", "Đang đăng nhập..."
  const factory AuthState.authenticating({
    String? message,
  }) = _Authenticating;
  
  /// Successfully authenticated state
  /// 
  /// [user] - User information
  /// [tokens] - Firebase and Laravel tokens
  const factory AuthState.authenticated({
    required UserModel user,
    required AuthTokens tokens,
  }) = _Authenticated;
  
  /// Vietnamese phone number verification required state
  /// 
  /// [phoneNumber] - Phone number that verification code was sent to
  /// [verificationId] - Firebase verification ID
  const factory AuthState.phoneVerificationRequired({
    required String phoneNumber,
    String? verificationId,
  }) = _PhoneVerificationRequired;
  
  /// Error state with Vietnamese message
  /// 
  /// [message] - Error message in Vietnamese
  /// [errorCode] - Error code for specific handling (optional)
  const factory AuthState.error({
    required String message,
    String? errorCode,
  }) = _AuthError;
  
  /// Token refresh state
  /// 
  /// [user] - Current user (keep unchanged)
  /// [tokens] - Current tokens (will be updated)
  const factory AuthState.refreshingToken({
    required UserModel user,
    required AuthTokens tokens,
  }) = _RefreshingToken;
}

/// Extension methods for AuthState for convenient usage
extension AuthStateExtensions on AuthState {
  /// Check if currently loading
  bool get isLoading => when(
    unauthenticated: () => false,
    authenticating: (_) => true,
    authenticated: (_, __) => false,
    phoneVerificationRequired: (_, __) => false,
    error: (_, __) => false,
    refreshingToken: (_, __) => true,
  );
  
  /// Check if authenticated
  bool get isAuthenticated => when(
    unauthenticated: () => false,
    authenticating: (_) => false,
    authenticated: (_, __) => true,
    phoneVerificationRequired: (_, __) => false,
    error: (_, __) => false,
    refreshingToken: (_, __) => true, // Still considered authenticated when refreshing
  );
  
  /// Check if has error
  bool get hasError => when(
    unauthenticated: () => false,
    authenticating: (_) => false,
    authenticated: (_, __) => false,
    phoneVerificationRequired: (_, __) => false,
    error: (_, __) => true,
    refreshingToken: (_, __) => false,
  );
  
  /// Get current user (if any)
  UserModel? get currentUser => when(
    unauthenticated: () => null,
    authenticating: (_) => null,
    authenticated: (user, _) => user,
    phoneVerificationRequired: (_, __) => null,
    error: (_, __) => null,
    refreshingToken: (user, _) => user,
  );
  
  /// Get current tokens (if any)
  AuthTokens? get currentTokens => when(
    unauthenticated: () => null,
    authenticating: (_) => null,
    authenticated: (_, tokens) => tokens,
    phoneVerificationRequired: (_, __) => null,
    error: (_, __) => null,
    refreshingToken: (_, tokens) => tokens,
  );
  
  /// Get error message (if any)
  String? get errorMessage => when(
    unauthenticated: () => null,
    authenticating: (_) => null,
    authenticated: (_, __) => null,
    phoneVerificationRequired: (_, __) => null,
    error: (message, _) => message,
    refreshingToken: (_, __) => null,
  );
  
  /// Get loading message (if any)
  String? get loadingMessage => when(
    unauthenticated: () => null,
    authenticating: (message) => message,
    authenticated: (_, __) => null,
    phoneVerificationRequired: (_, __) => null,
    error: (_, __) => null,
    refreshingToken: (_, __) => 'Đang làm mới phiên đăng nhập...',
  );
  
  /// Check if phone verification is required
  bool get requiresPhoneVerification => when(
    unauthenticated: () => false,
    authenticating: (_) => false,
    authenticated: (_, __) => false,
    phoneVerificationRequired: (_, __) => true,
    error: (_, __) => false,
    refreshingToken: (_, __) => false,
  );
  
  /// Get phone number being verified (if any)
  String? get verifyingPhoneNumber => when(
    unauthenticated: () => null,
    authenticating: (_) => null,
    authenticated: (_, __) => null,
    phoneVerificationRequired: (phoneNumber, _) => phoneNumber,
    error: (_, __) => null,
    refreshingToken: (_, __) => null,
  );
}