import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/utils/phone_validator.dart';
import '../../../../app/auto_router.dart';
import '../../widgets/loading_overlay.dart';
import '../../services/auth_service.dart';
import 'login_view_model.dart';
import 'login_state.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  final String? redirectRoute;
  
  const LoginScreen({
    super.key,
    this.redirectRoute,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isCheckingAuth = true;
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = getIt<AuthService>();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (mounted && isLoggedIn) {
        // User is already logged in, navigate to redirect route or groups list
        if (widget.redirectRoute != null) {
          context.router.pushNamed(widget.redirectRoute!);
        } else {
          context.router.push(const GroupsListRoute());
        }
        return;
      }
    } catch (e) {
      // Error checking auth state, continue to show login screen
    }
    
    if (mounted) {
      setState(() {
        _isCheckingAuth = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingAuth) {
      return const Scaffold(
        backgroundColor: Color(0xFF2E5BDA),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }
    
    return BlocProvider(
      create: (context) => getIt<LoginViewModel>()..initialize(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
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
    final viewModel = context.read<LoginViewModel>();
    
    await viewModel.loginWithPassword(
      phoneNumber: normalizedPhone,
      password: _passwordController.text,
      rememberMe: _rememberMe,
    );
  }

  Future<void> _loginWithBiometric() async {
    final viewModel = context.read<LoginViewModel>();
    await viewModel.loginWithBiometric();
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
    
    return BlocConsumer<LoginViewModel, LoginState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: (_) {},
          phoneVerificationRequired: (phoneNumber, verificationId) {
            // Navigate to SMS verification screen
            context.router.push(SmsVerificationRoute(
              phoneNumber: phoneNumber,
            ));
          },
          smsCodeSent: (phoneNumber, verificationId) {
            _showSuccess('Mã xác thực đã được gửi đến số điện thoại của bạn');
          },
          success: (message) {
            _showSuccess(message ?? 'Đăng nhập thành công');
            // Navigate to redirect route or groups list
            final parentContext = context.findAncestorStateOfType<_LoginScreenState>();
            if (parentContext != null && parentContext.widget.redirectRoute != null) {
              context.router.pushNamed(parentContext.widget.redirectRoute!);
            } else {
              context.router.replaceAll([const GroupsListRoute()]);
            }
          },
          error: (message, errorCode) {
            _showError(message);
          },
          navigateToRegistration: () {
            context.router.push(const PhoneRegistrationRoute());
          },
          navigateToForgotPassword: () {
            context.router.push(const ForgotPasswordRoute());
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: (_) => true,
          orElse: () => false,
        );
        
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
            isLoading: isLoading,
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
                              context.router.push(const ForgotPasswordRoute());
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
                          onPressed: isLoading ? null : _login,
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
                                    context.router.push(const PhoneRegistrationRoute());
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