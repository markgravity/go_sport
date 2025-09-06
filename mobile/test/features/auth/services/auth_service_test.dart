import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:go_sport_app/features/auth/services/auth_service.dart';
import 'package:go_sport_app/features/auth/models/user_model.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([
  http.Client,
  FlutterSecureStorage,
  LocalAuthentication,
])
void main() {
  group('AuthService', () {
    late AuthService authService;
    late MockClient mockHttpClient;
    late MockFlutterSecureStorage mockStorage;
    late MockLocalAuthentication mockLocalAuth;

    setUp(() {
      mockHttpClient = MockClient();
      mockStorage = MockFlutterSecureStorage();
      mockLocalAuth = MockLocalAuthentication();
      authService = AuthService();
    });

    group('login', () {
      test('should login successfully with valid credentials', () async {
        // Arrange
        const phoneNumber = '+84912345678';
        const password = 'password123';
        final mockResponse = http.Response(
          '{"success": true, "message": "Đăng nhập thành công", "token": "mock_token", "user": {"id": 1, "name": "Test User", "phone": "+84912345678"}}',
          200,
        );

        when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        String? receivedMessage;
        UserModel? receivedUser;

        // Act
        await authService.login(
          phoneNumber: phoneNumber,
          password: password,
          onSuccess: (user, message) {
            receivedUser = user;
            receivedMessage = message;
          },
          onError: (error) {
            fail('Should not call onError');
          },
        );

        // Assert
        expect(receivedMessage, equals('Đăng nhập thành công'));
        expect(receivedUser?.phone, equals('+84912345678'));
        expect(receivedUser?.name, equals('Test User'));
      });

      test('should handle login failure with invalid credentials', () async {
        // Arrange
        const phoneNumber = '+84912345678';
        const password = 'wrong_password';
        final mockResponse = http.Response(
          '{"success": false, "message": "Số điện thoại hoặc mật khẩu không đúng"}',
          401,
        );

        when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => mockResponse);

        String? receivedError;

        // Act
        await authService.login(
          phoneNumber: phoneNumber,
          password: password,
          onSuccess: (user, message) {
            fail('Should not call onSuccess');
          },
          onError: (error) {
            receivedError = error;
          },
        );

        // Assert
        expect(receivedError, equals('Số điện thoại hoặc mật khẩu không đúng'));
      });

      test('should handle network errors', () async {
        // Arrange
        const phoneNumber = '+84912345678';
        const password = 'password123';

        when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
            .thenThrow(Exception('Network error'));

        String? receivedError;

        // Act
        await authService.login(
          phoneNumber: phoneNumber,
          password: password,
          onSuccess: (user, message) {
            fail('Should not call onSuccess');
          },
          onError: (error) {
            receivedError = error;
          },
        );

        // Assert
        expect(receivedError, equals('Lỗi kết nối mạng. Vui lòng thử lại.'));
      });
    });

    group('biometric login', () {
      test('should login with biometric when available and enabled', () async {
        // Arrange
        when(mockStorage.read(key: 'biometric_enabled')).thenAnswer((_) async => 'true');
        when(mockStorage.read(key: 'auth_token')).thenAnswer((_) async => 'mock_token');
        when(mockStorage.read(key: 'user_data')).thenAnswer((_) async => 
          '{"id": 1, "name": "Test User", "phone": "+84912345678"}');
        when(mockLocalAuth.canCheckBiometrics).thenAnswer((_) async => true);
        when(mockLocalAuth.authenticate(
          localizedReason: anyNamed('localizedReason'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => true);

        String? receivedMessage;
        UserModel? receivedUser;

        // Act
        await authService.loginWithBiometric(
          onSuccess: (user, message) {
            receivedUser = user;
            receivedMessage = message;
          },
          onError: (error) {
            fail('Should not call onError');
          },
        );

        // Assert
        expect(receivedMessage, equals('Đăng nhập thành công'));
        expect(receivedUser?.phone, equals('+84912345678'));
      });

      test('should fail when biometric is not enabled', () async {
        // Arrange
        when(mockStorage.read(key: 'biometric_enabled')).thenAnswer((_) async => null);

        String? receivedError;

        // Act
        await authService.loginWithBiometric(
          onSuccess: (user, message) {
            fail('Should not call onSuccess');
          },
          onError: (error) {
            receivedError = error;
          },
        );

        // Assert
        expect(receivedError, equals('Xác thực sinh trắc học chưa được thiết lập'));
      });

      test('should fail when biometric authentication fails', () async {
        // Arrange
        when(mockStorage.read(key: 'biometric_enabled')).thenAnswer((_) async => 'true');
        when(mockLocalAuth.canCheckBiometrics).thenAnswer((_) async => true);
        when(mockLocalAuth.authenticate(
          localizedReason: anyNamed('localizedReason'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => false);

        String? receivedError;

        // Act
        await authService.loginWithBiometric(
          onSuccess: (user, message) {
            fail('Should not call onSuccess');
          },
          onError: (error) {
            receivedError = error;
          },
        );

        // Assert
        expect(receivedError, equals('Xác thực sinh trắc học thất bại'));
      });
    });

    group('token management', () {
      test('should refresh token successfully', () async {
        // Arrange
        when(mockStorage.read(key: 'auth_token')).thenAnswer((_) async => 'old_token');
        final mockResponse = http.Response(
          '{"success": true, "token": "new_token", "expires_in": 604800}',
          200,
        );

        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await authService.refreshToken();

        // Assert
        expect(result, isTrue);
        verify(mockStorage.write(key: 'auth_token', value: 'new_token')).called(1);
      });

      test('should fail to refresh token with invalid token', () async {
        // Arrange
        when(mockStorage.read(key: 'auth_token')).thenAnswer((_) async => 'invalid_token');
        final mockResponse = http.Response(
          '{"success": false, "message": "Invalid token"}',
          401,
        );

        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await authService.refreshToken();

        // Assert
        expect(result, isFalse);
      });
    });

    group('logout', () {
      test('should logout successfully and clear local data', () async {
        // Arrange
        when(mockStorage.read(key: 'auth_token')).thenAnswer((_) async => 'mock_token');
        final mockResponse = http.Response('{"success": true}', 200);

        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => mockResponse);

        bool onSuccessCalled = false;

        // Act
        await authService.logout(
          onSuccess: () {
            onSuccessCalled = true;
          },
        );

        // Assert
        expect(onSuccessCalled, isTrue);
        verify(mockStorage.delete(key: 'auth_token')).called(1);
        verify(mockStorage.delete(key: 'user_data')).called(1);
        verify(mockStorage.delete(key: 'biometric_enabled')).called(1);
        verify(mockStorage.delete(key: 'biometric_phone')).called(1);
      });

      test('should clear local data even if logout API fails', () async {
        // Arrange
        when(mockStorage.read(key: 'auth_token')).thenAnswer((_) async => 'mock_token');

        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenThrow(Exception('Network error'));

        bool onSuccessCalled = false;

        // Act
        await authService.logout(
          onSuccess: () {
            onSuccessCalled = true;
          },
        );

        // Assert
        expect(onSuccessCalled, isTrue);
        verify(mockStorage.delete(key: 'auth_token')).called(1);
        verify(mockStorage.delete(key: 'user_data')).called(1);
      });
    });

    group('authentication state', () {
      test('should return true when user is logged in', () async {
        // Arrange
        when(mockStorage.read(key: 'auth_token')).thenAnswer((_) async => 'mock_token');

        // Act
        final result = await authService.isLoggedIn();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when user is not logged in', () async {
        // Arrange
        when(mockStorage.read(key: 'auth_token')).thenAnswer((_) async => null);

        // Act
        final result = await authService.isLoggedIn();

        // Assert
        expect(result, isFalse);
      });

      test('should return current user when data exists', () async {
        // Arrange
        when(mockStorage.read(key: 'user_data')).thenAnswer((_) async => 
          '{"id": 1, "name": "Test User", "phone": "+84912345678"}');

        // Act
        final result = await authService.getCurrentUser();

        // Assert
        expect(result?.name, equals('Test User'));
        expect(result?.phone, equals('+84912345678'));
      });

      test('should return null when no user data exists', () async {
        // Arrange
        when(mockStorage.read(key: 'user_data')).thenAnswer((_) async => null);

        // Act
        final result = await authService.getCurrentUser();

        // Assert
        expect(result, isNull);
      });
    });
  });
}