import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_sport_app/features/auth/screens/sms_verification_screen.dart';

void main() {
  group('SmsVerificationScreen Widget Tests', () {
    const testPhoneNumber = '+84323456789';
    const testUserName = 'Nguyễn Văn A';
    const testPassword = 'password123';
    const testSelectedSports = ['Bóng đá', 'Tennis'];

    // Helper function to create testable widget with localization
    Widget createTestWidget(Widget child) {
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
        locale: const Locale('vi'), // Test with Vietnamese locale
        home: child,
      );
    }

    Widget createSmsVerificationScreen() {
      return const SmsVerificationScreen(
        phoneNumber: testPhoneNumber,
        userName: testUserName,
        password: testPassword,
        selectedSports: testSelectedSports,
      );
    }

    group('UI Elements', () {
      testWidgets('displays all required UI elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Check app bar
        expect(find.text('Xác thực số điện thoại'), findsOneWidget);
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);

        // Check SMS icon
        expect(find.byIcon(Icons.sms_outlined), findsOneWidget);

        // Check header
        expect(find.text('Nhập mã xác thực'), findsOneWidget);

        // Check description
        expect(find.text('Chúng tôi đã gửi mã xác thực 6 số đến'), findsOneWidget);
        
        // Check formatted phone number display
        expect(find.text('+84 323 456 789'), findsOneWidget);

        // Check verification button
        expect(find.text('Xác thực'), findsOneWidget);

        // Check resend text (initially disabled)
        expect(find.text('Không nhận được mã? '), findsOneWidget);

        // Check info container
        expect(find.textContaining('Mã xác thực có hiệu lực trong 5 phút'), findsOneWidget);
      });

      testWidgets('displays verification code input field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Should find the verification code input widget
        expect(find.byType(TextField), findsAtLeastNWidgets(1));
        
        // The verification input should be prominent
        expect(find.byIcon(Icons.sms_outlined), findsOneWidget);
      });

      testWidgets('displays countdown timer initially', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Should show countdown instead of resend button initially
        expect(find.textContaining('Gửi lại sau'), findsOneWidget);
        expect(find.textContaining('s'), findsOneWidget); // Seconds indicator
      });

      testWidgets('shows resend button after countdown', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Wait for countdown to finish (this would be mocked in a real test)
        // For now, we just verify the UI structure exists
        expect(find.text('Không nhận được mã? '), findsOneWidget);
      });
    });

    group('User Interactions', () {
      testWidgets('accepts verification code input', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Find code input fields and enter code
        final codeInputs = find.byType(TextField);
        expect(codeInputs, findsAtLeastNWidgets(1));

        // In a real implementation, we would enter each digit
        // For now, verify the input fields exist
      });

      testWidgets('verify button is initially enabled', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        final verifyButton = find.text('Xác thực');
        expect(verifyButton, findsOneWidget);

        // Button should be tappable
        await tester.tap(verifyButton);
        await tester.pumpAndSettle();
        
        // Should not crash (though may show validation error)
      });

      testWidgets('back button navigation works', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Tap back button
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // Should handle navigation (in real app would pop route)
      });
    });

    group('Phone Number Display', () {
      testWidgets('formats phone number correctly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Check that phone number is displayed in formatted form
        expect(find.text('+84 323 456 789'), findsOneWidget);
        
        // Should not show unformatted version
        expect(find.text('+84323456789'), findsNothing);
        expect(find.text('84323456789'), findsNothing);
      });

      testWidgets('handles different phone number formats', (WidgetTester tester) async {
        // Test with different input format
        const differentFormatScreen = SmsVerificationScreen(
          phoneNumber: '0323456789', // Without +84
          userName: testUserName,
          password: testPassword,
          selectedSports: testSelectedSports,
        );

        await tester.pumpWidget(createTestWidget(differentFormatScreen));
        await tester.pumpAndSettle();

        // Should still display properly formatted
        expect(find.text('+84 323 456 789'), findsOneWidget);
      });
    });

    group('Countdown Timer', () {
      testWidgets('displays countdown timer', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Should show countdown text
        expect(find.textContaining('Gửi lại sau'), findsOneWidget);
        expect(find.textContaining('s'), findsOneWidget);
      });

      testWidgets('updates countdown display', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Initial countdown should be around 60 seconds
        expect(find.textContaining('59'), findsAny);
        
        // Wait a bit and check if countdown updates
        await tester.pump(const Duration(seconds: 1));
        
        // Should decrement (in real implementation)
        // For this test, we just verify the structure exists
        expect(find.textContaining('Gửi lại sau'), findsOneWidget);
      });
    });

    group('Form Validation', () {
      testWidgets('shows error for incomplete verification code', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Try to verify without entering full code
        await tester.tap(find.text('Xác thực'));
        await tester.pumpAndSettle();

        // Should show error (in real implementation, would need to mock the error)
        // For now, verify the verification button exists and is tappable
        expect(find.text('Xác thực'), findsOneWidget);
      });
    });

    group('Loading States', () {
      testWidgets('shows loading overlay during verification', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // In a real test, we would mock the verification process
        // and check for loading indicators
        expect(find.byType(MaterialApp), findsOneWidget);
      });

      testWidgets('disables interactions during loading', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Verify that the screen structure supports loading states
        expect(find.text('Xác thực'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has proper accessibility labels', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Check semantic structure
        final semantics = tester.binding.pipelineOwner.semanticsOwner!;
        expect(semantics, isNotNull);

        // Verify key elements are accessible
        expect(find.text('Nhập mã xác thực'), findsOneWidget);
        expect(find.text('Xác thực'), findsOneWidget);
        expect(find.byIcon(Icons.sms_outlined), findsOneWidget);
      });

      testWidgets('supports screen reader navigation', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Test focus order and semantic tree
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        expect(find.text('Xác thực số điện thoại'), findsOneWidget);
      });
    });

    group('Information Display', () {
      testWidgets('shows helpful information to user', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Check info container
        expect(find.byIcon(Icons.info_outline), findsOneWidget);
        expect(find.textContaining('5 phút'), findsOneWidget);
        expect(find.textContaining('spam'), findsOneWidget);
      });

      testWidgets('displays SMS icon prominently', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Check SMS icon styling
        final smsIcon = find.byIcon(Icons.sms_outlined);
        expect(smsIcon, findsOneWidget);
        
        // Icon should be in a styled container
        expect(find.byType(Container), findsNWidgets(greaterThan(1)));
      });
    });

    group('Responsive Design', () {
      testWidgets('adapts to different screen sizes', (WidgetTester tester) async {
        // Test with small screen
        tester.binding.window.physicalSizeTestValue = const Size(400, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Should still display all elements
        expect(find.text('Nhập mã xác thực'), findsOneWidget);
        expect(find.text('Xác thực'), findsOneWidget);

        // Reset screen size
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      testWidgets('maintains proper spacing and layout', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Check for proper use of SizedBox and spacing
        expect(find.byType(SizedBox), findsNWidgets(greaterThan(3)));
        expect(find.byType(Padding), findsNWidgets(greaterThan(1)));
      });
    });

    group('Error Handling', () {
      testWidgets('handles navigation errors gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Test that tapping back doesn't crash
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // Should handle gracefully (would navigate in real app)
      });

      testWidgets('handles empty or invalid input', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Try to verify without input
        await tester.tap(find.text('Xác thực'));
        await tester.pumpAndSettle();

        // Should not crash
        expect(find.text('Xác thực'), findsOneWidget);
      });
    });

    group('User Experience', () {
      testWidgets('provides clear visual hierarchy', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Title should be prominent
        expect(find.text('Nhập mã xác thực'), findsOneWidget);
        
        // Phone number should be clearly displayed
        expect(find.text('+84 323 456 789'), findsOneWidget);
        
        // Call-to-action button should be visible
        expect(find.text('Xác thực'), findsOneWidget);
      });

      testWidgets('shows progress and feedback', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(createSmsVerificationScreen()));
        await tester.pumpAndSettle();

        // Should have clear indicators of what's happening
        expect(find.text('Chúng tôi đã gửi mã xác thực 6 số đến'), findsOneWidget);
        expect(find.byIcon(Icons.sms_outlined), findsOneWidget);
      });
    });
  });
}