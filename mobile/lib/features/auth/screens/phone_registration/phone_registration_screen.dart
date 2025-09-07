import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/utils/phone_validator.dart';
import '../../../../app/auto_router.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/vietnamese_sports_selector.dart';
import 'phone_registration_view_model.dart';
import 'phone_registration_state.dart';

@RoutePage()
class PhoneRegistrationScreen extends StatelessWidget {
  const PhoneRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PhoneRegistrationViewModel>()..initialize(),
      child: const _PhoneRegistrationView(),
    );
  }
}

class _PhoneRegistrationView extends StatefulWidget {
  const _PhoneRegistrationView();

  @override
  State<_PhoneRegistrationView> createState() => _PhoneRegistrationViewState();
}

class _PhoneRegistrationViewState extends State<_PhoneRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  List<String> _selectedSports = [];
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _phoneNumber = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged(String phone) {
    setState(() {
      _phoneNumber = phone;
    });
  }

  Future<void> _sendVerificationCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_nameController.text.trim().isEmpty) {
      _showError(AppLocalizations.of(context).errorEnterName);
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showError(AppLocalizations.of(context).errorPasswordMismatch);
      return;
    }

    // Normalize the phone number before sending
    final normalizedPhone = VietnamesePhoneValidator.normalizePhoneNumber(_phoneNumber);
    final viewModel = context.read<PhoneRegistrationViewModel>();

    await viewModel.sendVerificationCode(
      phoneNumber: normalizedPhone,
      name: _nameController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      preferredSports: _selectedSports,
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

  void _onSportsChanged(List<String> sports) {
    setState(() {
      _selectedSports = sports;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return BlocConsumer<PhoneRegistrationViewModel, PhoneRegistrationState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: (message) {},
          verificationCodeSent: (phoneNumber, verificationId, name, password, preferredSports) {
            _showSuccess('Mã xác thực đã được gửi đến $phoneNumber');
            // Navigate to SMS verification screen
            context.router.push(SmsVerificationRoute(
              phoneNumber: phoneNumber,
              userName: name,
              password: password,
              selectedSports: preferredSports,
            ));
          },
          success: (message) {
            _showSuccess(message ?? 'Thành công');
          },
          error: (message, errorCode) {
            _showError(message);
          },
          sportsUpdated: (sports) {},
          navigateToLogin: () {
            context.router.maybePop();
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.router.maybePop(),
            ),
            title: Text(
              'Đăng ký',
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
                        'Tạo tài khoản',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E5BDA),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Đăng ký để tham gia các nhóm thể thao',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Name Input
                      Text(
                        'Họ và tên',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Nhập họ và tên',
                          prefixIcon: const Icon(Icons.person_outline),
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
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập họ và tên';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
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
                          if (value.length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Confirm Password Input
                      Text(
                        l10n.confirmPassword,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_showConfirmPassword,
                        decoration: InputDecoration(
                          hintText: l10n.confirmPassword,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _showConfirmPassword = !_showConfirmPassword;
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
                            return 'Vui lòng xác nhận mật khẩu';
                          }
                          if (value != _passwordController.text) {
                            return 'Mật khẩu không khớp';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Sports Selector
                      Text(
                        'Môn thể thao yêu thích',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chọn tối đa 3 môn thể thao',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      VietnameseSportsSelector(
                        selectedSports: _selectedSports,
                        availableSports: const ['Bóng đá', 'Bóng rổ', 'Cầu lông', 'Bóng chuyền', 'Tennis', 'Bơi lội'],
                        onChanged: _onSportsChanged,
                        maxSelections: 3,
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _sendVerificationCode,
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
                                  'Gửi mã xác thực',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Login link
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Đã có tài khoản? ',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    context.router.maybePop();
                                  },
                                  child: Text(
                                    'Đăng nhập ngay',
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