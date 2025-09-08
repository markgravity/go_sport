import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_sport_app/features/groups/widgets/join_request_item_widget.dart';
import 'package:go_sport_app/features/groups/models/group_invitation.dart';
import 'package:go_sport_app/features/groups/models/group.dart';

void main() {
  group('JoinRequestItemWidget Tests', () {
    late GroupJoinRequest testJoinRequest;

    setUp(() {
      testJoinRequest = GroupJoinRequest(
        id: 1,
        userId: 1,
        groupId: 1,
        status: 'pending',
        message: 'I would like to join this group',
        source: 'direct',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        user: User(
          id: 1,
          name: 'Test User',
          phone: '0123456789',
          avatar: null,
        ),
      );
    });

    Widget createTestWidget(Widget child) {
      return MaterialApp(
        home: Scaffold(
          body: child,
        ),
      );
    }

    testWidgets('displays join request information correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: testJoinRequest,
          onApprove: () {},
          onReject: () {},
          isProcessing: false,
        ),
      ));

      // Check if user name is displayed
      expect(find.text('Test User'), findsOneWidget);
      
      // Check if status is displayed
      expect(find.text('Đang chờ duyệt'), findsOneWidget);
      
      // Check if message is displayed
      expect(find.text('I would like to join this group'), findsOneWidget);
      
      // Check if approve and reject buttons are present
      expect(find.text('Duyệt'), findsOneWidget);
      expect(find.text('Từ chối'), findsOneWidget);
    });

    testWidgets('shows processing state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: testJoinRequest,
          onApprove: () {},
          onReject: () {},
          isProcessing: true,
        ),
      ));

      // Buttons should be disabled when processing
      final approveButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Duyệt'),
      );
      final rejectButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Từ chối'),
      );

      expect(approveButton.onPressed, isNull);
      expect(rejectButton.onPressed, isNull);
    });

    testWidgets('calls onApprove callback when approve button is tapped', (WidgetTester tester) async {
      bool approveCallbackCalled = false;

      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: testJoinRequest,
          onApprove: () => approveCallbackCalled = true,
          onReject: () {},
          isProcessing: false,
        ),
      ));

      await tester.tap(find.text('Duyệt'));
      await tester.pump();

      expect(approveCallbackCalled, isTrue);
    });

    testWidgets('calls onReject callback when reject button is tapped', (WidgetTester tester) async {
      bool rejectCallbackCalled = false;

      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: testJoinRequest,
          onApprove: () {},
          onReject: () => rejectCallbackCalled = true,
          isProcessing: false,
        ),
      ));

      await tester.tap(find.text('Từ chối'));
      await tester.pump();

      expect(rejectCallbackCalled, isTrue);
    });

    testWidgets('displays approved status without action buttons', (WidgetTester tester) async {
      final approvedRequest = testJoinRequest.copyWith(status: 'approved');

      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: approvedRequest,
          onApprove: null,
          onReject: null,
          isProcessing: false,
        ),
      ));

      expect(find.text('Đã duyệt'), findsOneWidget);
      expect(find.text('Duyệt'), findsNothing);
      expect(find.text('Từ chối'), findsNothing);
    });

    testWidgets('displays rejected status without action buttons', (WidgetTester tester) async {
      final rejectedRequest = testJoinRequest.copyWith(
        status: 'rejected',
        rejectionReason: 'Not suitable for the group',
      );

      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: rejectedRequest,
          onApprove: null,
          onReject: null,
          isProcessing: false,
        ),
      ));

      expect(find.text('Đã từ chối'), findsOneWidget);
      expect(find.text('Not suitable for the group'), findsOneWidget);
      expect(find.text('Duyệt'), findsNothing);
      expect(find.text('Từ chối'), findsNothing);
    });

    testWidgets('shows user avatar when available', (WidgetTester tester) async {
      final requestWithAvatar = testJoinRequest.copyWith(
        user: testJoinRequest.user?.copyWith(
          avatar: 'https://example.com/avatar.jpg',
        ),
      );

      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: requestWithAvatar,
          onApprove: () {},
          onReject: () {},
          isProcessing: false,
        ),
      ));

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('shows default avatar when user avatar is null', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: testJoinRequest,
          onApprove: () {},
          onReject: () {},
          isProcessing: false,
        ),
      ));

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('displays source information correctly', (WidgetTester tester) async {
      final invitationRequest = testJoinRequest.copyWith(source: 'invitation_link');

      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: invitationRequest,
          onApprove: () {},
          onReject: () {},
          isProcessing: false,
        ),
      ));

      expect(find.textContaining('qua lời mời'), findsOneWidget);
    });

    testWidgets('displays creation time correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: testJoinRequest,
          onApprove: () {},
          onReject: () {},
          isProcessing: false,
        ),
      ));

      // Should show relative time or formatted date
      expect(find.textContaining('giây trước'), findsWidgets);
    });

    testWidgets('handles null callbacks gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        JoinRequestItemWidget(
          joinRequest: testJoinRequest,
          onApprove: null,
          onReject: null,
          isProcessing: false,
        ),
      ));

      // Should not show action buttons when callbacks are null
      expect(find.text('Duyệt'), findsNothing);
      expect(find.text('Từ chối'), findsNothing);
    });
  });
}