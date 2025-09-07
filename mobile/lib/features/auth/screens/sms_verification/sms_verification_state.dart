import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_verification_state.freezed.dart';

/// SMS verification screen state for Vietnamese sports app
/// 
/// Uses Freezed to create immutable state classes with type safety
/// Includes all verification states needed for Vietnamese SMS flows
@freezed
class SmsVerificationState with _$SmsVerificationState {
  /// Initial state when SMS verification screen loads
  const factory SmsVerificationState.initial() = _Initial;
  
  /// Loading state during verification process
  /// 
  /// [message] - Loading message in Vietnamese
  /// Example: "Đang xác thực mã...", "Đang gửi lại mã..."
  const factory SmsVerificationState.loading({
    String? message,
  }) = _Loading;
  
  /// Waiting for user to enter verification code
  /// 
  /// [phoneNumber] - Phone number that received the code
  /// [verificationId] - Firebase verification ID
  /// [resendCountdown] - Seconds until resend is available
  /// [currentCode] - Currently entered code
  /// [userName] - User's name (for registration flow)
  /// [userPassword] - User's password (for registration flow)
  /// [preferredSports] - Selected sports (for registration flow)
  const factory SmsVerificationState.waitingForCode({
    required String phoneNumber,
    required String verificationId,
    required int resendCountdown,
    String? currentCode,
    String? userName,
    String? userPassword,
    List<String>? preferredSports,
  }) = _WaitingForCode;
  
  /// Code was resent successfully
  /// 
  /// [phoneNumber] - Phone number that received the new code
  /// [verificationId] - New Firebase verification ID
  /// [resendCountdown] - Reset countdown timer
  const factory SmsVerificationState.codeResent({
    required String phoneNumber,
    required String verificationId,
    required int resendCountdown,
  }) = _CodeResent;
  
  /// Success state when verification completes
  /// 
  /// [message] - Success message in Vietnamese
  /// [isRegistration] - Whether this was a registration flow
  const factory SmsVerificationState.success({
    String? message,
    required bool isRegistration,
  }) = _Success;
  
  /// Error state with Vietnamese message
  /// 
  /// [message] - Error message in Vietnamese
  /// [errorCode] - Error code for specific handling (optional)
  const factory SmsVerificationState.error({
    required String message,
    String? errorCode,
  }) = _Error;
  
  /// Navigate back to previous screen
  const factory SmsVerificationState.navigateBack() = _NavigateBack;
}

/// Extension methods for SmsVerificationState for convenient usage
extension SmsVerificationStateExtensions on SmsVerificationState {
  /// Check if currently loading
  bool get isLoading => when(
    initial: () => false,
    loading: (_) => true,
    waitingForCode: (_, __, ___, ____, _____, ______, _______) => false,
    codeResent: (_, __, ___) => false,
    success: (_, __) => false,
    error: (_, __) => false,
    navigateBack: () => false,
  );
  
  /// Check if has error
  bool get hasError => when(
    initial: () => false,
    loading: (_) => false,
    waitingForCode: (_, __, ___, ____, _____, ______, _______) => false,
    codeResent: (_, __, ___) => false,
    success: (_, __) => false,
    error: (_, __) => true,
    navigateBack: () => false,
  );
  
  /// Get error message (if any)
  String? get errorMessage => when(
    initial: () => null,
    loading: (_) => null,
    waitingForCode: (_, __, ___, ____, _____, ______, _______) => null,
    codeResent: (_, __, ___) => null,
    success: (_, __) => null,
    error: (message, _) => message,
    navigateBack: () => null,
  );
  
  /// Get loading message (if any)
  String? get loadingMessage => when(
    initial: () => null,
    loading: (message) => message,
    waitingForCode: (_, __, ___, ____, _____, ______, _______) => null,
    codeResent: (_, __, ___) => null,
    success: (_, __) => null,
    error: (_, __) => null,
    navigateBack: () => null,
  );
  
  /// Check if waiting for code input
  bool get isWaitingForCode => when(
    initial: () => false,
    loading: (_) => false,
    waitingForCode: (_, __, ___, ____, _____, ______, _______) => true,
    codeResent: (_, __, ___) => false,
    success: (_, __) => false,
    error: (_, __) => false,
    navigateBack: () => false,
  );
  
  /// Get phone number (if any)
  String? get phoneNumber => when(
    initial: () => null,
    loading: (_) => null,
    waitingForCode: (phoneNumber, _, __, ___, ____, _____, ______) => phoneNumber,
    codeResent: (phoneNumber, _, __) => phoneNumber,
    success: (_, __) => null,
    error: (_, __) => null,
    navigateBack: () => null,
  );
  
  /// Get verification ID (if any)
  String? get verificationId => when(
    initial: () => null,
    loading: (_) => null,
    waitingForCode: (_, verificationId, __, ___, ____, _____, ______) => verificationId,
    codeResent: (_, verificationId, __) => verificationId,
    success: (_, __) => null,
    error: (_, __) => null,
    navigateBack: () => null,
  );
  
  /// Get resend countdown (if any)
  int? get resendCountdown => when(
    initial: () => null,
    loading: (_) => null,
    waitingForCode: (_, __, countdown, ___, ____, _____, ______) => countdown,
    codeResent: (_, __, countdown) => countdown,
    success: (_, __) => null,
    error: (_, __) => null,
    navigateBack: () => null,
  );
  
  /// Check if can resend code
  bool get canResend => (resendCountdown ?? 1) <= 0;
  
  /// Get current entered code (if any)
  String? get currentCode => when(
    initial: () => null,
    loading: (_) => null,
    waitingForCode: (_, __, ___, code, ____, _____, ______) => code,
    codeResent: (_, __, ___) => null,
    success: (_, __) => null,
    error: (_, __) => null,
    navigateBack: () => null,
  );
}