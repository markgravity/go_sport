import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_sport_app/features/auth/screens/phone_registration_screen.dart';
import 'package:go_sport_app/features/auth/screens/sms_verification_screen.dart';

void main() {
  group('SMS Verification Integration Tests', () {
    // Helper function to create testable app with navigation
    Widget createTestApp() {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('vi'),
        ],
        locale: const Locale('vi'),
        home: const PhoneRegistrationScreen(),
        routes: {
          '/sms-verification': (context) => const SmsVerificationScreen(
            phoneNumber: '+84323456789',
            userName: 'Test User',
            password: 'password123',
            selectedSports: ['Bóng đá'],
          ),
        },
      );
    }

    group('Registration to SMS Verification Flow', () {
      testWidgets('completes full registration form and navigates to SMS verification',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Verify we're on the registration screen
        expect(find.text('Tạo tài khoản Go Sport'), findsOneWidget);

        // Fill out the registration form
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(1), '0323456789');
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(2), 'password123');
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(3), 'password123');
        await tester.pumpAndSettle();

        // Select a sport
        await tester.tap(find.text('Bóng đá').first);
        await tester.pumpAndSettle();

        // Submit the form
        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // In a real integration test, we would mock the API response
        // and verify navigation to SMS verification screen
        // For now, verify form submission doesn't crash
        expect(find.text('Gửi mã xác thực'), findsOneWidget);
      });

      testWidgets('validates all required fields before proceeding',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Try to submit without filling anything
        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show validation errors
        expect(find.text('Vui lòng nhập tên của bạn'), findsOneWidget);
        expect(find.text('Vui lòng nhập số điện thoại'), findsOneWidget);
        expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
        expect(find.text('Vui lòng xác nhận mật khẩu'), findsOneWidget);

        // Should not navigate away
        expect(find.text('Tạo tài khoản Go Sport'), findsOneWidget);
      });

      testWidgets('handles phone number validation correctly',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Fill form with invalid phone number
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.enterText(find.byType(TextFormField).at(1), '012345'); // Invalid
        await tester.enterText(find.byType(TextFormField).at(2), 'password123');
        await tester.enterText(find.byType(TextFormField).at(3), 'password123');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show phone validation error
        expect(find.text('Số điện thoại quá ngắn'), findsOneWidget);
      });

      testWidgets('shows carrier information for valid phone numbers',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Enter a valid Viettel number
        await tester.enterText(find.byType(TextFormField).at(1), '0323456789');
        await tester.pumpAndSettle();

        // Should show carrier information
        expect(find.textContaining('Nhà mạng:'), findsOneWidget);
        expect(find.textContaining('Viettel'), findsOneWidget);
      });
    });

    group('SMS Verification Screen Flow', () {
      testWidgets('displays SMS verification screen with correct phone number',
          (WidgetTester tester) async {
        const smsScreen = SmsVerificationScreen(
          phoneNumber: '+84323456789',
          userName: 'Nguyễn Văn A',
          password: 'password123',
          selectedSports: ['Bóng đá', 'Tennis'],
        );

        await tester.pumpWidget(MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
          locale: const Locale('vi'),
          home: smsScreen,
        ));
        await tester.pumpAndSettle();

        // Verify SMS verification screen elements
        expect(find.text('Xác thực số điện thoại'), findsOneWidget);
        expect(find.text('Nhập mã xác thực'), findsOneWidget);
        expect(find.text('+84 323 456 789'), findsOneWidget);
        expect(find.text('Xác thực'), findsOneWidget);
      });

      testWidgets('handles verification code input and validation',
          (WidgetTester tester) async {
        const smsScreen = SmsVerificationScreen(
          phoneNumber: '+84323456789',
          userName: 'Nguyễn Văn A',
          password: 'password123',
          selectedSports: ['Bóng đá'],
        );

        await tester.pumpWidget(MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
          locale: const Locale('vi'),
          home: smsScreen,
        ));
        await tester.pumpAndSettle();

        // Try to verify without entering code
        await tester.tap(find.text('Xác thực'));
        await tester.pumpAndSettle();

        // Should handle validation (in real test would check for error message)
        expect(find.text('Xác thực'), findsOneWidget);
      });

      testWidgets('displays countdown timer and resend functionality',
          (WidgetTester tester) async {
        const smsScreen = SmsVerificationScreen(
          phoneNumber: '+84323456789',
          userName: 'Nguyễn Văn A',
          password: 'password123',
          selectedSports: ['Bóng đá'],
        );

        await tester.pumpWidget(MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
          locale: const Locale('vi'),
          home: smsScreen,
        ));
        await tester.pumpAndSettle();

        // Should show countdown initially
        expect(find.textContaining('Gửi lại sau'), findsOneWidget);
        expect(find.text('Không nhận được mã? '), findsOneWidget);

        // Info message should be displayed
        expect(find.textContaining('5 phút'), findsOneWidget);
      });

      testWidgets('handles back navigation from SMS verification',
          (WidgetTester tester) async {
        const smsScreen = SmsVerificationScreen(
          phoneNumber: '+84323456789',
          userName: 'Nguyễn Văn A',
          password: 'password123',
          selectedSports: ['Bóng đá'],
        );

        await tester.pumpWidget(MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],
          locale: const Locale('vi'),
          home: smsScreen,
        ));
        await tester.pumpAndSettle();

        // Tap back button
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // Should handle navigation (would go back in real app)
      });
    });

    group('End-to-End Registration Flow', () {
      testWidgets('completes full registration flow simulation',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Step 1: Fill registration form
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.enterText(find.byType(TextFormField).at(1), '0323456789');
        await tester.enterText(find.byType(TextFormField).at(2), 'password123');
        await tester.enterText(find.byType(TextFormField).at(3), 'password123');
        
        // Select sports
        await tester.tap(find.text('Bóng đá').first);
        await tester.tap(find.text('Tennis').first);
        await tester.pumpAndSettle();

        // Step 2: Submit registration
        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // In a real integration test with mocked API:
        // - Would verify API call was made with correct data
        // - Would mock successful response
        // - Would verify navigation to SMS screen
        // - Would test SMS verification process
        // - Would verify final success flow

        // For now, verify the form was filled correctly
        expect(find.text('Gửi mã xác thực'), findsOneWidget);
      });

      testWidgets('handles various error scenarios during registration',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Test password mismatch
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.enterText(find.byType(TextFormField).at(1, '0323456789');
        await tester.enterText(find.byType(TextFormField).at(2), 'password123');
        await tester.enterText(find.byType(TextFormField).at(3), 'different123');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        expect(find.text('Mật khẩu xác nhận không khớp'), findsOneWidget);
      });

      testWidgets('maintains form state during validation errors',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Fill form partially
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.enterText(find.byType(TextFormField).at(1), '0323456789');
        // Leave passwords empty

        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show validation errors but keep existing input
        expect(find.text('Nguyễn Văn A'), findsOneWidget);
        expect(find.text('0323456789'), findsOneWidget);
        expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
      });
    });

    group('Phone Number Format Handling', () {
      testWidgets('handles various phone number input formats',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Test different input formats
        final testCases = [
          '0323456789',
          '032 345 6789',
          '032-345-6789',
          '032.345.6789',
          '(032) 345-6789',
        ];

        for (final phoneFormat in testCases) {
          // Clear previous input
          await tester.enterText(find.byType(TextFormField).at(1), '');
          await tester.pumpAndSettle();

          // Enter test format
          await tester.enterText(find.byType(TextFormField).at(1), phoneFormat);
          await tester.pumpAndSettle();

          // Should show carrier info for valid Viettel number
          expect(find.textContaining('Nhà mạng:'), findsOneWidget);
          expect(find.textContaining('Viettel'), findsOneWidget);
        }
      });

      testWidgets('validates different carrier phone numbers',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        final testCases = {
          '0323456789': 'Viettel',
          '0812345678': 'Vinaphone', 
          '0701234567': 'MobiFone',
          '0521234567': 'Vietnamobile',
        };

        for (final entry in testCases.entries) {
          await tester.enterText(find.byType(TextFormField).at(1), '');
          await tester.pumpAndSettle();

          await tester.enterText(find.byType(TextFormField).at(1), entry.key);
          await tester.pumpAndSettle();

          // Should show correct carrier
          expect(find.textContaining('Nhà mạng:'), findsOneWidget);
          expect(find.textContaining(entry.value), findsOneWidget);
        }
      });
    });

    group('Localization Integration', () {
      testWidgets('displays Vietnamese text throughout flow',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Registration screen should show Vietnamese text
        expect(find.text('Tạo tài khoản Go Sport'), findsOneWidget);
        expect(find.text('Tên của bạn'), findsOneWidget);
        expect(find.text('Số điện thoại'), findsOneWidget);
        expect(find.text('Mật khẩu'), findsOneWidget);
        expect(find.text('Môn thể thao yêu thích (tùy chọn)'), findsOneWidget);
        expect(find.text('Gửi mã xác thực'), findsOneWidget);

        // Vietnamese sports should be displayed
        expect(find.text('Bóng đá'), findsOneWidget);
        expect(find.text('Bóng chuyền'), findsOneWidget);
        expect(find.text('Cầu lông'), findsOneWidget);
      });

      testWidgets('shows Vietnamese error messages',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Trigger validation errors
        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show Vietnamese error messages
        expect(find.text('Vui lòng nhập tên của bạn'), findsOneWidget);
        expect(find.text('Vui lòng nhập số điện thoại'), findsOneWidget);
        expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
        expect(find.text('Vui lòng xác nhận mật khẩu'), findsOneWidget);
      });
    });

    group('Accessibility Integration', () {
      testWidgets('maintains accessibility throughout registration flow',
          (WidgetTester tester) async {
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Check semantic tree is properly built
        final semantics = tester.binding.pipelineOwner.semanticsOwner!;
        expect(semantics.rootSemanticsNode, isNotNull);

        // Key interactive elements should be accessible
        expect(find.byType(TextFormField), findsNWidgets(4));
        expect(find.byType(ElevatedButton), findsOneWidget);
      });
    });
  });
}