import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../services/auth_service.dart';
import 'phone_registration_state.dart';

/// ViewModel for Phone Registration Screen using Cubit pattern
/// 
/// Handles Vietnamese phone registration form validation and SMS sending
/// Supports Vietnamese sports preferences and cultural patterns
@injectable
class PhoneRegistrationViewModel extends Cubit<PhoneRegistrationState> {
  final AuthService _authService;
  
  PhoneRegistrationViewModel(
    this._authService,
  ) : super(const PhoneRegistrationState.initial());

  /// Initialize registration screen with default state
  void initialize() {
    emit(const PhoneRegistrationState.initial());
  }

  /// Send verification code to Vietnamese phone number for registration
  Future<void> sendVerificationCode({
    required String phoneNumber,
    required String name,
    required String password,
    required String confirmPassword,
    List<String>? preferredSports,
  }) async {
    // Validate inputs first
    final validationError = _validateRegistrationForm(
      name: name,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
    );
    
    if (validationError != null) {
      emit(PhoneRegistrationState.error(message: validationError));
      return;
    }

    emit(const PhoneRegistrationState.loading(
      message: 'Đang gửi mã xác thực...'
    ));
    
    try {
      final verificationId = await _authService.sendSMSVerification(
        phoneNumber: phoneNumber,
      );
      
      emit(PhoneRegistrationState.verificationCodeSent(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        name: name,
        password: password,
        preferredSports: preferredSports ?? [],
      ));
    } catch (error) {
      emit(PhoneRegistrationState.error(
        message: 'Có lỗi xảy ra khi gửi mã xác thực: $error',
      ));
    }
  }

  /// Complete registration with SMS verification code
  Future<void> completeRegistration({
    required String phoneNumber,
    required String verificationId,
    required String smsCode,
    required String name,
    required String password,
    List<String>? preferredSports,
  }) async {
    emit(const PhoneRegistrationState.loading(
      message: 'Đang xác thực và tạo tài khoản...'
    ));
    
    try {
      await _authService.register(
        phoneNumber: phoneNumber,
        name: name,
        password: password,
        verificationId: verificationId,
        smsCode: smsCode,
        preferredSports: preferredSports,
      );
      emit(PhoneRegistrationState.success(
        message: 'Đăng ký thành công! Chào mừng bạn đến với Go Sport.',
      ));
    } catch (error) {
      emit(PhoneRegistrationState.error(
        message: 'Có lỗi xảy ra khi đăng ký: $error',
      ));
    }
  }

  /// Update selected sports preferences
  void updateSportsPreferences(List<String> sports) {
    emit(PhoneRegistrationState.sportsUpdated(sports: sports));
  }

  /// Clear current error state
  void clearError() {
    state.when(
      initial: () {},
      loading: (_) {},
      verificationCodeSent: (_, __, ___, ____, _____) {},
      sportsUpdated: (_) {},
      success: (_) {},
      error: (_, __) => emit(const PhoneRegistrationState.initial()),
      navigateToLogin: () {},
    );
  }

  /// Navigate to login screen
  void navigateToLogin() {
    emit(const PhoneRegistrationState.navigateToLogin());
  }

  /// Validate registration form inputs with Vietnamese patterns
  String? _validateRegistrationForm({
    required String name,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) {
    // Validate name
    if (name.trim().isEmpty) {
      return 'Vui lòng nhập họ và tên của bạn';
    }
    
    if (name.trim().length < 2) {
      return 'Họ tên phải có ít nhất 2 ký tự';
    }

    // Validate Vietnamese phone number
    if (phoneNumber.trim().isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    
    // Basic Vietnamese phone validation
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!RegExp(r'^(0|84|\+84)[3-9]\d{8}$').hasMatch(cleanPhone)) {
      return 'Số điện thoại không đúng định dạng Việt Nam';
    }

    // Validate password
    if (password.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    
    if (password.length < 8) {
      return 'Mật khẩu phải có ít nhất 8 ký tự';
    }

    // Validate password confirmation
    if (confirmPassword.isEmpty) {
      return 'Vui lòng xác nhận mật khẩu';
    }
    
    if (password != confirmPassword) {
      return 'Xác nhận mật khẩu không khớp';
    }

    return null; // No validation errors
  }
}