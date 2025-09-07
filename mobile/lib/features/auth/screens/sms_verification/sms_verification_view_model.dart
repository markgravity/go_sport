import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';

import '../../services/firebase_auth_service.dart';
import '../../services/auth_service.dart';
import 'sms_verification_state.dart';

/// ViewModel for SMS Verification Screen using Cubit pattern
/// 
/// Handles Vietnamese SMS verification code validation and resend logic
/// Supports Vietnamese cultural patterns for phone verification
@injectable
class SmsVerificationViewModel extends Cubit<SmsVerificationState> {
  final FirebaseAuthService _firebaseAuthService;
  final AuthService _authService;
  Timer? _countdownTimer;
  
  SmsVerificationViewModel(
    this._firebaseAuthService,
    this._authService,
  ) : super(const SmsVerificationState.initial());

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }

  /// Initialize SMS verification screen with phone number
  void initialize({
    required String phoneNumber,
    required String verificationId,
    String? userName,
    String? userPassword,
    List<String>? preferredSports,
  }) {
    emit(SmsVerificationState.waitingForCode(
      phoneNumber: phoneNumber,
      verificationId: verificationId,
      userName: userName,
      userPassword: userPassword,
      preferredSports: preferredSports ?? [],
      resendCountdown: 60, // 60 seconds countdown
    ));
    _startResendCountdown();
  }

  /// Verify SMS code and complete authentication
  Future<void> verifyCode({
    required String smsCode,
    required String phoneNumber,
    required String verificationId,
    String? userName,
    String? userPassword,
    List<String>? preferredSports,
  }) async {
    // Validate SMS code format
    if (smsCode.length != 6 || !RegExp(r'^\d{6}$').hasMatch(smsCode)) {
      emit(const SmsVerificationState.error(
        message: 'Mã xác thực phải có đúng 6 số',
      ));
      return;
    }

    emit(const SmsVerificationState.loading(
      message: 'Đang xác thực mã...'
    ));
    
    try {
      if (userName != null && userPassword != null) {
        // This is registration flow
        final success = await _authService.completeRegistration(
          phoneNumber: phoneNumber,
          verificationId: verificationId,
          smsCode: smsCode,
          name: userName,
          password: userPassword,
          preferredSports: preferredSports,
        );
        
        if (success) {
          emit(SmsVerificationState.success(
            message: 'Đăng ký thành công! Chào mừng bạn đến với Go Sport.',
            isRegistration: true,
          ));
        } else {
          emit(const SmsVerificationState.error(
            message: 'Mã xác thực không chính xác. Vui lòng thử lại.',
          ));
        }
      } else {
        // This is login flow
        final success = await _authService.verifyPhoneNumber(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        
        if (success) {
          emit(const SmsVerificationState.success(
            message: 'Đăng nhập thành công!',
            isRegistration: false,
          ));
        } else {
          emit(const SmsVerificationState.error(
            message: 'Mã xác thực không chính xác. Vui lòng thử lại.',
          ));
        }
      }
    } catch (error) {
      String errorMessage = 'Có lỗi xảy ra khi xác thực';
      
      // Handle specific Firebase auth errors with Vietnamese messages
      if (error.toString().contains('invalid-verification-code')) {
        errorMessage = 'Mã xác thực không chính xác';
      } else if (error.toString().contains('session-expired')) {
        errorMessage = 'Phiên xác thực đã hết hạn. Vui lòng gửi lại mã mới.';
      } else if (error.toString().contains('too-many-requests')) {
        errorMessage = 'Quá nhiều yêu cầu. Vui lòng đợi một lúc rồi thử lại.';
      }
      
      emit(SmsVerificationState.error(message: errorMessage));
    }
  }

  /// Resend verification code to phone number
  Future<void> resendCode({
    required String phoneNumber,
  }) async {
    emit(const SmsVerificationState.loading(
      message: 'Đang gửi lại mã xác thực...'
    ));
    
    try {
      final newVerificationId = await _firebaseAuthService.sendVerificationCode(phoneNumber);
      
      if (newVerificationId != null) {
        emit(SmsVerificationState.codeResent(
          phoneNumber: phoneNumber,
          verificationId: newVerificationId,
          resendCountdown: 60, // Reset countdown
        ));
        _startResendCountdown();
      } else {
        emit(const SmsVerificationState.error(
          message: 'Không thể gửi lại mã xác thực. Vui lòng thử lại sau.',
        ));
      }
    } catch (error) {
      emit(SmsVerificationState.error(
        message: 'Có lỗi xảy ra khi gửi lại mã: $error',
      ));
    }
  }

  /// Update SMS code input
  void updateCode(String code) {
    if (state is SmsVerificationStateWaitingForCode) {
      final currentState = state as SmsVerificationStateWaitingForCode;
      emit(currentState.copyWith(currentCode: code));
    }
  }

  /// Clear current error state
  void clearError() {
    if (state is SmsVerificationStateError) {
      // Return to waiting for code state
      emit(const SmsVerificationState.waitingForCode(
        phoneNumber: '',
        verificationId: '',
        resendCountdown: 0,
      ));
    }
  }

  /// Navigate back to previous screen
  void navigateBack() {
    _countdownTimer?.cancel();
    emit(const SmsVerificationState.navigateBack());
  }

  /// Start countdown timer for resend button
  void _startResendCountdown() {
    _countdownTimer?.cancel();
    
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state is SmsVerificationStateWaitingForCode) {
          final currentState = state as SmsVerificationStateWaitingForCode;
          final newCountdown = currentState.resendCountdown - 1;
          
          if (newCountdown <= 0) {
            timer.cancel();
            emit(currentState.copyWith(resendCountdown: 0));
          } else {
            emit(currentState.copyWith(resendCountdown: newCountdown));
          }
        } else {
          timer.cancel();
        }
      },
    );
  }
}