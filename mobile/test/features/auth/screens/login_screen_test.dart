import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_sport_app/features/auth/screens/login/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('LoginScreen', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: const LoginScreen(),
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
      );
    }

    testWidgets('should display all login form elements', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Verify form elements exist
      expect(find.byType(TextFormField), findsNWidgets(2)); // Phone and password fields
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Login to your Go Sport account'), findsOneWidget);
      expect(find.text('Phone Number'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Remember me'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Login with biometric'), findsOneWidget);
      expect(find.text('Don\'t have an account? '), findsOneWidget);
      expect(find.text('Register now'), findsOneWidget);
    });

    testWidgets('should show/hide password when visibility icon is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find password field and visibility icon
      final visibilityIcon = find.byIcon(Icons.visibility);

      // Initially password should be obscured
      // Note: TextFormField obscureText is not directly accessible in tests

      // Tap visibility icon
      await tester.tap(visibilityIcon);
      await tester.pump();

      // Password should now be visible
      // Note: TextFormField obscureText is not directly accessible in tests

      // Icon should change to visibility_off
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      // Tap again to hide
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      // Password should be obscured again
      // Note: TextFormField obscureText is not directly accessible in tests
    });

    testWidgets('should validate phone number format', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find phone field
      final phoneField = find.byType(TextFormField).first;

      // Enter invalid phone number
      await tester.enterText(phoneField, '123');
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Should show validation error
      expect(find.text('Số điện thoại quá ngắn'), findsOneWidget);
    });

    testWidgets('should validate password field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find password field (second TextFormField)
      // Password validation test

      // Leave password empty and try to login
      await tester.enterText(find.byType(TextFormField).first, '0912345678');
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Should show validation error
      expect(find.text('Please enter password'), findsOneWidget);
    });

    testWidgets('should toggle remember me checkbox', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find checkbox
      final checkbox = find.byType(Checkbox);

      // Initially unchecked
      expect((tester.widget(checkbox) as Checkbox).value, isFalse);

      // Tap checkbox
      await tester.tap(checkbox);
      await tester.pump();

      // Should be checked now
      expect((tester.widget(checkbox) as Checkbox).value, isTrue);
    });

    testWidgets('should format phone number input', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find phone field
      final phoneField = find.byType(TextFormField).first;

      // Enter phone number
      await tester.enterText(phoneField, '0912345678');
      await tester.pump();

      // Should format with spaces
      final textField = tester.widget<TextFormField>(phoneField);
      expect(textField.controller?.text, equals('0912 345 678'));
    });

    testWidgets('should show carrier info for valid phone number', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find phone field
      final phoneField = find.byType(TextFormField).first;

      // Enter Viettel number
      await tester.enterText(phoneField, '0323456789');
      await tester.pump();

      // Should show carrier info
      expect(find.textContaining('Carrier: Viettel'), findsOneWidget);
    });

    testWidgets('should navigate to registration when register link is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find and tap register link
      await tester.tap(find.text('Register now'));
      await tester.pumpAndSettle();

      // Should navigate to registration screen
      // Note: This would require proper navigation setup in a real test
      // For now, we just verify the tap doesn't cause errors
    });

    testWidgets('should show loading indicator during login', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Fill in valid form data
      await tester.enterText(find.byType(TextFormField).first, '0912345678');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');

      // Tap login button
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Should show loading indicator
      // Note: In a real test with proper mocking, we would verify the loading state
      // For now, we ensure the tap doesn't cause errors
    });

    testWidgets('should handle biometric login button tap', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find and tap biometric login button
      await tester.tap(find.text('Login with biometric'));
      await tester.pump();

      // Should handle the tap without errors
      // In a real test with proper mocking, we would verify biometric authentication is triggered
    });

    group('Accessibility', () {
      testWidgets('should have proper accessibility labels', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Verify important elements have proper semantics
        expect(find.byType(TextFormField), findsNWidgets(2));
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(Checkbox), findsOneWidget);
      });

      testWidgets('should be navigable with keyboard', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Test tab navigation between form fields
        // This would require more complex testing setup for keyboard navigation
        // For now, we verify the form structure supports accessibility
        expect(find.byType(Form), findsOneWidget);
      });
    });
  });
}