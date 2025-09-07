// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_sport_app/features/auth/screens/login/login_view_model.dart'
    as _i428;
import 'package:go_sport_app/features/auth/screens/phone_registration/phone_registration_view_model.dart'
    as _i210;
import 'package:go_sport_app/features/auth/screens/sms_verification/sms_verification_view_model.dart'
    as _i1031;
import 'package:go_sport_app/features/auth/services/auth_service.dart' as _i882;
import 'package:go_sport_app/features/auth/services/firebase_auth_service.dart'
    as _i1029;
import 'package:go_sport_app/features/groups/screens/group_details/group_details_view_model.dart'
    as _i503;
import 'package:go_sport_app/features/groups/screens/groups_list/groups_list_view_model.dart'
    as _i132;
import 'package:go_sport_app/features/groups/services/group_role_service.dart'
    as _i39;
import 'package:go_sport_app/features/groups/services/groups_service.dart'
    as _i578;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i132.GroupsListViewModel>(
        () => _i132.GroupsListViewModel(gh<_i578.GroupsService>()));
    gh.factory<_i503.GroupDetailsViewModel>(() => _i503.GroupDetailsViewModel(
          gh<_i578.GroupsService>(),
          gh<_i39.GroupRoleService>(),
        ));
    gh.factory<_i1031.SmsVerificationViewModel>(
        () => _i1031.SmsVerificationViewModel(
              gh<_i1029.FirebaseAuthService>(),
              gh<_i882.AuthService>(),
            ));
    gh.factory<_i210.PhoneRegistrationViewModel>(
        () => _i210.PhoneRegistrationViewModel(
              gh<_i1029.FirebaseAuthService>(),
              gh<_i882.AuthService>(),
            ));
    gh.factory<_i428.LoginViewModel>(() => _i428.LoginViewModel(
          gh<_i1029.FirebaseAuthService>(),
          gh<_i882.AuthService>(),
        ));
    return this;
  }
}
