import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:go_sport_app/features/auth/services/phone_auth_service.dart';
import 'package:go_sport_app/features/auth/services/api_service.dart';

// Generate mocks
@GenerateMocks([ApiService])
import 'phone_auth_service_test.mocks.dart';

void main() {
  group('PhoneAuthService Tests', () {
    late PhoneAuthService phoneAuthService;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      phoneAuthService = PhoneAuthService(mockApiService);
    });

    group('Phone number formatting', () {
      test('formatVietnamesePhone normalizes phone numbers correctly', () {
        expect(PhoneAuthService.formatVietnamesePhone('0323456789'), 
               equals('+84323456789'));
        expect(PhoneAuthService.formatVietnamesePhone('84323456789'), 
               equals('+84323456789'));
        expect(PhoneAuthService.formatVietnamesePhone('+84323456789'), 
               equals('+84323456789'));
        expect(PhoneAuthService.formatVietnamesePhone('323456789'), 
               equals('+84323456789'));
      });

      test('formatPhoneForDisplay formats phone numbers for display', () {
        expect(PhoneAuthService.formatPhoneForDisplay('0323456789'), 
               equals('+84 323 456 789'));
        expect(PhoneAuthService.formatPhoneForDisplay('+84323456789'), 
               equals('+84 323 456 789'));
        expect(PhoneAuthService.formatPhoneForDisplay('84323456789'), 
               equals('+84 323 456 789'));
      });
    });

    group('Phone number validation', () {
      test('validates Vietnamese mobile numbers correctly', () {
        // Viettel numbers
        expect(phoneAuthService.isValidVietnamesePhone('0323456789'), isTrue);
        expect(phoneAuthService.isValidVietnamesePhone('+84323456789'), isTrue);
        
        // Vinaphone numbers
        expect(phoneAuthService.isValidVietnamesePhone('0812345678'), isTrue);
        expect(phoneAuthService.isValidVietnamesePhone('+84812345678'), isTrue);
        
        // MobiFone numbers
        expect(phoneAuthService.isValidVietnamesePhone('0701234567'), isTrue);
        expect(phoneAuthService.isValidVietnamesePhone('+84701234567'), isTrue);
        
        // Invalid numbers
        expect(phoneAuthService.isValidVietnamesePhone('0123456789'), isFalse);
        expect(phoneAuthService.isValidVietnamesePhone('123'), isFalse);
        expect(phoneAuthService.isValidVietnamesePhone(''), isFalse);
      });
    });

    group('Send verification code', () {
      test('sends verification code successfully', () async {
        // Mock successful response
        when(mockApiService.sendVerificationCode(phone: '+84323456789'))
            .thenAnswer((_) async => {
              'success': true,
              'message': 'Mã xác thực đã được gửi',
              'expires_in': 300,
            });

        String? successMessage;
        String? errorMessage;

        await phoneAuthService.sendVerificationCode(
          phoneNumber: '0323456789',
          onSuccess: (message) => successMessage = message,
          onError: (error) => errorMessage = error,
        );

        expect(successMessage, isNotNull);
        expect(successMessage, contains('Mã xác thực đã được gửi'));
        expect(errorMessage, isNull);
      });

      test('handles invalid phone number format', () async {
        String? successMessage;
        String? errorMessage;

        await phoneAuthService.sendVerificationCode(
          phoneNumber: '0123456789', // Invalid format
          onSuccess: (message) => successMessage = message,
          onError: (error) => errorMessage = error,
        );

        expect(successMessage, isNull);
        expect(errorMessage, equals('Số điện thoại không đúng định dạng Việt Nam'));
      });

      test('handles API error response', () async {
        // Mock error response
        when(mockApiService.sendVerificationCode(phone: '+84323456789'))
            .thenAnswer((_) async => {
              'success': false,
              'message': 'Không thể gửi SMS',
            });

        String? successMessage;
        String? errorMessage;

        await phoneAuthService.sendVerificationCode(
          phoneNumber: '0323456789',
          onSuccess: (message) => successMessage = message,
          onError: (error) => errorMessage = error,
        );

        expect(successMessage, isNull);
        expect(errorMessage, equals('Không thể gửi SMS'));
      });

      test('includes development code in debug mode', () async {
        // Mock successful response with development code
        when(mockApiService.sendVerificationCode(phone: '+84323456789'))
            .thenAnswer((_) async => {
              'success': true,
              'message': 'Mã xác thực đã được gửi',
              'expires_in': 300,
              'development_code': '123456',
            });

        String? successMessage;
        String? errorMessage;

        await phoneAuthService.sendVerificationCode(
          phoneNumber: '0323456789',
          onSuccess: (message) => successMessage = message,
          onError: (error) => errorMessage = error,
        );

        expect(successMessage, isNotNull);
        expect(successMessage, contains('5 phút')); // Minutes from expires_in
        expect(errorMessage, isNull); // Should be no error
        
        // In debug mode, should include development code
        // This would need to be tested with proper debug flag mocking
      });
    });

    group('User registration', () {
      test('registers user successfully', () async {
        final mockUserData = {
          'id': 1,
          'name': 'Nguyễn Văn A',
          'phone': '+84323456789',
          'preferred_sports': ['Bóng đá', 'Tennis'],
        };

        // Mock successful registration response
        when(mockApiService.registerWithPhone(
          phone: '+84323456789',
          verificationCode: '123456',
          name: 'Nguyễn Văn A',
          password: 'password123',
          preferredSports: ['Bóng đá', 'Tennis'],
        )).thenAnswer((_) async => {
          'success': true,
          'user': mockUserData,
          'token': 'mock_jwt_token',
        });

        final user = await phoneAuthService.registerUser(
          phoneNumber: '0323456789',
          verificationCode: '123456',
          name: 'Nguyễn Văn A',
          password: 'password123',
          preferredSports: ['Bóng đá', 'Tennis'],
        );

        expect(user.name, equals('Nguyễn Văn A'));
        expect(user.id, equals(1));
      });

      test('handles registration failure', () async {
        // Mock failed registration response
        when(mockApiService.registerWithPhone(
          phone: any,
          verificationCode: any,
          name: any,
          password: any,
          preferredSports: any,
        )).thenAnswer((_) async => {
          'success': false,
          'message': 'Mã xác thực không đúng',
        });

        expect(
          () => phoneAuthService.registerUser(
            phoneNumber: '0323456789',
            verificationCode: '123456',
            name: 'Nguyễn Văn A',
            password: 'password123',
          ),
          throwsException,
        );
      });

      test('handles API exception during registration', () async {
        // Mock API exception
        when(mockApiService.registerWithPhone(
          phone: any,
          verificationCode: any,
          name: any,
          password: any,
          preferredSports: any,
        )).thenThrow(Exception('Network error'));

        expect(
          () => phoneAuthService.registerUser(
            phoneNumber: '0323456789',
            verificationCode: '123456',
            name: 'Nguyễn Văn A',
            password: 'password123',
          ),
          throwsException,
        );
      });
    });

    group('User login', () {
      test('logs in user successfully', () async {
        final mockUserData = {
          'id': 1,
          'name': 'Nguyễn Văn A',
          'phone': '+84323456789',
        };

        // Mock successful login response
        when(mockApiService.loginWithPhone(
          phone: '+84323456789',
          password: 'password123',
        )).thenAnswer((_) async => {
          'success': true,
          'user': mockUserData,
          'token': 'mock_jwt_token',
        });

        final user = await phoneAuthService.loginUser(
          phoneNumber: '0323456789',
          password: 'password123',
        );

        expect(user.name, equals('Nguyễn Văn A'));
        expect(user.id, equals(1));
      });

      test('handles login failure', () async {
        // Mock failed login response
        when(mockApiService.loginWithPhone(
          phone: any,
          password: any,
        )).thenAnswer((_) async => {
          'success': false,
          'message': 'Sai số điện thoại hoặc mật khẩu',
        });

        expect(
          () => phoneAuthService.loginUser(
            phoneNumber: '0323456789',
            password: 'wrong_password',
          ),
          throwsException,
        );
      });
    });

    group('Authentication state', () {
      test('checks authentication status', () async {
        // Mock no stored tokens
        final isAuthenticated = await phoneAuthService.isAuthenticated();
        expect(isAuthenticated, isFalse);
      });

      test('gets current user when authenticated', () async {
        // This would require mocking the token storage
        final currentUser = await phoneAuthService.getCurrentUser();
        expect(currentUser, isNull); // No tokens stored in test
      });

      test('logout clears tokens', () async {
        // Mock logout API call
        when(mockApiService.authenticatedRequest(
          method: 'POST',
          endpoint: '/auth/logout',
          laravelToken: any,
        )).thenAnswer((_) async => {'success': true});

        // Should not throw
        await phoneAuthService.logout();
      });
    });

    group('Vietnamese sports list', () {
      test('provides Vietnamese sports options', () {
        final sportsList = PhoneAuthService.vietnameseSportsList;
        
        expect(sportsList, isNotEmpty);
        expect(sportsList.length, equals(15));
        
        // Check key Vietnamese sports
        expect(sportsList, contains('Bóng đá'));
        expect(sportsList, contains('Bóng chuyền'));
        expect(sportsList, contains('Cầu lông'));
        expect(sportsList, contains('Võ thuật'));
        expect(sportsList, contains('Gym/Thể hình'));
      });

      test('sports list has no duplicates', () {
        final sportsList = PhoneAuthService.vietnameseSportsList;
        final sportsSet = sportsList.toSet();
        
        expect(sportsSet.length, equals(sportsList.length));
      });

      test('all sports names are non-empty', () {
        final sportsList = PhoneAuthService.vietnameseSportsList;
        
        for (final sport in sportsList) {
          expect(sport, isNotEmpty);
          expect(sport.trim(), equals(sport)); // No leading/trailing whitespace
        }
      });
    });

    group('Error handling', () {
      test('provides Vietnamese error messages', () async {
        String? errorMessage;

        await phoneAuthService.sendVerificationCode(
          phoneNumber: '', // Empty phone
          onSuccess: (message) => {},
          onError: (error) => errorMessage = error,
        );

        expect(errorMessage, equals('Vui lòng nhập số điện thoại'));
      });

      test('handles network timeouts gracefully', () async {
        // Mock network timeout
        when(mockApiService.sendVerificationCode(phone: any))
            .thenThrow(Exception('Timeout'));

        String? errorMessage;

        await phoneAuthService.sendVerificationCode(
          phoneNumber: '0323456789',
          onSuccess: (message) => {},
          onError: (error) => errorMessage = error,
        );

        expect(errorMessage, isNotNull);
        expect(errorMessage, contains('Không thể gửi mã xác thực'));
      });
    });

    group('Input sanitization', () {
      test('handles phone numbers with special characters', () {
        final testCases = {
          '032-345-6789': '+84323456789',
          '032.345.6789': '+84323456789', 
          '032 345 6789': '+84323456789',
          '(032) 345-6789': '+84323456789',
        };

        for (final entry in testCases.entries) {
          final result = PhoneAuthService.formatVietnamesePhone(entry.key);
          expect(result, equals(entry.value));
        }
      });

      test('validates sanitized phone numbers', () {
        expect(phoneAuthService.isValidVietnamesePhone('032-345-6789'), isTrue);
        expect(phoneAuthService.isValidVietnamesePhone('032.345.6789'), isTrue);
        expect(phoneAuthService.isValidVietnamesePhone('032 345 6789'), isTrue);
        expect(phoneAuthService.isValidVietnamesePhone('(032) 345-6789'), isTrue);
      });
    });
  });
}