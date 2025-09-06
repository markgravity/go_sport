import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Core services
import '../network/api_client.dart';
import '../network/health_service.dart';
import '../services/sports_localization_service.dart';

// Auth services
import '../../features/auth/services/api_service.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/services/firebase_auth_service.dart';
import '../../features/auth/services/phone_auth_service.dart';

// Auth Cubit (New architecture)
import '../../features/auth/presentation/viewmodels/auth_cubit.dart';

// Groups services
import '../../features/groups/services/groups_service.dart';
import '../../features/groups/services/image_upload_service.dart';
import '../../features/groups/services/group_role_service.dart';

// Injectable auto-generated configuration
import 'injection_container.config.dart';

// GetIt service locator instance
final getIt = GetIt.instance;

/// Configures all service dependencies for the application
/// This setup supports coexistence with Riverpod during migration
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

/// Register existing services that haven't been migrated to injectable yet
/// TODO: These will be gradually moved to @injectable annotations during migration
Future<void> _registerExistingServices() async {
  // Core services - Register in dependency order
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<ApiClient>(() => ApiClient.instance);
  
  // HealthService depends on ApiClient, so register it after
  getIt.registerLazySingleton<HealthService>(() => HealthService(getIt<ApiClient>()));
  getIt.registerLazySingleton<SportsLocalizationService>(() => SportsLocalizationService());
  
  // Auth services - These handle user authentication and security
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<PhoneAuthService>(() => PhoneAuthService());
  
  // Auth Cubit - New Cubit architecture for authentication
  getIt.registerFactory<AuthCubit>(() => AuthCubit(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    apiService: getIt<ApiService>(),
  ));
  
  // Groups services - Handle group management and interactions
  getIt.registerLazySingleton<GroupsService>(() => GroupsService());
  getIt.registerLazySingleton<ImageUploadService>(() => ImageUploadService());
  getIt.registerLazySingleton<GroupRoleService>(() => GroupRoleService());
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
  
  // Auth services
  AuthService get authService => get<AuthService>();
  FirebaseAuthService get firebaseAuthService => get<FirebaseAuthService>();
  PhoneAuthService get phoneAuthService => get<PhoneAuthService>();
  
  // Auth Cubit - Factory registration (creates new instance each time)
  AuthCubit createAuthCubit() => get<AuthCubit>();
  
  // Groups services
  GroupsService get groupsService => get<GroupsService>();
  ImageUploadService get imageUploadService => get<ImageUploadService>();
  GroupRoleService get groupRoleService => get<GroupRoleService>();
}