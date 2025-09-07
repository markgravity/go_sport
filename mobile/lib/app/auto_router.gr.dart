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
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    PhoneRegistrationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PhoneRegistrationPage(),
      );
    },
    SmsVerificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SmsVerificationPage(),
      );
    },
    WrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WrapperPage(),
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
/// [LoginPage]
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
/// [PhoneRegistrationPage]
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
/// [SmsVerificationPage]
class SmsVerificationRoute extends PageRouteInfo<void> {
  const SmsVerificationRoute({List<PageRouteInfo>? children})
      : super(
          SmsVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SmsVerificationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WrapperPage]
class WrapperRoute extends PageRouteInfo<void> {
  const WrapperRoute({List<PageRouteInfo>? children})
      : super(
          WrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'WrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
