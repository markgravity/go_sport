import 'package:flutter/services.dart';

/// Comprehensive Vietnamese phone number validation and formatting utility
class VietnamesePhoneValidator {
  // Vietnamese mobile carriers and their number patterns
  static const Map<String, List<String>> _carrierPrefixes = {
    'Viettel': ['032', '033', '034', '035', '036', '037', '038', '039'],
    'Vinaphone': ['081', '082', '083', '084', '085', '088'],
    'MobiFone': ['070', '071', '072', '073', '074', '075', '076', '077', '078', '079'],
    'Vietnamobile': ['052', '056', '058'],
    'Gmobile': ['059'],
    'Itelecom': ['087'],
  };

  // Complete regex for Vietnamese mobile numbers
  static final RegExp _mobileRegex = RegExp(
    r'^(\+84|84|0)(32|33|34|35|36|37|38|39|81|82|83|84|85|88|70|71|72|73|74|75|76|77|78|79|52|56|58|59|87)[0-9]{7}$'
  );

  // Landline regex for Vietnamese fixed-line numbers
  static final RegExp _landlineRegex = RegExp(
    r'^(\+84|84|0)(24|28|22|26|27|29|25|23)[0-9]{7,8}$'
  );

  /// Validates if the phone number is a valid Vietnamese mobile number
  static bool isValidVietnameseMobile(String phone) {
    final cleaned = _cleanPhoneNumber(phone);
    return _mobileRegex.hasMatch(cleaned);
  }

  /// Validates if the phone number is a valid Vietnamese landline number
  static bool isValidVietnameseLandline(String phone) {
    final cleaned = _cleanPhoneNumber(phone);
    return _landlineRegex.hasMatch(cleaned);
  }

  /// Validates if the phone number is any valid Vietnamese number (mobile or landline)
  static bool isValidVietnamesePhone(String phone) {
    return isValidVietnameseMobile(phone) || isValidVietnameseLandline(phone);
  }

  /// Gets the carrier name for a mobile number
  static String? getCarrierName(String phone) {
    if (!isValidVietnameseMobile(phone)) {
      return null;
    }

    final normalized = normalizePhoneNumber(phone);
    if (normalized.length < 12) return null;

    final prefix = normalized.substring(3, 6); // Get the 3-digit prefix after +84

    for (final entry in _carrierPrefixes.entries) {
      if (entry.value.contains(prefix)) {
        return entry.key;
      }
    }

    return null;
  }

  /// Normalizes phone number to +84XXXXXXXXX format
  static String normalizePhoneNumber(String phone) {
    String cleaned = _cleanPhoneNumber(phone);
    
    // Remove country code variations and normalize to +84
    if (cleaned.startsWith('+84')) {
      return cleaned;
    } else if (cleaned.startsWith('84')) {
      return '+$cleaned';
    } else if (cleaned.startsWith('0')) {
      return '+84${cleaned.substring(1)}';
    } else {
      return '+84$cleaned';
    }
  }

  /// Formats phone number for display with proper spacing
  static String formatForDisplay(String phone) {
    final normalized = normalizePhoneNumber(phone);
    
    if (normalized.length == 12 && normalized.startsWith('+84')) {
      final number = normalized.substring(3);
      // Format as: +84 XXX XXX XXX
      return '+84 ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6)}';
    }
    
    return phone; // Return original if can't format
  }

  /// Formats phone number for input mask display
  static String formatForInput(String phone) {
    final cleaned = _cleanPhoneNumber(phone);
    
    if (cleaned.isEmpty) return '';
    
    // Format as user types: 0XXX XXX XXX
    if (cleaned.startsWith('0') && cleaned.length <= 10) {
      String formatted = cleaned;
      if (formatted.length > 4) {
        formatted = '${formatted.substring(0, 4)} ${formatted.substring(4)}';
      }
      if (formatted.length > 8) {
        formatted = '${formatted.substring(0, 8)} ${formatted.substring(8)}';
      }
      return formatted;
    }
    
    return phone;
  }

  /// Gets validation error message in Vietnamese
  static String? getValidationError(String phone) {
    if (phone.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }

    final cleaned = _cleanPhoneNumber(phone);
    
    if (cleaned.length < 9) {
      return 'Số điện thoại quá ngắn';
    }
    
    if (cleaned.length > 12) {
      return 'Số điện thoại quá dài';
    }

    if (!isValidVietnamesePhone(phone)) {
      return 'Số điện thoại không đúng định dạng Việt Nam';
    }

    return null; // Valid
  }

  /// Gets the phone number type (mobile/landline)
  static PhoneType getPhoneType(String phone) {
    if (isValidVietnameseMobile(phone)) {
      return PhoneType.mobile;
    } else if (isValidVietnameseLandline(phone)) {
      return PhoneType.landline;
    } else {
      return PhoneType.invalid;
    }
  }

  /// Cleans phone number by removing all non-digit characters except +
  static String _cleanPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'[^\d+]'), '');
  }

  /// Creates a phone input formatter for Vietnamese numbers
  static TextInputFormatter createVietnamesePhoneFormatter() {
    return _VietnamesePhoneInputFormatter();
  }

  /// Checks if the number is from a major carrier (for premium features)
  static bool isMajorCarrier(String phone) {
    final carrier = getCarrierName(phone);
    return ['Viettel', 'Vinaphone', 'MobiFone'].contains(carrier);
  }

  /// Gets all supported prefixes for auto-completion
  static List<String> getAllSupportedPrefixes() {
    return _carrierPrefixes.values
        .expand((prefixes) => prefixes)
        .map((prefix) => '0$prefix')
        .toList()
      ..sort();
  }
}

enum PhoneType { mobile, landline, invalid }

/// Custom input formatter for Vietnamese phone numbers
class _VietnamesePhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    
    // Only allow digits and + at the start
    String cleaned = text.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Limit length
    if (cleaned.length > 12) {
      cleaned = cleaned.substring(0, 12);
    }

    // Auto-format as user types
    String formatted = cleaned;
    
    // If starts with 0 (Vietnamese format)
    if (cleaned.startsWith('0') && cleaned.length > 4) {
      formatted = VietnamesePhoneValidator.formatForInput(cleaned);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Phone validation result with detailed information
class PhoneValidationResult {
  final bool isValid;
  final String? errorMessage;
  final String? carrier;
  final PhoneType type;
  final String normalizedNumber;
  final String displayFormat;

  const PhoneValidationResult({
    required this.isValid,
    this.errorMessage,
    this.carrier,
    required this.type,
    required this.normalizedNumber,
    required this.displayFormat,
  });

  factory PhoneValidationResult.validate(String phone) {
    final isValid = VietnamesePhoneValidator.isValidVietnamesePhone(phone);
    final errorMessage = VietnamesePhoneValidator.getValidationError(phone);
    final carrier = VietnamesePhoneValidator.getCarrierName(phone);
    final type = VietnamesePhoneValidator.getPhoneType(phone);
    final normalized = VietnamesePhoneValidator.normalizePhoneNumber(phone);
    final display = VietnamesePhoneValidator.formatForDisplay(phone);

    return PhoneValidationResult(
      isValid: isValid,
      errorMessage: errorMessage,
      carrier: carrier,
      type: type,
      normalizedNumber: normalized,
      displayFormat: display,
    );
  }
}