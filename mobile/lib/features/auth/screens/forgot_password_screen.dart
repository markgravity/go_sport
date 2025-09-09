import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/network/api_client.dart';
import '../../../core/dependency_injection/injection_container.dart';
import '../../../core/utils/phone_validator.dart';
import '../../../widgets/go_sport_logo.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/verification_code_input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _codeSent = false;
  bool _codeVerified = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  String? _verificationCode;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.resetPassword,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                const Center(
                  child: GoSportLogo(size: 80),
                ),
                const SizedBox(height: 32),

                if (!_codeSent) ..._buildPhoneStep(l10n, theme),
                if (_codeSent && !_codeVerified) ..._buildCodeStep(l10n, theme),
                if (_codeVerified) ..._buildPasswordStep(l10n, theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPhoneStep(AppLocalizations l10n, ThemeData theme) {
    return [
      Text(
        l10n.enterPhoneToReset,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24),

      // Phone number input
      TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        inputFormatters: [VietnamesePhoneValidator.createVietnamesePhoneFormatter()],
        decoration: InputDecoration(
          labelText: l10n.phoneNumber,
          prefixIcon: const Icon(Icons.phone),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return l10n.errorEnterPhone;
          }
          if (!VietnamesePhoneValidator.isValidVietnamesePhone(value)) {
            return l10n.errorInvalidVietnamesePhone;
          }
          return null;
        },
      ),
      const SizedBox(height: 32),

      // Send code button
      ElevatedButton(
        onPressed: _sendResetCode,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          l10n.sendResetCode,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildCodeStep(AppLocalizations l10n, ThemeData theme) {
    return [
      Text(
        l10n.enterResetCode,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),

      Text(
        l10n.resetCodeSent,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24),

      // Verification code input
      VerificationCodeInput(
        length: 6,
        onCompleted: (code) {
          _verificationCode = code;
          _verifyResetCode();
        },
        onChanged: (value) {
          _verificationCode = value;
        },
      ),
      const SizedBox(height: 24),

      // Verify button
      ElevatedButton(
        onPressed: _verificationCode?.length == 6 ? _verifyResetCode : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          l10n.verify,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildPasswordStep(AppLocalizations l10n, ThemeData theme) {
    return [
      Text(
        l10n.enterNewPassword,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 24),

      // New password input
      TextFormField(
        controller: _newPasswordController,
        obscureText: _obscureNewPassword,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: l10n.newPassword,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(_obscureNewPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
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
      const SizedBox(height: 16),

      // Confirm password input
      TextFormField(
        controller: _confirmPasswordController,
        obscureText: _obscureConfirmPassword,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: l10n.confirmNewPassword,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          ),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return l10n.errorConfirmPassword;
          }
          if (value != _newPasswordController.text) {
            return l10n.errorPasswordMismatch;
          }
          return null;
        },
      ),
      const SizedBox(height: 32),

      // Update password button
      ElevatedButton(
        onPressed: _updatePassword,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          l10n.updatePassword,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  Future<void> _sendResetCode() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final apiClient = getIt<ApiClient>();
      final response = await apiClient.post('/auth/password-reset-request', 
        data: {
          'phone': _phoneController.text,
        });

      if (response.data['success'] == true) {
        setState(() => _codeSent = true);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.data['message'] ?? 'Mã đã được gửi'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _verifyResetCode() async {
    if (_verificationCode?.length != 6) return;

    setState(() => _isLoading = true);

    try {
      // For now, we'll just simulate verification and proceed to password step
      // In a real implementation, you might want to validate the code on the server first
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _codeVerified = true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final apiClient = getIt<ApiClient>();
      final response = await apiClient.post('/auth/password-reset-confirm',
        data: {
          'phone': _phoneController.text,
          'verification_code': _verificationCode,
          'new_password': _newPasswordController.text,
          'new_password_confirmation': _confirmPasswordController.text,
        });

      if (response.data['success'] == true) {
        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Đặt lại mật khẩu thành công'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          );
          
          // Navigate back to login
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}