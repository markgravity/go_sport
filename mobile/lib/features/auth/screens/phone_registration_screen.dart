import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/vietnamese_sports_selector.dart';
import '../../../core/utils/phone_validator.dart';
import '../../../core/dependency_injection/injection_container.dart';
import '../../../core/services/sports_localization_service.dart';
import '../services/phone_auth_service.dart';
import 'phone_registration/phone_registration_view_model.dart';
import 'phone_registration/phone_registration_state.dart';
import 'sms_verification_screen.dart';

class PhoneRegistrationScreen extends StatelessWidget {
  const PhoneRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.createPhoneRegistrationViewModel(),
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
  
  // Temporary variables for backward compatibility
  String get _phoneNumber => _phoneController.text;
  bool _isLoading = false;
  
  // Use dependency injection to get the service
  late final _phoneAuthService = getIt<PhoneAuthService>();

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged(String phone) {
    // No state change needed - phone is stored in controller
    // The getter _phoneNumber will get the value from the controller
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

    setState(() {
      _isLoading = true;
    });

    await _phoneAuthService.sendVerificationCode(
      phoneNumber: normalizedPhone,
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
              phoneNumber: normalizedPhone,
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
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.registerAccount,
          style: const TextStyle(
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
                  Text(
                    l10n.createGoSportAccount,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E5BDA),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.enterInfoToRegister,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Name Input
                  Text(
                    l10n.yourName,
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
                      hintText: l10n.namePlaceholder,
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
                        return l10n.errorEnterName;
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
                    onChanged: (value) {
                      _onPhoneNumberChanged(value);
                    },
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
                      if (value.length < 8) {
                        return l10n.errorPasswordTooShort;
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
                      hintText: l10n.reenterPassword,
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
                        return l10n.errorConfirmPassword;
                      }
                      if (value != _passwordController.text) {
                        return l10n.errorPasswordMismatch;
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sports Selection
                  Text(
                    l10n.favoriteSports,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  VietnameseSportsSelector(
                    availableSports: SportsLocalizationService.getSportsListForLocale(l10n),
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
                          : Text(
                              l10n.sendVerificationCode,
                              style: const TextStyle(
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
                        text: l10n.agreeToTerms,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                        children: [
                          TextSpan(
                            text: l10n.termsOfService,
                            style: const TextStyle(
                              color: Color(0xFF2E5BDA),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: l10n.and),
                          TextSpan(
                            text: l10n.privacyPolicy,
                            style: const TextStyle(
                              color: Color(0xFF2E5BDA),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: '.'),
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