import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// Login screen state for Vietnamese sports app
/// 
/// Uses Freezed to create immutable state classes with type safety
/// Includes all login states needed for Vietnamese authentication flows
@freezed
class LoginState with _$LoginState {
  /// Initial state when login screen loads
  const factory LoginState.initial() = _Initial;
  
  /// Loading state during authentication process
  /// 
  /// [message] - Loading message in Vietnamese
  /// Example: "Đang đăng nhập...", "Đang gửi mã xác thực..."
  const factory LoginState.loading({
    String? message,
  }) = _Loading;
  
  /// Phone verification required state
  /// 
  /// [phoneNumber] - Phone number that needs verification
  /// [verificationId] - Firebase verification ID for SMS
  const factory LoginState.phoneVerificationRequired({
    required String phoneNumber,
    String? verificationId,
  }) = _PhoneVerificationRequired;
  
  /// SMS code sent successfully
  /// 
  /// [phoneNumber] - Phone number that received SMS
  /// [verificationId] - Firebase verification ID for SMS
  const factory LoginState.smsCodeSent({
    required String phoneNumber,
    required String verificationId,
  }) = _SmsCodeSent;
  
  /// Success state when login completes
  /// 
  /// [message] - Success message in Vietnamese
  const factory LoginState.success({
    String? message,
  }) = _Success;
  
  /// Error state with Vietnamese message
  /// 
  /// [message] - Error message in Vietnamese
  /// [errorCode] - Error code for specific handling (optional)
  const factory LoginState.error({
    required String message,
    String? errorCode,
  }) = _Error;
  
  /// Navigate to registration screen
  const factory LoginState.navigateToRegistration() = _NavigateToRegistration;
  
  /// Navigate to forgot password screen
  const factory LoginState.navigateToForgotPassword() = _NavigateToForgotPassword;
}

/// Extension methods for LoginState for convenient usage
extension LoginStateExtensions on LoginState {
  /// Check if currently loading
  bool get isLoading => when(
    initial: () => false,
    loading: (_) => true,
    phoneVerificationRequired: (_, __) => false,
    smsCodeSent: (_, __) => false,
    success: (_) => false,
    error: (_, __) => false,
    navigateToRegistration: () => false,
    navigateToForgotPassword: () => false,
  );
  
  /// Check if has error
  bool get hasError => when(
    initial: () => false,
    loading: (_) => false,
    phoneVerificationRequired: (_, __) => false,
    smsCodeSent: (_, __) => false,
    success: (_) => false,
    error: (_, __) => true,
    navigateToRegistration: () => false,
    navigateToForgotPassword: () => false,
  );
  
  /// Get error message (if any)
  String? get errorMessage => when(
    initial: () => null,
    loading: (_) => null,
    phoneVerificationRequired: (_, __) => null,
    smsCodeSent: (_, __) => null,
    success: (_) => null,
    error: (message, _) => message,
    navigateToRegistration: () => null,
    navigateToForgotPassword: () => null,
  );
  
  /// Get loading message (if any)
  String? get loadingMessage => when(
    initial: () => null,
    loading: (message) => message,
    phoneVerificationRequired: (_, __) => null,
    smsCodeSent: (_, __) => null,
    success: (_) => null,
    error: (_, __) => null,
    navigateToRegistration: () => null,
    navigateToForgotPassword: () => null,
  );
  
  /// Check if phone verification is required
  bool get requiresPhoneVerification => when(
    initial: () => false,
    loading: (_) => false,
    phoneVerificationRequired: (_, __) => true,
    smsCodeSent: (_, __) => true,
    success: (_) => false,
    error: (_, __) => false,
    navigateToRegistration: () => false,
    navigateToForgotPassword: () => false,
  );
  
  /// Get phone number being verified (if any)
  String? get verifyingPhoneNumber => when(
    initial: () => null,
    loading: (_) => null,
    phoneVerificationRequired: (phoneNumber, _) => phoneNumber,
    smsCodeSent: (phoneNumber, _) => phoneNumber,
    success: (_) => null,
    error: (_, __) => null,
    navigateToRegistration: () => null,
    navigateToForgotPassword: () => null,
  );
}