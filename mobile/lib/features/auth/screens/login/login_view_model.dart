import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../services/firebase_auth_service.dart';
import 'login_state.dart';

/// ViewModel for Login Screen using Cubit pattern
/// 
/// Handles login form validation and authentication logic
/// Provides Vietnamese phone number validation and cultural patterns
@injectable
class LoginViewModel extends Cubit<LoginState> {
  final FirebaseAuthService _firebaseAuthService;
  
  LoginViewModel(
    this._firebaseAuthService,
  ) : super(const LoginState.initial());

  /// Initialize login screen with default state
  void initialize() {
    emit(const LoginState.initial());
  }

  /// Validate and login with Vietnamese phone number and password
  Future<void> loginWithPassword({
    required String phoneNumber,
    required String password,
    bool rememberMe = false,
  }) async {
    emit(const LoginState.loading(message: 'Đang đăng nhập...'));
    
    try {
      // For now, forward to SMS verification flow
      // This would need proper password authentication in the future
      final verificationId = await sendVerificationCode(phoneNumber);
      
      if (verificationId != null) {
        emit(LoginState.phoneVerificationRequired(
          phoneNumber: phoneNumber,
          verificationId: verificationId,
        ));
      } else {
        emit(const LoginState.error(
          message: 'Không thể gửi mã xác thực. Vui lòng thử lại.',
        ));
      }
    } catch (error) {
      emit(LoginState.error(
        message: 'Có lỗi xảy ra khi đăng nhập: $error',
      ));
    }
  }

  /// Send SMS verification code to Vietnamese phone number
  Future<String?> sendVerificationCode(String phoneNumber) async {
    try {
      await _firebaseAuthService.sendSMSVerification(
        phoneNumber: phoneNumber,
        onCodeSent: (verificationId) {
          emit(LoginState.smsCodeSent(
            phoneNumber: phoneNumber,
            verificationId: verificationId,
          ));
        },
        onError: (error) {
          emit(LoginState.error(
            message: 'Không thể gửi mã xác thực: $error',
          ));
        },
      );
      return 'SMS_SENT'; // Placeholder return value
    } catch (error) {
      emit(LoginState.error(
        message: 'Không thể gửi mã xác thực: $error',
      ));
      return null;
    }
  }

  /// Login with biometric authentication
  Future<void> loginWithBiometric() async {
    emit(const LoginState.loading(message: 'Đang xác thực sinh trắc học...'));
    
    try {
      // Biometric login implementation would go here
      emit(const LoginState.error(
        message: 'Đăng nhập sinh trắc học chưa được triển khai',
      ));
    } catch (error) {
      emit(LoginState.error(
        message: 'Có lỗi xảy ra với xác thực sinh trắc học: $error',
      ));
    }
  }

  /// Clear current error state
  void clearError() {
    state.when(
      initial: () {},
      loading: (_) {},
      success: (_) {},
      error: (_, __) => emit(const LoginState.initial()),
      smsCodeSent: (_, __) => emit(const LoginState.initial()),
      navigateToRegistration: () {},
      navigateToForgotPassword: () {},
      phoneVerificationRequired: (_, __) {},
    );
  }

  /// Navigate to registration screen
  void navigateToRegistration() {
    // This would trigger navigation in the UI layer
    emit(const LoginState.navigateToRegistration());
  }

  /// Navigate to forgot password screen
  void navigateToForgotPassword() {
    // This would trigger navigation in the UI layer
    emit(const LoginState.navigateToForgotPassword());
  }
}