// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_sport_app/core/network/api_client.dart' as _i951;
import 'package:go_sport_app/core/network/health_service.dart' as _i517;
import 'package:go_sport_app/core/network/network_status.dart' as _i223;
import 'package:go_sport_app/core/services/sports_localization_service.dart'
    as _i70;
import 'package:go_sport_app/features/auth/presentation/viewmodels/auth_cubit.dart'
    as _i730;
import 'package:go_sport_app/features/auth/screens/login/login_view_model.dart'
    as _i428;
import 'package:go_sport_app/features/auth/screens/phone_registration/phone_registration_view_model.dart'
    as _i210;
import 'package:go_sport_app/features/auth/screens/sms_verification/sms_verification_view_model.dart'
    as _i1031;
import 'package:go_sport_app/features/auth/services/api_service.dart' as _i39;
import 'package:go_sport_app/features/auth/services/auth_service.dart' as _i882;
import 'package:go_sport_app/features/auth/services/firebase_auth_service.dart'
    as _i1029;
import 'package:go_sport_app/features/auth/services/phone_auth_service.dart'
    as _i612;
import 'package:go_sport_app/features/groups/presentation/viewmodels/create_group_cubit.dart'
    as _i196;
import 'package:go_sport_app/features/groups/presentation/viewmodels/groups_cubit.dart'
    as _i898;
import 'package:go_sport_app/features/groups/screens/group_details/group_details_view_model.dart'
    as _i503;
import 'package:go_sport_app/features/groups/screens/groups_list/groups_list_view_model.dart'
    as _i132;
import 'package:go_sport_app/features/groups/services/group_role_service.dart'
    as _i39;
import 'package:go_sport_app/features/groups/services/groups_service.dart'
    as _i578;
import 'package:go_sport_app/features/groups/services/image_upload_service.dart'
    as _i88;
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
    gh.factory<_i70.SportsLocalizationService>(
        () => _i70.SportsLocalizationService());
    gh.factory<_i1029.FirebaseAuthService>(() => _i1029.FirebaseAuthService());
    gh.factory<_i39.ApiService>(() => _i39.ApiService());
    gh.singleton<_i951.ApiClient>(() => _i951.ApiClient());
    gh.factory<_i730.AuthCubit>(() => _i730.AuthCubit(
          firebaseAuthService: gh<_i1029.FirebaseAuthService>(),
          apiService: gh<_i39.ApiService>(),
        ));
    gh.factory<_i517.HealthService>(
        () => _i517.HealthService(gh<_i951.ApiClient>()));
    gh.factory<_i223.NetworkStatusCubit>(
        () => _i223.NetworkStatusCubit(gh<_i951.ApiClient>()));
    gh.factory<_i882.AuthService>(
        () => _i882.AuthService(gh<_i951.ApiClient>()));
    gh.factory<_i578.GroupsService>(
        () => _i578.GroupsService(gh<_i951.ApiClient>()));
    gh.factory<_i39.GroupRoleService>(
        () => _i39.GroupRoleService(gh<_i951.ApiClient>()));
    gh.factory<_i88.ImageUploadService>(
        () => _i88.ImageUploadService(gh<_i951.ApiClient>()));
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
    gh.factory<_i612.PhoneAuthService>(
        () => _i612.PhoneAuthService(gh<_i39.ApiService>()));
    gh.factory<_i898.GroupsCubit>(
        () => _i898.GroupsCubit(gh<_i578.GroupsService>()));
    gh.factory<_i196.CreateGroupCubit>(
        () => _i196.CreateGroupCubit(gh<_i578.GroupsService>()));
    gh.factory<_i132.GroupsListViewModel>(
        () => _i132.GroupsListViewModel(gh<_i578.GroupsService>()));
    gh.factory<_i503.GroupDetailsViewModel>(() => _i503.GroupDetailsViewModel(
          gh<_i578.GroupsService>(),
          gh<_i39.GroupRoleService>(),
        ));
    return this;
  }
}
