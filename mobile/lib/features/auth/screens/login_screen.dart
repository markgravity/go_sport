import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../presentation/auth_wrapper.dart';
import '../widgets/loading_overlay.dart';
import '../../../core/utils/phone_validator.dart';
import 'phone_registration_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _showPassword = false;
  bool _rememberMe = false;
  String _phoneNumber = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged(String phone) {
    setState(() {
      _phoneNumber = phone;
    });
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final normalizedPhone = VietnamesePhoneValidator.normalizePhoneNumber(_phoneNumber);
    final authController = AuthController(context);
    
    try {
      final success = await authController.loginWithPassword(
        phoneNumber: normalizedPhone,
        password: _passwordController.text,
        rememberMe: _rememberMe,
      );
      
      if (success) {
        _showSuccess('Mã xác thực đã được gửi đến số điện thoại của bạn');
      } else {
        _showError('Đăng nhập thất bại. Vui lòng kiểm tra thông tin và thử lại.');
      }
    } catch (error) {
      _showError('Có lỗi xảy ra khi đăng nhập: $error');
    }
  }

  Future<void> _loginWithBiometric() async {
    try {
      // Biometric login would need to be implemented in AuthController
      _showError('Đăng nhập sinh trắc học chưa được triển khai trong kiến trúc mới');
    } catch (error) {
      _showError('Có lỗi xảy ra với đăng nhập sinh trắc học: $error');
    }
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return AuthWrapper(
      builder: (context, authState) {
        // Handle authentication state changes
        if (authState.isAuthenticated) {
          // Navigate to home screen when authenticated
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          });
        }

        if (authState.hasError) {
          // Show error message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showError(authState.displayMessage ?? 'Có lỗi xảy ra');
          });
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              l10n.login,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: LoadingOverlay(
            isLoading: authState.isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const SizedBox(height: 20),
                  
                  // Header
                  Text(
                    l10n.welcomeBack,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E5BDA),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.loginToYourAccount,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Phone Input
                  Text(
                    l10n.phoneNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      VietnamesePhoneValidator.createVietnamesePhoneFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintText: '0XXX XXX XXX',
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '+84',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2E5BDA)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    onChanged: _onPhoneNumberChanged,
                    validator: (value) {
                      return VietnamesePhoneValidator.getValidationErrorWithContext(value ?? '', l10n);
                    },
                  ),
                  
                  // Phone carrier info
                  if (_phoneNumber.isNotEmpty && VietnamesePhoneValidator.isValidVietnameseMobile(_phoneNumber))
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: Colors.blue.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.carrier(VietnamesePhoneValidator.getCarrierName(_phoneNumber) ?? l10n.unknownCarrier),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Password Input
                  Text(
                    l10n.password,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      hintText: l10n.enterPassword,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2E5BDA)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.errorEnterPassword;
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Remember me checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF2E5BDA),
                      ),
                      Text(
                        l10n.rememberMe,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          l10n.forgotPassword,
                          style: const TextStyle(
                            color: Color(0xFF2E5BDA),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authState.isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E5BDA),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: authState.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              l10n.login,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Biometric login option
                  Center(
                    child: TextButton.icon(
                      onPressed: _loginWithBiometric,
                      icon: const Icon(Icons.fingerprint),
                      label: Text(l10n.loginWithBiometric),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF2E5BDA),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Register link
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: l10n.dontHaveAccount,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PhoneRegistrationScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                l10n.registerNow,
                                style: const TextStyle(
                                  color: Color(0xFF2E5BDA),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}