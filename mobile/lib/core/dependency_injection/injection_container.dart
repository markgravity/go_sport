import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Core services
import '../network/api_client.dart';
import '../network/network_status.dart';

// Auth services
import '../../features/auth/services/auth_service.dart';

// Auth ViewModels
import '../../features/auth/screens/login/login_view_model.dart';
import '../../features/auth/screens/phone_registration/phone_registration_view_model.dart';
import '../../features/auth/screens/sms_verification/sms_verification_view_model.dart';

// Groups Cubits and ViewModels
import '../../features/groups/presentation/viewmodels/groups_cubit.dart';
import '../../features/groups/screens/groups_list/groups_list_view_model.dart';
import '../../features/groups/screens/group_details/group_details_view_model.dart';
import '../../features/groups/screens/create_group/create_group_view_model.dart';

// Groups services
import '../../features/groups/services/groups_service.dart';
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
  getIt.init();
  
  // Register additional services manually if needed
  await _registerAdditionalServices();
}

/// Register additional services not covered by annotations
Future<void> _registerAdditionalServices() async {
  // All services are now registered automatically via @injectable annotation
  // This function is reserved for future manual registrations if needed
}

/// Reset all services (useful for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
}

/// Verify all services can be resolved (useful for debugging)
bool verifyDependencies() {
  try {
    // Test core services
    getIt<ApiClient>();
    
    // Test auth services
    getIt<AuthService>();
    
    // Test groups services
    getIt<GroupsService>();
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
  ApiClient get apiClient => get<ApiClient>();
  
  // Auth services
  AuthService get authService => get<AuthService>();
  
  // Groups services
  GroupsService get groupsService => get<GroupsService>();
  GroupRoleService get groupRoleService => get<GroupRoleService>();
  
  // Factory methods for ViewModels and Cubits
  LoginViewModel createLoginViewModel() => get<LoginViewModel>();
  PhoneRegistrationViewModel createPhoneRegistrationViewModel() => get<PhoneRegistrationViewModel>();
  SmsVerificationViewModel createSmsVerificationViewModel() => get<SmsVerificationViewModel>();
  GroupsCubit createGroupsCubit() => get<GroupsCubit>();
  CreateGroupViewModel createCreateGroupViewModel() => get<CreateGroupViewModel>();
  GroupsListViewModel createGroupsListViewModel() => get<GroupsListViewModel>();
  GroupDetailsViewModel createGroupDetailsViewModel() => get<GroupDetailsViewModel>();
  NetworkStatusCubit createNetworkStatusCubit() => get<NetworkStatusCubit>();
}