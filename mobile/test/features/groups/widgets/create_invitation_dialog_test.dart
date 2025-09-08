import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_sport_app/features/groups/widgets/create_invitation_dialog.dart';

void main() {
  group('CreateInvitationDialog Tests', () {
    Widget createTestWidget(Widget child) {
      return MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => child,
              ),
              child: Text('Show Dialog'),
            ),
          ),
        ),
      );
    }

    testWidgets('displays all dialog elements correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {},
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Check dialog title
      expect(find.text('Tạo lời mời'), findsOneWidget);

      // Check expiry options
      expect(find.text('Hết hạn sau'), findsOneWidget);
      expect(find.text('7 ngày'), findsOneWidget);
      expect(find.text('30 ngày'), findsOneWidget);
      expect(find.text('Không hết hạn'), findsOneWidget);

      // Check buttons
      expect(find.text('Hủy'), findsOneWidget);
      expect(find.text('Tạo lời mời'), findsOneWidget);
    });

    testWidgets('selects expiry option correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {},
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Select 30 days option
      await tester.tap(find.text('30 ngày'));
      await tester.pumpAndSettle();

      // Verify selection (the radio button should be selected)
      final radioButtons = tester.widgetList<RadioListTile<int?>>(
        find.byType(RadioListTile<int?>),
      );

      final thirtyDaysRadio = radioButtons.firstWhere(
        (radio) => radio.value == 30,
      );

      expect(thirtyDaysRadio.groupValue, equals(30));
    });

    testWidgets('calls onCreateInvitation with correct expiry days', (WidgetTester tester) async {
      int? receivedExpiryDays;

      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {
            receivedExpiryDays = expiresInDays;
          },
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Select 7 days
      await tester.tap(find.text('7 ngày'));
      await tester.pumpAndSettle();

      // Tap create button
      await tester.tap(find.text('Tạo lời mời'));
      await tester.pumpAndSettle();

      expect(receivedExpiryDays, equals(7));
    });

    testWidgets('calls onCreateInvitation with null for permanent invitation', (WidgetTester tester) async {
      int? receivedExpiryDays;

      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {
            receivedExpiryDays = expiresInDays;
          },
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Select permanent option
      await tester.tap(find.text('Không hết hạn'));
      await tester.pumpAndSettle();

      // Tap create button
      await tester.tap(find.text('Tạo lời mời'));
      await tester.pumpAndSettle();

      expect(receivedExpiryDays, isNull);
    });

    testWidgets('dismisses dialog when cancel is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {},
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.text('Tạo lời mời'), findsOneWidget);

      // Tap cancel button
      await tester.tap(find.text('Hủy'));
      await tester.pumpAndSettle();

      // Verify dialog is dismissed
      expect(find.text('Tạo lời mời'), findsNothing);
    });

    testWidgets('has default selection of 7 days', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {},
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Find the radio buttons
      final radioButtons = tester.widgetList<RadioListTile<int?>>(
        find.byType(RadioListTile<int?>),
      );

      // Check that 7 days is selected by default
      final sevenDaysRadio = radioButtons.firstWhere(
        (radio) => radio.value == 7,
      );

      expect(sevenDaysRadio.groupValue, equals(7));
    });

    testWidgets('shows proper icons for each option', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {},
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Check for calendar icons (should be present for timed options)
      expect(find.byIcon(Icons.calendar_today), findsAtLeastNWidgets(2));
      
      // Check for infinity icon (permanent option)
      expect(find.byIcon(Icons.all_inclusive), findsOneWidget);
    });

    testWidgets('closes dialog after creating invitation', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {},
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.text('Tạo lời mời'), findsOneWidget);

      // Tap create button
      await tester.tap(find.text('Tạo lời mời'));
      await tester.pumpAndSettle();

      // Verify dialog is dismissed
      expect(find.text('Tạo lời mời'), findsNothing);
    });

    testWidgets('maintains selection when changing options', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        CreateInvitationDialog(
          onCreateInvitation: (expiresInDays) {},
        ),
      ));

      // Open the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Select 30 days
      await tester.tap(find.text('30 ngày'));
      await tester.pumpAndSettle();

      // Select permanent
      await tester.tap(find.text('Không hết hạn'));
      await tester.pumpAndSettle();

      // Check that permanent is now selected
      final radioButtons = tester.widgetList<RadioListTile<int?>>(
        find.byType(RadioListTile<int?>),
      );

      final permanentRadio = radioButtons.firstWhere(
        (radio) => radio.value == null,
      );

      expect(permanentRadio.groupValue, isNull);
    });
  });
}