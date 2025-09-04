import 'package:flutter/material.dart';
import 'dart:async';
import '../services/firebase_auth_service.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/verification_code_input.dart';

class SmsVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final String userName;
  final List<String> selectedSports;

  const SmsVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.userName,
    required this.selectedSports,
  });

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  final _firebaseAuthService = FirebaseAuthService();
  final _codeController = TextEditingController();
  
  bool _isLoading = false;
  bool _canResend = false;
  int _resendCountdown = 60;
  Timer? _timer;
  String? _newVerificationId;

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
      _showError('Vui lòng nhập đầy đủ 6 số');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Use the new verification ID if we've resent the code
      final verificationId = _newVerificationId ?? widget.verificationId;
      
      // Complete the registration flow
      final user = await _firebaseAuthService.completeRegistration(
        phoneNumber: widget.phoneNumber,
        verificationId: verificationId,
        smsCode: code,
        name: widget.userName,
        preferredSports: widget.selectedSports,
      );

      if (mounted) {
        _showSuccess('Đăng ký thành công! Chào mừng ${user.name}');
        
        // Navigate to home screen or onboarding
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      _showError(_getErrorMessage(e.toString()));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendCode() async {
    if (!_canResend) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _firebaseAuthService.sendSMSVerification(
        phoneNumber: widget.phoneNumber,
        onCodeSent: (String newVerificationId) {
          setState(() {
            _isLoading = false;
            _newVerificationId = newVerificationId;
          });
          _startResendCountdown();
          _showSuccess('Mã xác thực mới đã được gửi');
        },
        onError: (error) {
          setState(() {
            _isLoading = false;
          });
          _showError(_getErrorMessage(error.toString()));
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Không thể gửi lại mã. Vui lòng thử lại sau');
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('invalid-verification-code')) {
      return 'Mã xác thực không đúng. Vui lòng kiểm tra lại';
    } else if (error.contains('session-expired')) {
      return 'Phiên xác thực đã hết hạn. Vui lòng thử lại';
    } else if (error.contains('too-many-requests')) {
      return 'Bạn đã thử quá nhiều lần. Vui lòng đợi một chút';
    } else if (error.contains('phone-number') && error.contains('already')) {
      return 'Số điện thoại này đã được đăng ký';
    } else if (error.contains('Authentication failed')) {
      return 'Xác thực thất bại. Vui lòng thử lại';
    }
    return 'Có lỗi xảy ra. Vui lòng thử lại';
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

  void _onCodeChanged(String code) {
    _codeController.text = code;
    // Auto-verify when 6 digits are entered
    if (code.length == 6) {
      _verifyCode();
    }
  }

  String get _formattedPhoneNumber {
    return _firebaseAuthService.formatPhoneForDisplay(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Xác thực số điện thoại',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                // SMS Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E5BDA).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.sms_outlined,
                    size: 40,
                    color: Color(0xFF2E5BDA),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Title
                const Text(
                  'Nhập mã xác thực',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5BDA),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Description
                Text(
                  'Chúng tôi đã gửi mã xác thực 6 số đến',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _formattedPhoneNumber,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Verification Code Input
                VerificationCodeInput(
                  length: 6,
                  onChanged: _onCodeChanged,
                  onCompleted: (code) => _verifyCode(),
                ),
                
                const SizedBox(height: 32),
                
                // Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E5BDA),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Xác thực',
                      style: TextStyle(
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
                      'Không nhận được mã? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (_canResend)
                      GestureDetector(
                        onTap: _resendCode,
                        child: const Text(
                          'Gửi lại',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2E5BDA),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    else
                      Text(
                        'Gửi lại sau ${_resendCountdown}s',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                  ],
                ),
                
                const Spacer(),
                
                // Footer info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: const Color(0xFF2E5BDA),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Mã xác thực có hiệu lực trong 5 phút. Kiểm tra hộp thư spam nếu không thấy tin nhắn.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
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
  }
}