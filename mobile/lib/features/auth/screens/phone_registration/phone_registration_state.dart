import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_registration_state.freezed.dart';

/// Phone registration screen state for Vietnamese sports app
/// 
/// Uses Freezed to create immutable state classes with type safety
/// Includes all registration states needed for Vietnamese phone verification flows
@freezed
class PhoneRegistrationState with _$PhoneRegistrationState {
  /// Initial state when registration screen loads
  const factory PhoneRegistrationState.initial() = _Initial;
  
  /// Loading state during registration process
  /// 
  /// [message] - Loading message in Vietnamese
  /// Example: "Đang gửi mã xác thực...", "Đang tạo tài khoản..."
  const factory PhoneRegistrationState.loading({
    String? message,
  }) = _Loading;
  
  /// Verification code sent successfully
  /// 
  /// [phoneNumber] - Phone number that received the code
  /// [verificationId] - Firebase verification ID
  /// [name] - User's name for registration
  /// [password] - User's password for registration
  /// [preferredSports] - Selected Vietnamese sports preferences
  const factory PhoneRegistrationState.verificationCodeSent({
    required String phoneNumber,
    required String verificationId,
    required String name,
    required String password,
    required List<String> preferredSports,
  }) = _VerificationCodeSent;
  
  /// Success state when registration completes
  /// 
  /// [message] - Success message in Vietnamese
  const factory PhoneRegistrationState.success({
    String? message,
  }) = _Success;
  
  /// Error state with Vietnamese message
  /// 
  /// [message] - Error message in Vietnamese
  /// [errorCode] - Error code for specific handling (optional)
  const factory PhoneRegistrationState.error({
    required String message,
    String? errorCode,
  }) = _Error;
  
  /// Sports preferences updated
  /// 
  /// [sports] - Updated list of preferred Vietnamese sports
  const factory PhoneRegistrationState.sportsUpdated({
    required List<String> sports,
  }) = _SportsUpdated;
  
  /// Navigate to login screen
  const factory PhoneRegistrationState.navigateToLogin() = _NavigateToLogin;
}

/// Extension methods for PhoneRegistrationState for convenient usage
extension PhoneRegistrationStateExtensions on PhoneRegistrationState {
  /// Check if currently loading
  bool get isLoading => when(
    initial: () => false,
    loading: (_) => true,
    verificationCodeSent: (_, __, ___, ____, _____) => false,
    success: (_) => false,
    error: (_, __) => false,
    sportsUpdated: (_) => false,
    navigateToLogin: () => false,
  );
  
  /// Check if has error
  bool get hasError => when(
    initial: () => false,
    loading: (_) => false,
    verificationCodeSent: (_, __, ___, ____, _____) => false,
    success: (_) => false,
    error: (_, __) => true,
    sportsUpdated: (_) => false,
    navigateToLogin: () => false,
  );
  
  /// Get error message (if any)
  String? get errorMessage => when(
    initial: () => null,
    loading: (_) => null,
    verificationCodeSent: (_, __, ___, ____, _____) => null,
    success: (_) => null,
    error: (message, _) => message,
    sportsUpdated: (_) => null,
    navigateToLogin: () => null,
  );
  
  /// Get loading message (if any)
  String? get loadingMessage => when(
    initial: () => null,
    loading: (message) => message,
    verificationCodeSent: (_, __, ___, ____, _____) => null,
    success: (_) => null,
    error: (_, __) => null,
    sportsUpdated: (_) => null,
    navigateToLogin: () => null,
  );
  
  /// Check if verification code was sent
  bool get isVerificationCodeSent => when(
    initial: () => false,
    loading: (_) => false,
    verificationCodeSent: (_, __, ___, ____, _____) => true,
    success: (_) => false,
    error: (_, __) => false,
    sportsUpdated: (_) => false,
    navigateToLogin: () => false,
  );
  
  /// Get phone number with verification code (if any)
  String? get verifyingPhoneNumber => when(
    initial: () => null,
    loading: (_) => null,
    verificationCodeSent: (phoneNumber, _, __, ___, ____) => phoneNumber,
    success: (_) => null,
    error: (_, __) => null,
    sportsUpdated: (_) => null,
    navigateToLogin: () => null,
  );
  
  /// Get verification ID (if any)
  String? get verificationId => when(
    initial: () => null,
    loading: (_) => null,
    verificationCodeSent: (_, verificationId, __, ___, ____) => verificationId,
    success: (_) => null,
    error: (_, __) => null,
    sportsUpdated: (_) => null,
    navigateToLogin: () => null,
  );
  
  /// Get selected sports preferences (if any)
  List<String>? get selectedSports => when(
    initial: () => null,
    loading: (_) => null,
    verificationCodeSent: (_, __, ___, ____, sports) => sports,
    success: (_) => null,
    error: (_, __) => null,
    sportsUpdated: (sports) => sports,
    navigateToLogin: () => null,
  );
}