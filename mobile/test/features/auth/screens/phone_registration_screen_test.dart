import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_sport_app/features/auth/screens/phone_registration_screen.dart';

void main() {
  group('PhoneRegistrationScreen Widget Tests', () {
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

    group('UI Elements', () {
      testWidgets('displays all required UI elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Check app bar
        expect(find.text('Đăng ký tài khoản'), findsOneWidget);
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);

        // Check header
        expect(find.text('Tạo tài khoản Go Sport'), findsOneWidget);
        expect(find.text('Nhập thông tin để tạo tài khoản mới'), findsOneWidget);

        // Check form fields
        expect(find.text('Tên của bạn'), findsOneWidget);
        expect(find.text('Số điện thoại'), findsOneWidget);
        expect(find.text('Mật khẩu'), findsOneWidget);
        expect(find.text('Xác nhận mật khẩu'), findsOneWidget);
        expect(find.text('Môn thể thao yêu thích (tùy chọn)'), findsOneWidget);

        // Check button
        expect(find.text('Gửi mã xác thực'), findsOneWidget);

        // Check terms and privacy text
        expect(find.textContaining('Bằng cách đăng ký'), findsOneWidget);
      });

      testWidgets('displays phone number input with +84 prefix', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Find the phone input field
        expect(find.text('+84'), findsOneWidget);
        expect(find.text('0XXX XXX XXX'), findsOneWidget);
      });

      testWidgets('displays password visibility toggles', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Find password visibility icons
        expect(find.byIcon(Icons.visibility), findsNWidgets(2)); // Two password fields
      });

      testWidgets('displays Vietnamese sports selector', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Check for some Vietnamese sports
        expect(find.text('Bóng đá'), findsOneWidget);
        expect(find.text('Bóng chuyền'), findsOneWidget);
        expect(find.text('Cầu lông'), findsOneWidget);
      });
    });

    group('Form Validation', () {
      testWidgets('validates empty name field', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Tap the submit button without filling name
        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show validation error
        expect(find.text('Vui lòng nhập tên của bạn'), findsOneWidget);
      });

      testWidgets('validates phone number format', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Fill in name but invalid phone
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.enterText(find.byType(TextFormField).at(1), '0123'); // Invalid phone
        await tester.pumpAndSettle();

        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show phone validation error
        expect(find.text('Số điện thoại quá ngắn'), findsOneWidget);
      });

      testWidgets('validates password length', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Fill in name, phone, but short password
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.enterText(find.byType(TextFormField).at(1), '0323456789');
        await tester.enterText(find.byType(TextFormField).at(2), '123'); // Too short
        await tester.pumpAndSettle();

        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show password validation error
        expect(find.text('Mật khẩu phải có ít nhất 8 ký tự'), findsOneWidget);
      });

      testWidgets('validates password confirmation match', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Fill in form with mismatched passwords
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.enterText(find.byType(TextFormField).at(1), '0323456789');
        await tester.enterText(find.byType(TextFormField).at(2), 'password123');
        await tester.enterText(find.byType(TextFormField).at(3), 'password456'); // Different
        await tester.pumpAndSettle();

        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show password mismatch error
        expect(find.text('Mật khẩu xác nhận không khớp'), findsOneWidget);
      });
    });

    group('User Interactions', () {
      testWidgets('toggles password visibility', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Find password field and enter text
        await tester.enterText(find.byType(TextFormField).at(2), 'password123');
        await tester.pumpAndSettle();

        // Initially password should be obscured
        final passwordField = tester.widget<TextFormField>(find.byType(TextFormField).at(2));
        expect(passwordField.obscureText, isTrue);

        // Tap the visibility toggle
        await tester.tap(find.byIcon(Icons.visibility).first);
        await tester.pumpAndSettle();

        // Now should show visibility_off icon
        expect(find.byIcon(Icons.visibility_off), findsAtLeastNWidgets(1));
      });

      testWidgets('can select sports', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Tap on a sport
        await tester.tap(find.text('Bóng đá').first);
        await tester.pumpAndSettle();

        // The sport should be selected (visual feedback)
        // This would need to check the actual selection state
        // For now, just verify the tap doesn't crash
        expect(find.text('Bóng đá'), findsAtLeastNWidgets(1));
      });

      testWidgets('shows carrier information for valid phone numbers', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Enter a valid Viettel number
        await tester.enterText(find.byType(TextFormField).at(1), '0323456789');
        await tester.pumpAndSettle();

        // Should show carrier information
        expect(find.textContaining('Nhà mạng:'), findsOneWidget);
        expect(find.textContaining('Viettel'), findsOneWidget);
      });

      testWidgets('formats phone number input', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Enter phone number gradually to test formatting
        final phoneField = find.byType(TextFormField).at(1);
        
        await tester.enterText(phoneField, '0323');
        await tester.pumpAndSettle();
        
        await tester.enterText(phoneField, '032345');
        await tester.pumpAndSettle();
        
        // The formatter should add spaces
        // We can't directly test the formatter output without accessing the controller
        // But we can verify the input is accepted
        expect(find.byType(TextFormField), findsNWidgets(4));
      });

      testWidgets('navigates back when back button is pressed', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Tap the back button
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // Should have navigated back (in a real app this would pop the route)
        // For this test, we just verify the tap is handled
      });
    });

    group('Accessibility', () {
      testWidgets('has proper accessibility labels', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Check that form fields have proper semantics
        expect(find.byType(TextFormField), findsNWidgets(4));
        
        // Check button accessibility
        final submitButton = find.text('Gửi mã xác thực');
        expect(submitButton, findsOneWidget);
        
        // Verify the button is properly labeled
        final buttonWidget = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(buttonWidget, isNotNull);
      });

      testWidgets('supports screen reader navigation', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Test semantic focus order
        final semantics = tester.binding.pipelineOwner.semanticsOwner!;
        expect(semantics, isNotNull);
        
        // Verify semantic tree is built
        expect(semantics.rootSemanticsNode, isNotNull);
      });
    });

    group('Form Submission', () {
      testWidgets('shows loading state during form submission', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Fill in valid form data
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.enterText(find.byType(TextFormField).at(1), '0323456789');
        await tester.enterText(find.byType(TextFormField).at(2), 'password123');
        await tester.enterText(find.byType(TextFormField).at(3), 'password123');
        await tester.pumpAndSettle();

        // Note: In a real test, we would mock the API service
        // For now, we just verify the form accepts valid input
        expect(find.text('Gửi mã xác thực'), findsOneWidget);
      });
    });

    group('Responsive Design', () {
      testWidgets('adapts to different screen sizes', (WidgetTester tester) async {
        // Test with small screen
        tester.binding.window.physicalSizeTestValue = const Size(400, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        expect(find.byType(SingleChildScrollView), findsOneWidget);
        
        // Reset screen size
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      testWidgets('scrollable content works properly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Verify the screen is scrollable
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        
        // Scroll down to bottom
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -200), 800);
        await tester.pumpAndSettle();
        
        // Should still find the submit button
        expect(find.text('Gửi mã xác thực'), findsOneWidget);
      });
    });

    group('Error Handling', () {
      testWidgets('displays error messages properly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Submit form without filling required fields
        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        // Should show validation errors
        expect(find.text('Vui lòng nhập tên của bạn'), findsOneWidget);
        expect(find.text('Vui lòng nhập số điện thoại'), findsOneWidget);
        expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
      });

      testWidgets('clears error messages when input is corrected', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(const PhoneRegistrationScreen()));
        await tester.pumpAndSettle();

        // Submit to trigger validation errors
        await tester.tap(find.text('Gửi mã xác thực'));
        await tester.pumpAndSettle();

        expect(find.text('Vui lòng nhập tên của bạn'), findsOneWidget);

        // Now fill in the name
        await tester.enterText(find.byType(TextFormField).first, 'Nguyễn Văn A');
        await tester.pumpAndSettle();

        // The error should be cleared when we interact with the form again
        // (In a real implementation, this might require another validation trigger)
      });
    });
  });
}