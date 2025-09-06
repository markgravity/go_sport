import 'package:flutter_test/flutter_test.dart';
import 'package:go_sport_app/core/utils/phone_validator.dart';

/// Test Vietnamese phone validation functionality
/// 
/// Verifies that Vietnamese phone numbers work correctly in new architecture
void main() {
  group('VietnamesePhoneValidator', () {
    test('validates common Vietnamese phone numbers correctly', () {
      const validPhones = [
        '0701234567',    // MobiFone (70 prefix)
        '0387654321',    // Viettel (38 prefix) 
        '0881234567',    // Vinaphone (88 prefix)
        '0521555555',    // Vietnamobile (52 prefix)
        '0591888777',    // Gmobile (59 prefix)
        '0321234567',    // Viettel (32 prefix)
        '0811234567',    // Vinaphone (81 prefix)
      ];

      for (final phone in validPhones) {
        final isValid = VietnamesePhoneValidator.isValidVietnameseMobile(phone);
        expect(isValid, isTrue, reason: 'Phone $phone should be valid');
      }
    });

    test('normalizes Vietnamese phone numbers to international format', () {
      final normalizeTests = {
        '0387654321': '+84387654321',
        '84387654321': '+84387654321', 
        '+84387654321': '+84387654321',
        '0701234567': '+84701234567',
        '0881234567': '+84881234567',
      };

      normalizeTests.forEach((input, expected) {
        final normalized = VietnamesePhoneValidator.normalizePhoneNumber(input);
        expect(normalized, equals(expected),
          reason: 'Phone $input should normalize to $expected');
      });
    });

    test('detects carriers correctly', () {
      final carrierTests = {
        '0701234567': 'MobiFone',
        '0387654321': 'Viettel',
        '0881234567': 'Vinaphone', 
        '0521555555': 'Vietnamobile',
        '0591888777': 'Gmobile',
        '0321234567': 'Viettel',
        '0811234567': 'Vinaphone',
      };

      carrierTests.forEach((phone, expectedCarrier) {
        final carrier = VietnamesePhoneValidator.getCarrierName(phone);
        expect(carrier, equals(expectedCarrier),
          reason: 'Phone $phone should be detected as $expectedCarrier');
      });
    });

    test('rejects invalid phone numbers', () {
      const invalidPhones = [
        '1234567890',     // Wrong country
        '0123456',        // Too short
        '01234567890',    // Too long  
        '0123456789',     // Invalid prefix (12 not in list)
        '+1234567890',    // Wrong country code
        'abcdefghij',     // Non-numeric
        '0000000000',     // All zeros (00 not in list)
        '9876543210',     // No leading zero
        '0987654321',     // Invalid prefix (98 not in list)
      ];

      for (final phone in invalidPhones) {
        final isValid = VietnamesePhoneValidator.isValidVietnameseMobile(phone);
        expect(isValid, isFalse, reason: 'Phone $phone should be invalid');
      }
    });

    test('handles edge cases gracefully', () {
      // Empty and null strings
      expect(VietnamesePhoneValidator.isValidVietnameseMobile(''), isFalse);
      expect(VietnamesePhoneValidator.getCarrierName(''), isNull);
      
      // Whitespace - note: the validator cleans whitespace, so this should work
      expect(VietnamesePhoneValidator.isValidVietnameseMobile('  0387654321  '), isTrue);
      
      // Special characters
      expect(VietnamesePhoneValidator.isValidVietnameseMobile('098-765-4321'), isFalse);
      expect(VietnamesePhoneValidator.isValidVietnameseMobile('(098) 765 4321'), isFalse);
    });
  });
}