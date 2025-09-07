import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Core services
import '../network/api_client.dart';
import '../network/health_service.dart';
import '../network/network_status.dart';
import '../services/sports_localization_service.dart';

// Auth services
import '../../features/auth/services/api_service.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/services/firebase_auth_service.dart';
import '../../features/auth/services/phone_auth_service.dart';

// Auth Cubit and ViewModels
import '../../features/auth/presentation/viewmodels/auth_cubit.dart';
import '../../features/auth/screens/login/login_view_model.dart';
import '../../features/auth/screens/phone_registration/phone_registration_view_model.dart';
import '../../features/auth/screens/sms_verification/sms_verification_view_model.dart';

// Groups Cubits and ViewModels
import '../../features/groups/presentation/viewmodels/groups_cubit.dart';
import '../../features/groups/presentation/viewmodels/create_group_cubit.dart';
import '../../features/groups/screens/groups_list/groups_list_view_model.dart';
import '../../features/groups/screens/group_details/group_details_view_model.dart';

// Groups services
import '../../features/groups/services/groups_service.dart';
import '../../features/groups/services/image_upload_service.dart';
import '../../features/groups/services/group_role_service.dart';

// Injectable auto-generated configuration
import 'injection_container.config.dart';

// GetIt service locator instance
final getIt = GetIt.instance;

/// Configures all service dependencies for the application
/// Uses GetIt for dependency injection and Cubit for state management
@InjectableInit()
Future<void> configureDependencies() async {
  // Initialize injectable generated code
  await _initializeInjectableDependencies();
  
  // Register existing services manually for transition period
  await _registerExistingServices();
}

/// Initialize injectable auto-generated dependencies
Future<void> _initializeInjectableDependencies() async {
  // This will be populated by injectable generator
  getIt.init();
}

/// Register services with manual configuration
/// Services are registered in dependency order for proper initialization
Future<void> _registerExistingServices() async {
  // Core services - Register in dependency order
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<ApiClient>(() => ApiClient.instance);
  
  // HealthService depends on ApiClient, so register it after
  getIt.registerLazySingleton<HealthService>(() => HealthService(getIt<ApiClient>()));
  getIt.registerLazySingleton<SportsLocalizationService>(() => SportsLocalizationService());
  
  // NetworkStatusCubit depends on ApiClient
  getIt.registerFactory<NetworkStatusCubit>(() => NetworkStatusCubit(getIt<ApiClient>()));
  
  // Auth services - These handle user authentication and security
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<PhoneAuthService>(() => PhoneAuthService());
  
  // Auth Cubit - Authentication state management
  getIt.registerFactory<AuthCubit>(() => AuthCubit(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    apiService: getIt<ApiService>(),
  ));
  
  // Auth Screen ViewModels - Screen-specific state management
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(
    getIt<FirebaseAuthService>(),
    getIt<AuthService>(),
  ));
  getIt.registerFactory<PhoneRegistrationViewModel>(() => PhoneRegistrationViewModel(
    getIt<FirebaseAuthService>(),
    getIt<AuthService>(),
  ));
  getIt.registerFactory<SmsVerificationViewModel>(() => SmsVerificationViewModel(
    getIt<FirebaseAuthService>(),
    getIt<AuthService>(),
  ));
  
  // Groups Cubits - Group management state management
  getIt.registerFactory<GroupsCubit>(() => GroupsCubit());
  getIt.registerFactory<CreateGroupCubit>(() => CreateGroupCubit());
  
  // Groups services - Handle group management and interactions
  getIt.registerLazySingleton<GroupsService>(() => GroupsService());
  getIt.registerLazySingleton<ImageUploadService>(() => ImageUploadService());
  getIt.registerLazySingleton<GroupRoleService>(() => GroupRoleService());
  
  // Groups Screen ViewModels - Screen-specific state management
  getIt.registerFactory<GroupsListViewModel>(() => GroupsListViewModel(
    getIt<GroupsService>(),
  ));
  getIt.registerFactory<GroupDetailsViewModel>(() => GroupDetailsViewModel(
    getIt<GroupsService>(),
    getIt<GroupRoleService>(),
  ));
}

/// Reset all services (useful for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
}

/// Verify all services can be resolved (useful for debugging)
bool verifyDependencies() {
  try {
    // Test core services
    getIt<ApiService>();
    getIt<ApiClient>();
    getIt<HealthService>();
    getIt<SportsLocalizationService>();
    
    // Test auth services
    getIt<AuthService>();
    getIt<FirebaseAuthService>();
    getIt<PhoneAuthService>();
    
    // Test auth cubit (factory registration)
    final authCubit = getIt<AuthCubit>();
    authCubit.close(); // Close immediately after testing
    
    // Test groups cubits (factory registrations)
    final groupsCubit = getIt<GroupsCubit>();
    final createGroupCubit = getIt<CreateGroupCubit>();
    groupsCubit.close(); // Close immediately after testing
    createGroupCubit.close(); // Close immediately after testing
    
    // Test groups services
    getIt<GroupsService>();
    getIt<ImageUploadService>();
    getIt<GroupRoleService>();
    
    return true;
  } catch (e) {
    debugPrint('Dependency verification failed: $e');
    return false;
  }
}

// Extension for easy service access throughout the app
extension GetItExtension on GetIt {
  // Core services
  ApiService get apiService => get<ApiService>();
  ApiClient get apiClient => get<ApiClient>();
  HealthService get healthService => get<HealthService>();
  SportsLocalizationService get sportsLocalizationService => get<SportsLocalizationService>();
  
  // Network status cubit - Factory registration (creates new instance each time)
  NetworkStatusCubit createNetworkStatusCubit() => get<NetworkStatusCubit>();
  
  // Auth services
  AuthService get authService => get<AuthService>();
  FirebaseAuthService get firebaseAuthService => get<FirebaseAuthService>();
  PhoneAuthService get phoneAuthService => get<PhoneAuthService>();
  
  // Auth Cubit - Factory registration (creates new instance each time)
  AuthCubit createAuthCubit() => get<AuthCubit>();
  
  // Auth ViewModels - Factory registrations (create new instances each time)
  LoginViewModel createLoginViewModel() => get<LoginViewModel>();
  PhoneRegistrationViewModel createPhoneRegistrationViewModel() => get<PhoneRegistrationViewModel>();
  SmsVerificationViewModel createSmsVerificationViewModel() => get<SmsVerificationViewModel>();
  
  // Groups Cubits - Factory registrations (create new instances each time)
  GroupsCubit createGroupsCubit() => get<GroupsCubit>();
  CreateGroupCubit createCreateGroupCubit() => get<CreateGroupCubit>();
  
  // Groups services
  GroupsService get groupsService => get<GroupsService>();
  ImageUploadService get imageUploadService => get<ImageUploadService>();
  GroupRoleService get groupRoleService => get<GroupRoleService>();
  
  // Groups ViewModels - Factory registrations (create new instances each time)
  GroupsListViewModel createGroupsListViewModel() => get<GroupsListViewModel>();
  GroupDetailsViewModel createGroupDetailsViewModel() => get<GroupDetailsViewModel>();
}