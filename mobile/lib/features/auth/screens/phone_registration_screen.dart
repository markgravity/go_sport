import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../services/phone_auth_service.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/vietnamese_sports_selector.dart';
import 'sms_verification_screen.dart';

class PhoneRegistrationScreen extends StatefulWidget {
  const PhoneRegistrationScreen({super.key});

  @override
  State<PhoneRegistrationScreen> createState() => _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneAuthService = PhoneAuthService();
  
  bool _isLoading = false;
  String _phoneNumber = '';
  final String _countryCode = '+84';
  List<String> _selectedSports = [];
  bool _showPassword = false;
  bool _showConfirmPassword = false;

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
      _phoneNumber = '$_countryCode$phone';
    });
  }


  Future<void> _sendVerificationCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_nameController.text.trim().isEmpty) {
      _showError('Vui lòng nhập tên của bạn');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showError('Mật khẩu xác nhận không khớp');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await _phoneAuthService.sendVerificationCode(
      phoneNumber: _phoneNumber,
      onSuccess: (message) {
        setState(() {
          _isLoading = false;
        });
        
        _showSuccess(message);
        
        // Navigate to SMS verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SmsVerificationScreen(
              phoneNumber: _phoneNumber,
              userName: _nameController.text.trim(),
              password: _passwordController.text,
              selectedSports: _selectedSports,
            ),
          ),
        );
      },
      onError: (error) {
        setState(() {
          _isLoading = false;
        });
        _showError(error);
      },
    );
  }

  void _onSportsChanged(List<String> sports) {
    setState(() {
      _selectedSports = sports;
    });
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
          'Đăng ký tài khoản',
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // Header
                  const Text(
                    'Tạo tài khoản Go Sport',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E5BDA),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nhập thông tin để tạo tài khoản mới',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Name Input
                  const Text(
                    'Tên của bạn',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Nguyễn Văn A',
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
                        return 'Vui lòng nhập tên của bạn';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Phone Input
                  const Text(
                    'Số điện thoại',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  IntlPhoneField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: 'Nhập số điện thoại',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2E5BDA)),
                      ),
                    ),
                    initialCountryCode: 'VN',
                    showCountryFlag: false,
                    showDropdownIcon: false,
                    disableLengthCheck: true,
                    onChanged: (phone) {
                      // Country is locked to VN, so always use +84
                      _onPhoneNumberChanged(phone.number);
                    },
                    validator: (phone) {
                      if (phone == null || phone.number.isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      final fullNumber = '$_countryCode${phone.number}';
                      if (!_phoneAuthService.isValidVietnamesePhone(fullNumber)) {
                        return 'Số điện thoại không đúng định dạng Việt Nam';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Password Input
                  const Text(
                    'Mật khẩu',
                    style: TextStyle(
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
                      hintText: 'Nhập mật khẩu',
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
                        return 'Vui lòng nhập mật khẩu';
                      }
                      if (value.length < 8) {
                        return 'Mật khẩu phải có ít nhất 8 ký tự';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Confirm Password Input
                  const Text(
                    'Xác nhận mật khẩu',
                    style: TextStyle(
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
                      hintText: 'Nhập lại mật khẩu',
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
                        return 'Mật khẩu xác nhận không khớp';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sports Selection
                  const Text(
                    'Môn thể thao yêu thích (tùy chọn)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  VietnameseSportsSelector(
                    availableSports: PhoneAuthService.vietnameseSportsList,
                    selectedSports: _selectedSports,
                    onChanged: _onSportsChanged,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _sendVerificationCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E5BDA),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Gửi mã xác thực',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Terms and Privacy
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Bằng cách đăng ký, bạn đồng ý với ',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                        children: [
                          TextSpan(
                            text: 'Điều khoản sử dụng',
                            style: TextStyle(
                              color: const Color(0xFF2E5BDA),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' và '),
                          TextSpan(
                            text: 'Chính sách bảo mật',
                            style: TextStyle(
                              color: const Color(0xFF2E5BDA),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' của chúng tôi.'),
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
  }
}