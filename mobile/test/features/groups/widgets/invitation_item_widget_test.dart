import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_sport_app/features/groups/widgets/invitation_item_widget.dart';
import 'package:go_sport_app/features/groups/models/group_invitation.dart';
import 'package:go_sport_app/features/groups/models/group.dart';

void main() {
  group('InvitationItemWidget Tests', () {
    late GroupInvitation testInvitation;

    setUp(() {
      testInvitation = GroupInvitation(
        id: 1,
        groupId: 1,
        token: 'test-token-123',
        type: 'link',
        status: 'active',
        createdBy: 1,
        expiresAt: DateTime.now().add(Duration(days: 7)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        creator: User(id: 1, name: 'Test User', phone: '0123456789'),
      );
    });

    Widget createTestWidget(Widget child) {
      return MaterialApp(
        home: Scaffold(
          body: child,
        ),
      );
    }

    testWidgets('displays invitation information correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        InvitationItemWidget(
          invitation: testInvitation,
          onShare: () {},
          onCopy: () {},
          onDelete: () {},
        ),
      ));

      // Check if invitation URL is displayed
      expect(find.textContaining('test-token-123'), findsOneWidget);
      
      // Check if creator name is displayed
      expect(find.text('Test User'), findsOneWidget);
      
      // Check if status is displayed
      expect(find.text('Hoạt động'), findsOneWidget);
      
      // Check if action buttons are present
      expect(find.byIcon(Icons.share), findsOneWidget);
      expect(find.byIcon(Icons.content_copy), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('shows expiry information for expiring invitations', (WidgetTester tester) async {
      final expiringInvitation = testInvitation.copyWith(
        expiresAt: DateTime.now().add(Duration(days: 2)),
      );

      await tester.pumpWidget(createTestWidget(
        InvitationItemWidget(
          invitation: expiringInvitation,
          onShare: () {},
          onCopy: () {},
          onDelete: () {},
        ),
      ));

      expect(find.textContaining('Hết hạn sau'), findsOneWidget);
    });

    testWidgets('shows permanent status for non-expiring invitations', (WidgetTester tester) async {
      final permanentInvitation = testInvitation.copyWith(expiresAt: null);

      await tester.pumpWidget(createTestWidget(
        InvitationItemWidget(
          invitation: permanentInvitation,
          onShare: () {},
          onCopy: () {},
          onDelete: () {},
        ),
      ));

      expect(find.text('Vĩnh viễn'), findsOneWidget);
    });

    testWidgets('calls onShare callback when share button is tapped', (WidgetTester tester) async {
      bool shareCallbackCalled = false;

      await tester.pumpWidget(createTestWidget(
        InvitationItemWidget(
          invitation: testInvitation,
          onShare: () => shareCallbackCalled = true,
          onCopy: () {},
          onDelete: () {},
        ),
      ));

      await tester.tap(find.byIcon(Icons.share));
      await tester.pump();

      expect(shareCallbackCalled, isTrue);
    });

    testWidgets('calls onCopy callback when copy button is tapped', (WidgetTester tester) async {
      bool copyCallbackCalled = false;

      await tester.pumpWidget(createTestWidget(
        InvitationItemWidget(
          invitation: testInvitation,
          onShare: () {},
          onCopy: () => copyCallbackCalled = true,
          onDelete: () {},
        ),
      ));

      await tester.tap(find.byIcon(Icons.content_copy));
      await tester.pump();

      expect(copyCallbackCalled, isTrue);
    });

    testWidgets('calls onDelete callback when delete button is tapped', (WidgetTester tester) async {
      bool deleteCallbackCalled = false;

      await tester.pumpWidget(createTestWidget(
        InvitationItemWidget(
          invitation: testInvitation,
          onShare: () {},
          onCopy: () {},
          onDelete: () => deleteCallbackCalled = true,
        ),
      ));

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      expect(deleteCallbackCalled, isTrue);
    });

    testWidgets('displays different status colors for different statuses', (WidgetTester tester) async {
      final expiredInvitation = testInvitation.copyWith(status: 'expired');

      await tester.pumpWidget(createTestWidget(
        InvitationItemWidget(
          invitation: expiredInvitation,
          onShare: () {},
          onCopy: () {},
          onDelete: () {},
        ),
      ));

      expect(find.text('Đã hết hạn'), findsOneWidget);
    });

    testWidgets('shows creation date correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        InvitationItemWidget(
          invitation: testInvitation,
          onShare: () {},
          onCopy: () {},
          onDelete: () {},
        ),
      ));

      // Look for date formatting
      expect(find.textContaining('Tạo lúc'), findsOneWidget);
    });
  });
}