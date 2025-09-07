import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import 'dart:async';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../app/auto_router.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/verification_code_input.dart';
import 'sms_verification_view_model.dart';
import 'sms_verification_state.dart';

@RoutePage()
class SmsVerificationScreen extends StatelessWidget {
  final String? phoneNumber;
  final String? userName;
  final String? password;
  final List<String> selectedSports;

  const SmsVerificationScreen({
    super.key,
    @queryParam this.phoneNumber,
    @queryParam this.userName,
    @queryParam this.password,
    @queryParam this.selectedSports = const [],
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final viewModel = getIt<SmsVerificationViewModel>();
        // Initialize with phone number and verification ID if available
        if (phoneNumber != null) {
          viewModel.initialize(
            phoneNumber: phoneNumber!,
            verificationId: '', // This should come from the previous screen
            userName: userName,
            userPassword: password,
            preferredSports: selectedSports,
          );
        }
        return viewModel;
      },
      child: const _SmsVerificationView(),
    );
  }
}

class _SmsVerificationView extends StatefulWidget {
  const _SmsVerificationView();

  @override
  State<_SmsVerificationView> createState() => _SmsVerificationViewState();
}

class _SmsVerificationViewState extends State<_SmsVerificationView> {
  final _codeController = TextEditingController();
  
  bool _canResend = false;
  int _resendCountdown = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();
    if (code.length != 6) {
      _showError(AppLocalizations.of(context).errorEnterFullCode);
      return;
    }

    final viewModel = context.read<SmsVerificationViewModel>();
    final currentState = viewModel.state;
    
    currentState.maybeWhen(
      waitingForCode: (phoneNumber, verificationId, _, __, userName, userPassword, preferredSports) {
        viewModel.verifyCode(
          smsCode: code,
          phoneNumber: phoneNumber,
          verificationId: verificationId,
          userName: userName,
          userPassword: userPassword,
          preferredSports: preferredSports,
        );
      },
      orElse: () {
        _showError('Không thể xác thực mã. Vui lòng thử lại.');
      },
    );
  }

  Future<void> _resendCode() async {
    if (!_canResend) return;
    
    final viewModel = context.read<SmsVerificationViewModel>();
    final currentState = viewModel.state;
    
    currentState.maybeWhen(
      waitingForCode: (phoneNumber, _, __, ___, ____, _____, ______) {
        viewModel.resendCode(phoneNumber: phoneNumber);
        _startResendCountdown();
      },
      orElse: () {
        _showError('Không thể gửi lại mã. Vui lòng thử lại.');
      },
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String _formatPhoneForDisplay(String phoneNumber) {
    // Format Vietnamese phone number for display
    if (phoneNumber.startsWith('+84')) {
      final number = phoneNumber.substring(3);
      if (number.length >= 9) {
        return '+84 ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6)}';
      }
    }
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return BlocConsumer<SmsVerificationViewModel, SmsVerificationState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: (message) {},
          success: (message, isRegistration) {
            _showSuccess(message);
            // Navigate to groups list or home screen
            context.router.replaceAll([const GroupsListRoute()]);
          },
          error: (message, errorCode) {
            _showError(message);
          },
          codeResent: (phoneNumber) {
            _showSuccess('Mã xác thực đã được gửi lại đến $phoneNumber');
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: (_) => true,
          orElse: () => false,
        );
        
        final phoneNumber = state.maybeWhen(
          waitingForCode: (phone, _, __, ___, ____, _____, ______) => phone,
          orElse: () => widget.phoneNumber ?? '',
        );
        
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.router.pop(),
            ),
            title: Text(
              l10n.smsVerification,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: LoadingOverlay(
            isLoading: isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E5BDA).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.sms,
                        size: 40,
                        color: Color(0xFF2E5BDA),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Title
                    Text(
                      l10n.enterVerificationCode,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Subtitle
                    Text(
                      l10n.codeSentTo(_formatPhoneForDisplay(phoneNumber)),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Code Input
                    VerificationCodeInput(
                      controller: _codeController,
                      length: 6,
                      onCompleted: (_) => _verifyCode(),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Verify Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _verifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E5BDA),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                l10n.verify,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Resend Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.didntReceiveCode,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: _canResend ? _resendCode : null,
                          child: Text(
                            _canResend
                                ? l10n.resend
                                : l10n.resendIn(_resendCountdown.toString()),
                            style: TextStyle(
                              color: _canResend ? const Color(0xFF2E5BDA) : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Info Text
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.smsVerificationInfo,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue.shade700,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}