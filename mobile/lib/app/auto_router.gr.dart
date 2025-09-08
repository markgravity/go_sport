// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CreateGroupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateGroupPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordPage(),
      );
    },
    GroupDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupDetailsRouteArgs>(
          orElse: () =>
              GroupDetailsRouteArgs(groupId: pathParams.getString('groupId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GroupDetailsPage(
          key: args.key,
          groupId: args.groupId,
        ),
      );
    },
    GroupsListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GroupsListPage(),
      );
    },
    InvitationManagementRoute.name: (routeData) {
      final args = routeData.argsAs<InvitationManagementRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvitationManagementScreen(
          key: args.key,
          groupId: args.groupId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    PhoneRegistrationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PhoneRegistrationScreen(),
      );
    },
    SmsVerificationRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<SmsVerificationRouteArgs>(
          orElse: () => SmsVerificationRouteArgs(
                phoneNumber: queryParams.optString('phoneNumber'),
                verificationId: queryParams.optString('verificationId'),
                userName: queryParams.optString('userName'),
                password: queryParams.optString('password'),
                selectedSports: queryParams.get(
                  'selectedSports',
                  const [],
                ),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SmsVerificationScreen(
          key: args.key,
          phoneNumber: args.phoneNumber,
          verificationId: args.verificationId,
          userName: args.userName,
          password: args.password,
          selectedSports: args.selectedSports,
        ),
      );
    },
  };
}

/// generated route for
/// [CreateGroupPage]
class CreateGroupRoute extends PageRouteInfo<void> {
  const CreateGroupRoute({List<PageRouteInfo>? children})
      : super(
          CreateGroupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateGroupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GroupDetailsPage]
class GroupDetailsRoute extends PageRouteInfo<GroupDetailsRouteArgs> {
  GroupDetailsRoute({
    Key? key,
    required String groupId,
    List<PageRouteInfo>? children,
  }) : super(
          GroupDetailsRoute.name,
          args: GroupDetailsRouteArgs(
            key: key,
            groupId: groupId,
          ),
          rawPathParams: {'groupId': groupId},
          initialChildren: children,
        );

  static const String name = 'GroupDetailsRoute';

  static const PageInfo<GroupDetailsRouteArgs> page =
      PageInfo<GroupDetailsRouteArgs>(name);
}

class GroupDetailsRouteArgs {
  const GroupDetailsRouteArgs({
    this.key,
    required this.groupId,
  });

  final Key? key;

  final String groupId;

  @override
  String toString() {
    return 'GroupDetailsRouteArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [GroupsListPage]
class GroupsListRoute extends PageRouteInfo<void> {
  const GroupsListRoute({List<PageRouteInfo>? children})
      : super(
          GroupsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupsListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InvitationManagementScreen]
class InvitationManagementRoute
    extends PageRouteInfo<InvitationManagementRouteArgs> {
  InvitationManagementRoute({
    Key? key,
    required String groupId,
    List<PageRouteInfo>? children,
  }) : super(
          InvitationManagementRoute.name,
          args: InvitationManagementRouteArgs(
            key: key,
            groupId: groupId,
          ),
          initialChildren: children,
        );

  static const String name = 'InvitationManagementRoute';

  static const PageInfo<InvitationManagementRouteArgs> page =
      PageInfo<InvitationManagementRouteArgs>(name);
}

class InvitationManagementRouteArgs {
  const InvitationManagementRouteArgs({
    this.key,
    required this.groupId,
  });

  final Key? key;

  final String groupId;

  @override
  String toString() {
    return 'InvitationManagementRouteArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PhoneRegistrationScreen]
class PhoneRegistrationRoute extends PageRouteInfo<void> {
  const PhoneRegistrationRoute({List<PageRouteInfo>? children})
      : super(
          PhoneRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRegistrationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SmsVerificationScreen]
class SmsVerificationRoute extends PageRouteInfo<SmsVerificationRouteArgs> {
  SmsVerificationRoute({
    Key? key,
    String? phoneNumber,
    String? verificationId,
    String? userName,
    String? password,
    List<String> selectedSports = const [],
    List<PageRouteInfo>? children,
  }) : super(
          SmsVerificationRoute.name,
          args: SmsVerificationRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
            verificationId: verificationId,
            userName: userName,
            password: password,
            selectedSports: selectedSports,
          ),
          rawQueryParams: {
            'phoneNumber': phoneNumber,
            'verificationId': verificationId,
            'userName': userName,
            'password': password,
            'selectedSports': selectedSports,
          },
          initialChildren: children,
        );

  static const String name = 'SmsVerificationRoute';

  static const PageInfo<SmsVerificationRouteArgs> page =
      PageInfo<SmsVerificationRouteArgs>(name);
}

class SmsVerificationRouteArgs {
  const SmsVerificationRouteArgs({
    this.key,
    this.phoneNumber,
    this.verificationId,
    this.userName,
    this.password,
    this.selectedSports = const [],
  });

  final Key? key;

  final String? phoneNumber;

  final String? verificationId;

  final String? userName;

  final String? password;

  final List<String> selectedSports;

  @override
  String toString() {
    return 'SmsVerificationRouteArgs{key: $key, phoneNumber: $phoneNumber, verificationId: $verificationId, userName: $userName, password: $password, selectedSports: $selectedSports}';
  }
}
