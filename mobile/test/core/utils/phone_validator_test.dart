import 'package:flutter_test/flutter_test.dart';
import 'package:go_sport_app/core/utils/phone_validator.dart';

void main() {
  group('VietnamesePhoneValidator', () {
    group('Phone number validation', () {
      test('validates Vietnamese mobile numbers correctly', () {
        // Viettel numbers
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0323456789'), isTrue);
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('+84323456789'), isTrue);
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('84323456789'), isTrue);
        
        // Vinaphone numbers
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0812345678'), isTrue);
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('+84812345678'), isTrue);
        
        // MobiFone numbers
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0701234567'), isTrue);
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('+84701234567'), isTrue);
        
        // Vietnamobile numbers
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0521234567'), isTrue);
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('+84521234567'), isTrue);
        
        // Gmobile numbers
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0591234567'), isTrue);
        
        // Itelecom numbers
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0871234567'), isTrue);
      });

      test('validates Vietnamese landline numbers correctly', () {
        // Hanoi (024)
        expect(VietnamesePhoneValidator.isValidVietnameseLandline('02412345678'), isTrue);
        expect(VietnamesePhoneValidator.isValidVietnameseLandline('+842412345678'), isTrue);
        
        // Ho Chi Minh City (028)
        expect(VietnamesePhoneValidator.isValidVietnameseLandline('02812345678'), isTrue);
        expect(VietnamesePhoneValidator.isValidVietnameseLandline('+842812345678'), isTrue);
        
        // Other areas
        expect(VietnamesePhoneValidator.isValidVietnameseLandline('02212345678'), isTrue);
        expect(VietnamesePhoneValidator.isValidVietnameseLandline('02612345678'), isTrue);
      });

      test('rejects invalid phone numbers', () {
        // Too short
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0323456'), isFalse);
        
        // Too long
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('032345678901'), isFalse);
        
        // Invalid prefix (012 and 061 are not valid Vietnamese mobile or landline prefixes)
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0123456789'), isFalse);
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('0612345678'), isFalse);
        
        // Empty string
        expect(VietnamesePhoneValidator.isValidVietnameseMobile(''), isFalse);
        
        // Non-numeric characters
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('032345678a'), isFalse);
        expect(VietnamesePhoneValidator.isValidVietnameseMobile('061-234-5678'), isFalse); // Invalid even after cleaning
      });
    });

    group('Phone number normalization', () {
      test('normalizes phone numbers to +84 format', () {
        expect(VietnamesePhoneValidator.normalizePhoneNumber('0323456789'), equals('+84323456789'));
        expect(VietnamesePhoneValidator.normalizePhoneNumber('84323456789'), equals('+84323456789'));
        expect(VietnamesePhoneValidator.normalizePhoneNumber('+84323456789'), equals('+84323456789'));
        expect(VietnamesePhoneValidator.normalizePhoneNumber('323456789'), equals('+84323456789'));
      });

      test('handles phone numbers with spaces and special characters', () {
        expect(VietnamesePhoneValidator.normalizePhoneNumber('032 345 6789'), equals('+84323456789'));
        expect(VietnamesePhoneValidator.normalizePhoneNumber('032-345-6789'), equals('+84323456789'));
        expect(VietnamesePhoneValidator.normalizePhoneNumber('032.345.6789'), equals('+84323456789'));
        expect(VietnamesePhoneValidator.normalizePhoneNumber('(032) 345-6789'), equals('+84323456789'));
      });
    });

    group('Phone number formatting', () {
      test('formats phone numbers for display', () {
        expect(VietnamesePhoneValidator.formatForDisplay('0323456789'), equals('+84 323 456 789'));
        expect(VietnamesePhoneValidator.formatForDisplay('+84323456789'), equals('+84 323 456 789'));
        expect(VietnamesePhoneValidator.formatForDisplay('84323456789'), equals('+84 323 456 789'));
      });

      test('formats phone numbers for input', () {
        expect(VietnamesePhoneValidator.formatForInput('0323'), equals('0323'));
        expect(VietnamesePhoneValidator.formatForInput('03234'), equals('0323 4'));
        expect(VietnamesePhoneValidator.formatForInput('032345678'), equals('0323 456 78'));
        expect(VietnamesePhoneValidator.formatForInput('0323456789'), equals('0323 456 789'));
      });
    });

    group('Carrier detection', () {
      test('detects Viettel carrier correctly', () {
        expect(VietnamesePhoneValidator.getCarrierName('0323456789'), equals('Viettel'));
        expect(VietnamesePhoneValidator.getCarrierName('0333456789'), equals('Viettel'));
        expect(VietnamesePhoneValidator.getCarrierName('0343456789'), equals('Viettel'));
        expect(VietnamesePhoneValidator.getCarrierName('0353456789'), equals('Viettel'));
        expect(VietnamesePhoneValidator.getCarrierName('0363456789'), equals('Viettel'));
        expect(VietnamesePhoneValidator.getCarrierName('0373456789'), equals('Viettel'));
        expect(VietnamesePhoneValidator.getCarrierName('0383456789'), equals('Viettel'));
        expect(VietnamesePhoneValidator.getCarrierName('0393456789'), equals('Viettel'));
      });

      test('detects Vinaphone carrier correctly', () {
        expect(VietnamesePhoneValidator.getCarrierName('0812345678'), equals('Vinaphone'));
        expect(VietnamesePhoneValidator.getCarrierName('0822345678'), equals('Vinaphone'));
        expect(VietnamesePhoneValidator.getCarrierName('0832345678'), equals('Vinaphone'));
        expect(VietnamesePhoneValidator.getCarrierName('0842345678'), equals('Vinaphone'));
        expect(VietnamesePhoneValidator.getCarrierName('0852345678'), equals('Vinaphone'));
        expect(VietnamesePhoneValidator.getCarrierName('0882345678'), equals('Vinaphone'));
      });

      test('detects MobiFone carrier correctly', () {
        expect(VietnamesePhoneValidator.getCarrierName('0701234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0711234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0721234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0731234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0741234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0751234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0761234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0771234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0781234567'), equals('MobiFone'));
        expect(VietnamesePhoneValidator.getCarrierName('0791234567'), equals('MobiFone'));
      });

      test('detects other carriers correctly', () {
        expect(VietnamesePhoneValidator.getCarrierName('0521234567'), equals('Vietnamobile'));
        expect(VietnamesePhoneValidator.getCarrierName('0561234567'), equals('Vietnamobile'));
        expect(VietnamesePhoneValidator.getCarrierName('0581234567'), equals('Vietnamobile'));
        expect(VietnamesePhoneValidator.getCarrierName('0591234567'), equals('Gmobile'));
        expect(VietnamesePhoneValidator.getCarrierName('0871234567'), equals('Itelecom'));
      });

      test('returns null for invalid numbers', () {
        expect(VietnamesePhoneValidator.getCarrierName('0123456789'), isNull);
        expect(VietnamesePhoneValidator.getCarrierName('invalid'), isNull);
        expect(VietnamesePhoneValidator.getCarrierName(''), isNull);
      });

      test('identifies major carriers', () {
        expect(VietnamesePhoneValidator.isMajorCarrier('0323456789'), isTrue); // Viettel
        expect(VietnamesePhoneValidator.isMajorCarrier('0812345678'), isTrue); // Vinaphone
        expect(VietnamesePhoneValidator.isMajorCarrier('0701234567'), isTrue); // MobiFone
        expect(VietnamesePhoneValidator.isMajorCarrier('0521234567'), isFalse); // Vietnamobile
        expect(VietnamesePhoneValidator.isMajorCarrier('0591234567'), isFalse); // Gmobile
      });
    });

    group('Phone type detection', () {
      test('detects mobile phone type', () {
        expect(VietnamesePhoneValidator.getPhoneType('0323456789'), equals(PhoneType.mobile));
        expect(VietnamesePhoneValidator.getPhoneType('0812345678'), equals(PhoneType.mobile));
        expect(VietnamesePhoneValidator.getPhoneType('0701234567'), equals(PhoneType.mobile));
      });

      test('detects landline phone type', () {
        expect(VietnamesePhoneValidator.getPhoneType('02412345678'), equals(PhoneType.landline));
        expect(VietnamesePhoneValidator.getPhoneType('02812345678'), equals(PhoneType.landline));
      });

      test('detects invalid phone type', () {
        expect(VietnamesePhoneValidator.getPhoneType('0123456789'), equals(PhoneType.invalid));
        expect(VietnamesePhoneValidator.getPhoneType('invalid'), equals(PhoneType.invalid));
        expect(VietnamesePhoneValidator.getPhoneType(''), equals(PhoneType.invalid));
      });
    });

    group('Validation error messages', () {
      test('returns correct Vietnamese error messages', () {
        expect(VietnamesePhoneValidator.getValidationError(''), equals('Vui lòng nhập số điện thoại'));
        expect(VietnamesePhoneValidator.getValidationError('032'), equals('Số điện thoại quá ngắn'));
        expect(VietnamesePhoneValidator.getValidationError('032345678901234'), equals('Số điện thoại quá dài'));
        expect(VietnamesePhoneValidator.getValidationError('0123456789'), equals('Số điện thoại không đúng định dạng Việt Nam'));
        expect(VietnamesePhoneValidator.getValidationError('0323456789'), isNull); // Valid number
      });
    });

    group('Supported prefixes', () {
      test('returns all supported prefixes', () {
        final prefixes = VietnamesePhoneValidator.getAllSupportedPrefixes();
        
        // Check that major carriers are included
        expect(prefixes, contains('032')); // Viettel
        expect(prefixes, contains('081')); // Vinaphone  
        expect(prefixes, contains('070')); // MobiFone
        expect(prefixes, contains('052')); // Vietnamobile
        expect(prefixes, contains('059')); // Gmobile
        expect(prefixes, contains('087')); // Itelecom
        
        // Check that the list is sorted
        expect(prefixes, orderedEquals(prefixes..sort()));
        
        // Check total count matches expected carriers
        expect(prefixes.length, greaterThan(15)); // We have many prefixes
      });
    });

    group('Input formatter', () {
      test('creates Vietnamese phone formatter', () {
        final formatter = VietnamesePhoneValidator.createVietnamesePhoneFormatter();
        expect(formatter, isNotNull);
      });
    });

    group('Phone validation result', () {
      test('creates comprehensive validation result for valid phone', () {
        final result = PhoneValidationResult.validate('0323456789');
        
        expect(result.isValid, isTrue);
        expect(result.errorMessage, isNull);
        expect(result.carrier, equals('Viettel'));
        expect(result.type, equals(PhoneType.mobile));
        expect(result.normalizedNumber, equals('+84323456789'));
        expect(result.displayFormat, equals('+84 323 456 789'));
      });

      test('creates comprehensive validation result for invalid phone', () {
        final result = PhoneValidationResult.validate('0123456789');
        
        expect(result.isValid, isFalse);
        expect(result.errorMessage, equals('Số điện thoại không đúng định dạng Việt Nam'));
        expect(result.carrier, isNull);
        expect(result.type, equals(PhoneType.invalid));
        expect(result.normalizedNumber, equals('+84123456789')); // Still normalized
        expect(result.displayFormat, equals('+84 123 456 789')); // Still formatted even if invalid
      });

      test('creates validation result for empty phone', () {
        final result = PhoneValidationResult.validate('');
        
        expect(result.isValid, isFalse);
        expect(result.errorMessage, equals('Vui lòng nhập số điện thoại'));
        expect(result.carrier, isNull);
        expect(result.type, equals(PhoneType.invalid));
      });
    });
  });
}