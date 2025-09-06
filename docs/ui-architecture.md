# Go Sport App Frontend Architecture Document

## Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-08-28 | v1.0 | Initial Flutter frontend architecture creation | Winston (Architect) |
| 2025-09-06 | v2.0 | Updated to Cubit+AutoRoute+GetIt+MVVM+Freezed architecture | Winston (Architect) |

---

## Template and Framework Selection

### Migration from Riverpod to Cubit Architecture

**Current State:** Flutter app using Riverpod + GoRouter  
**Target Architecture:** Cubit + AutoRoute + GetIt + MVVM + Freezed

**Migration Strategy:** Incremental feature-by-feature migration maintaining backward compatibility during transition period.

**Framework Decision:** Flutter 3.35.2 with MVVM pattern implementation using Cubit for state management, providing simpler imperative state handling ideal for Vietnamese sports coordination workflows.

---

## Frontend Tech Stack

### Technology Stack Table

| Category | Technology | Version | Purpose | Rationale |
|----------|------------|---------|---------|-----------|
| **Framework** | Flutter | 3.35.2 | Cross-platform mobile development | Strong Vietnamese developer community, single codebase for iOS/Android |
| **Architecture Pattern** | MVVM | - | Separation of concerns with ViewModels | Clear business logic separation, testable architecture |
| **State Management** | Flutter Bloc (Cubit) | 8.1.3 | Business logic and state management | Simpler than full Bloc pattern, predictable state changes |
| **Dependency Injection** | GetIt | 8.0.0 | Service location and DI | Lightweight, explicit dependency management |
| **Routing** | AutoRoute | 8.0.3 | Type-safe navigation and routing | Superior code generation, type safety vs GoRouter |
| **Code Generation** | Freezed | 2.4.6 | Immutable data classes | Already integrated, reduces boilerplate |
| **JSON Serialization** | json_annotation | 4.8.1 | API response handling | Existing integration with Freezed |
| **HTTP Client** | Dio | 5.4.0 | API communication | Interceptor support for auth tokens |
| **Local Storage** | Hive | 2.2.3 | Offline data caching | NoSQL local database for attendance responses |
| **Secure Storage** | flutter_secure_storage | 9.0.0 | Encrypted token storage | Vietnamese compliance for sensitive data |
| **Form Handling** | Reactive Forms | 17.0.1 | Complex form validation | Better than FormBuilder for Vietnamese data validation |
| **Styling** | Flutter Material 3 | - | UI component system | Vietnamese culturally appropriate design system |
| **Localization** | Flutter Intl | 0.19.0 | Vietnamese/English i18n | Already configured for Vietnamese market |
| **Testing** | Flutter Test + Mockito | 5.4.4 | Unit and widget testing | Comprehensive testing for payment flows |
| **Build System** | Flutter SDK | 3.35.2 | Development and production builds | Standard Flutter toolchain |

---

## Project Structure

```plaintext
mobile/
├── lib/
│   ├── main.dart                              # App entry point with GetIt setup
│   │
│   ├── app/
│   │   ├── app.dart                          # MaterialApp with AutoRoute
│   │   ├── app_router.dart                   # AutoRoute configuration
│   │   └── app_router.gr.dart               # Generated route definitions
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_constants.dart           # Global constants
│   │   │   ├── api_endpoints.dart           # API endpoint definitions
│   │   │   └── vietnamese_constants.dart     # Vietnamese cultural constants
│   │   ├── dependency_injection/
│   │   │   ├── injection_container.dart      # GetIt service registration
│   │   │   └── injection_container.config.dart  # Generated DI config
│   │   ├── errors/
│   │   │   ├── exceptions.dart              # Custom exception classes
│   │   │   ├── failures.dart                # Failure classes for Either pattern
│   │   │   └── vietnamese_errors.dart        # Vietnamese error messages
│   │   ├── network/
│   │   │   ├── api_client.dart              # Dio HTTP client setup
│   │   │   ├── auth_interceptor.dart        # Token authentication
│   │   │   └── network_info.dart            # Connectivity checking
│   │   ├── storage/
│   │   │   ├── hive_storage.dart            # Hive database setup
│   │   │   ├── secure_storage.dart          # Encrypted storage wrapper
│   │   │   └── attendance_cache.dart        # Offline attendance storage
│   │   └── utils/
│   │       ├── vietnamese_phone_validator.dart
│   │       ├── currency_formatter.dart       # VND formatting
│   │       └── datetime_extensions.dart      # Vietnam timezone utilities
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   │   └── auth_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── user_model.dart       # Freezed user model
│   │   │   │   │   └── auth_tokens.dart      # Token management model
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── user_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── login_with_phone.dart
│   │   │   │       ├── verify_sms_code.dart
│   │   │   │       └── logout.dart
│   │   │   └── presentation/
│   │   │       ├── viewmodels/
│   │   │       │   ├── auth_cubit.dart       # Authentication state management
│   │   │       │   ├── auth_state.dart       # Freezed auth states
│   │   │       │   ├── login_cubit.dart      # Login form handling
│   │   │       │   └── phone_verification_cubit.dart
│   │   │       ├── screens/
│   │   │       │   ├── login_screen.dart     # AutoRoute annotated
│   │   │       │   ├── phone_registration_screen.dart
│   │   │       │   └── sms_verification_screen.dart
│   │   │       └── widgets/
│   │   │           ├── vietnamese_phone_input.dart
│   │   │           ├── sms_code_input.dart
│   │   │           └── sport_preference_selector.dart
│   │   │
│   │   ├── groups/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   ├── models/
│   │   │   │   │   ├── group_model.dart      # Freezed group model
│   │   │   │   │   └── membership_model.dart
│   │   │   │   └── repositories/
│   │   │   └── presentation/
│   │   │       ├── viewmodels/
│   │   │       │   ├── groups_cubit.dart     # Group list management
│   │   │       │   ├── create_group_cubit.dart
│   │   │       │   └── group_details_cubit.dart
│   │   │       ├── screens/
│   │   │       │   ├── groups_list_screen.dart
│   │   │       │   ├── create_group_screen.dart
│   │   │       │   └── group_details_screen.dart
│   │   │       └── widgets/
│   │   │           ├── group_card.dart
│   │   │           ├── role_badge.dart        # Vietnamese role display
│   │   │           └── sport_icon.dart
│   │   │
│   │   ├── attendance/
│   │   │   ├── presentation/
│   │   │   │   ├── viewmodels/
│   │   │   │   │   ├── attendance_cubit.dart
│   │   │   │   │   └── attendance_response_cubit.dart
│   │   │   │   ├── screens/
│   │   │   │   │   ├── attendance_request_screen.dart
│   │   │   │   │   └── attendance_status_screen.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── attendance_response_widget.dart
│   │   │   │       └── headcount_display.dart
│   │   │   └── # ... data/domain layers
│   │   │
│   │   └── payments/
│   │       ├── presentation/
│   │       │   ├── viewmodels/
│   │       │   │   ├── payment_session_cubit.dart
│   │       │   │   └── qr_payment_cubit.dart
│   │       │   ├── screens/
│   │       │   │   ├── payment_session_screen.dart
│   │       │   │   └── qr_payment_screen.dart
│   │       │   └── widgets/
│   │       │       ├── vietnamese_payment_methods.dart
│   │       │       ├── qr_code_display.dart
│   │       │       └── payment_status_tracker.dart
│   │       └── # ... data/domain layers
│   │
│   ├── shared/
│   │   ├── widgets/
│   │   │   ├── vietnamese_app_bar.dart        # Cultural UI patterns
│   │   │   ├── loading_indicator.dart
│   │   │   ├── error_display.dart
│   │   │   ├── vietnamese_currency_display.dart
│   │   │   └── confirmation_dialog.dart
│   │   ├── extensions/
│   │   │   ├── context_extensions.dart
│   │   │   ├── string_extensions.dart         # Vietnamese text helpers
│   │   │   └── datetime_extensions.dart
│   │   └── mixins/
│   │       ├── validation_mixin.dart
│   │       └── vietnamese_input_mixin.dart
│   │
│   └── l10n/
│       ├── arb/
│       │   ├── app_en.arb                    # English translations
│       │   └── app_vi.arb                    # Vietnamese translations
│       └── l10n.dart                         # Generated localization
│
├── test/
│   ├── fixtures/                             # JSON test data
│   ├── helpers/                              # Test utilities
│   ├── unit/                                # Unit tests mirroring lib/
│   ├── widget/                              # Widget tests
│   └── integration/                         # Integration tests
│
├── android/                                 # Android configuration
├── ios/                                     # iOS configuration
├── assets/                                  # Images and static assets
│   ├── images/
│   ├── icons/
│   └── vietnamese_sports/                   # Vietnamese sport icons
│
├── pubspec.yaml                            # Dependencies configuration
└── analysis_options.yaml                  # Linting rules
```

---

## Component Standards

### Component Template

```dart
// Feature ViewModel Template (Cubit)
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'example_cubit.freezed.dart';

@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = _Initial;
  const factory ExampleState.loading() = _Loading;
  const factory ExampleState.loaded(List<ExampleModel> items) = _Loaded;
  const factory ExampleState.error(String message) = _Error;
}

@injectable
class ExampleCubit extends Cubit<ExampleState> {
  final ExampleRepository _repository;
  
  ExampleCubit(this._repository) : super(const ExampleState.initial());
  
  Future<void> loadData() async {
    emit(const ExampleState.loading());
    try {
      final result = await _repository.getData();
      emit(ExampleState.loaded(result));
    } catch (e) {
      emit(ExampleState.error(e.toString()));
    }
  }
}

// Screen Template with AutoRoute
@autoRoute
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<ExampleCubit>()..loadData(),
      child: const _ExampleView(),
    );
  }
}

class _ExampleView extends StatelessWidget {
  const _ExampleView();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.exampleTitle),
      ),
      body: BlocBuilder<ExampleCubit, ExampleState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (items) => ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(items[index].name),
              ),
            ),
            error: (message) => Center(
              child: Column(
                children: [
                  Icon(Icons.error, color: Theme.of(context).errorColor),
                  Text(message),
                  ElevatedButton(
                    onPressed: () => context.read<ExampleCubit>().loadData(),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| **Screen Classes** | `{Feature}Screen` | `LoginScreen`, `GroupDetailsScreen` |
| **ViewModel Classes** | `{Feature}Cubit` | `AuthCubit`, `GroupsCubit` |
| **State Classes** | `{Feature}State` | `AuthState`, `AttendanceState` |
| **Model Classes** | `{Entity}Model` | `UserModel`, `GroupModel` |
| **Widget Classes** | `{Purpose}Widget` | `LoadingWidget`, `VietnamesePhoneInput` |
| **Repository Classes** | `{Feature}Repository` | `AuthRepository`, `PaymentRepository` |
| **Use Case Classes** | `{Action}{Entity}` | `LoginWithPhone`, `CreateGroup` |
| **File Names** | `snake_case` | `auth_cubit.dart`, `group_details_screen.dart` |
| **Folder Names** | `snake_case` | `vietnamese_constants`, `payment_methods` |

---

## State Management

### Store Structure

```plaintext
State Management Architecture:
├── Cubit (Business Logic)
│   ├── {Feature}Cubit
│   ├── {Feature}State (Freezed)
│   └── State Transitions
│
├── Repository Pattern
│   ├── Abstract Repository
│   ├── Implementation
│   └── Data Sources (Remote/Local)
│
└── Dependency Injection
    ├── GetIt Service Locator
    ├── Injectable Annotations
    └── Auto-generated Configuration
```

### State Management Template

```dart
// State Definition with Freezed
@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticating() = _Authenticating;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.phoneVerificationRequired(String phoneNumber) = _PhoneVerificationRequired;
  const factory AuthState.error(String message, {String? errorCode}) = _AuthError;
}

// Cubit Implementation
@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final SecureStorage _secureStorage;
  
  AuthCubit(
    this._authRepository,
    this._secureStorage,
  ) : super(const AuthState.unauthenticated());
  
  Future<void> loginWithPhone(String phoneNumber) async {
    emit(const AuthState.authenticating());
    
    try {
      final result = await _authRepository.sendVerificationCode(phoneNumber);
      result.fold(
        (failure) => emit(AuthState.error(failure.message, errorCode: failure.code)),
        (success) => emit(AuthState.phoneVerificationRequired(phoneNumber)),
      );
    } catch (e) {
      emit(AuthState.error('Unexpected error occurred'));
    }
  }
  
  Future<void> verifyCode(String phoneNumber, String code) async {
    if (state is! _PhoneVerificationRequired) return;
    
    emit(const AuthState.authenticating());
    
    try {
      final result = await _authRepository.verifyCode(phoneNumber, code);
      result.fold(
        (failure) => emit(AuthState.error(failure.message, errorCode: failure.code)),
        (user) async {
          await _secureStorage.storeAuthTokens(user.tokens);
          emit(AuthState.authenticated(user));
        },
      );
    } catch (e) {
      emit(AuthState.error('Verification failed'));
    }
  }
  
  Future<void> logout() async {
    await _secureStorage.clearAuthTokens();
    emit(const AuthState.unauthenticated());
  }
}

// Repository Implementation
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  
  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );
  
  @override
  Future<Either<Failure, void>> sendVerificationCode(String phoneNumber) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.sendVerificationCode(phoneNumber);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
  
  @override
  Future<Either<Failure, User>> verifyCode(String phoneNumber, String code) async {
    // Similar implementation with error handling
  }
}
```

---

## API Integration

### Service Template

```dart
// API Service with Dio
@injectable
class ApiService {
  final Dio _dio;
  
  ApiService(this._dio);
  
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      
      if (response.statusCode == 200) {
        final data = fromJson != null 
            ? fromJson(response.data['data'] as Map<String, dynamic>)
            : response.data['data'] as T;
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error('Request failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }
  
  Future<ApiResponse<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = fromJson != null 
            ? fromJson(response.data['data'] as Map<String, dynamic>)
            : response.data['data'] as T;
        return ApiResponse.success(responseData);
      } else {
        return ApiResponse.error('Request failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }
  
  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'] ?? 'Unknown error';
        return 'Server error ($statusCode): $message';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.unknown:
        return 'Network error: ${error.message}';
      default:
        return 'Unknown error occurred';
    }
  }
}

// API Response Wrapper
@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T data) = _Success<T>;
  const factory ApiResponse.error(String message, {int? statusCode}) = _Error<T>;
}
```

### API Client Configuration

```dart
// Dio Configuration with Interceptors
@module
abstract class NetworkModule {
  @lazySingleton
  Dio provideDio(AuthInterceptor authInterceptor) {
    final dio = Dio(BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add interceptors
    dio.interceptors.addAll([
      authInterceptor,
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ),
      RetryInterceptor(
        dio: dio,
        options: const RetryOptions(
          retries: 3,
          retryInterval: Duration(seconds: 1),
        ),
      ),
    ]);
    
    return dio;
  }
}

// Authentication Interceptor
@injectable
class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;
  
  AuthInterceptor(this._secureStorage);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken != null) {
        try {
          final newTokens = await _refreshTokens(refreshToken);
          await _secureStorage.storeAuthTokens(newTokens);
          
          // Retry original request with new token
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';
          
          final response = await Dio().fetch(options);
          handler.resolve(response);
          return;
        } catch (e) {
          // Refresh failed, redirect to login
          await _secureStorage.clearAuthTokens();
          GetIt.instance<AuthCubit>().emit(const AuthState.unauthenticated());
        }
      }
    }
    handler.next(err);
  }
  
  Future<AuthTokens> _refreshTokens(String refreshToken) async {
    // Implementation for token refresh
    throw UnimplementedError();
  }
}
```

---

## Routing

### Route Configuration

```dart
// AutoRoute Configuration
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Authentication Routes
    AutoRoute(
      page: LoginWrapperRoute.page,
      path: '/login',
      initial: true,
      guards: [UnauthGuard],
    ),
    AutoRoute(
      page: PhoneRegistrationRoute.page,
      path: '/register',
      guards: [UnauthGuard],
    ),
    AutoRoute(
      page: SmsVerificationRoute.page,
      path: '/verify',
      guards: [UnauthGuard],
    ),
    
    // Main App Routes (Protected)
    AutoRoute(
      page: MainWrapperRoute.page,
      path: '/',
      guards: [AuthGuard],
      children: [
        AutoRoute(
          page: GroupsListRoute.page,
          path: '/groups',
        ),
        AutoRoute(
          page: GroupDetailsRoute.page,
          path: '/groups/:groupId',
        ),
        AutoRoute(
          page: CreateGroupRoute.page,
          path: '/groups/create',
        ),
        AutoRoute(
          page: AttendanceRequestRoute.page,
          path: '/groups/:groupId/attendance/request',
        ),
        AutoRoute(
          page: AttendanceStatusRoute.page,
          path: '/attendance/:requestId/status',
        ),
        AutoRoute(
          page: PaymentSessionRoute.page,
          path: '/attendance/:requestId/payment',
        ),
        AutoRoute(
          page: QrPaymentRoute.page,
          path: '/payment/:sessionId/qr',
        ),
      ],
    ),
    
    // Fallback Route
    AutoRoute(
      page: NotFoundRoute.page,
      path: '*',
    ),
  ];
}

// Route Guards
@injectable
class AuthGuard extends AutoRouteGuard {
  final AuthCubit _authCubit;
  
  AuthGuard(this._authCubit);
  
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = _authCubit.state;
    if (state is _Authenticated) {
      resolver.next();
    } else {
      router.pushAndClearStack(const LoginWrapperRoute());
    }
  }
}

@injectable
class UnauthGuard extends AutoRouteGuard {
  final AuthCubit _authCubit;
  
  UnauthGuard(this._authCubit);
  
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = _authCubit.state;
    if (state is _Authenticated) {
      router.pushAndClearStack(const MainWrapperRoute());
    } else {
      resolver.next();
    }
  }
}

// Page Definitions
@RoutePage()
class LoginWrapperPage extends StatelessWidget {
  const LoginWrapperPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

@RoutePage()
class MainWrapperPage extends StatelessWidget {
  const MainWrapperPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const AutoRouter(); // Nested routing for main app
  }
}
```

---

## Styling Guidelines

### Styling Approach

**Framework:** Flutter Material 3 with custom Vietnamese cultural adaptations  
**Theme System:** Centralized theme configuration supporting light/dark modes  
**Color Palette:** Vietnamese-inspired colors with sports group coordination focus

### Global Theme Variables

```dart
// Vietnamese Cultural Theme
class VietnameseAppTheme {
  // Vietnamese Color Palette
  static const Color primaryGreen = Color(0xFF2E7D32);      // Vietnamese flag green
  static const Color primaryRed = Color(0xFFD32F2F);        // Vietnamese flag red
  static const Color goldAccent = Color(0xFFFFD700);        // Festive gold
  static const Color riceWhite = Color(0xFFFAFAFA);         // Clean backgrounds
  
  // Sports-specific Colors
  static const Color badmintonYellow = Color(0xFFFFC107);
  static const Color pickleballOrange = Color(0xFFFF5722);
  static const Color footballGreen = Color(0xFF4CAF50);
  
  // Vietnamese Cultural Gradients
  static const LinearGradient vietnameseGradient = LinearGradient(
    colors: [primaryGreen, primaryRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
    ).copyWith(
      primary: primaryGreen,
      secondary: goldAccent,
      error: primaryRed,
      surface: riceWhite,
    ),
    
    // Vietnamese Typography
    textTheme: GoogleFonts.nunitoTextTheme().copyWith(
      headlineLarge: GoogleFonts.nunito(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryGreen,
      ),
      headlineMedium: GoogleFonts.nunito(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5, // Better readability for Vietnamese text
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.4,
      ),
    ),
    
    // Card Theme for Group Cards
    cardTheme: CardTheme(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    // Input Decoration for Vietnamese Forms
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryRed, width: 2),
      ),
      labelStyle: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.grey[600],
      ),
      hintStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: Colors.grey[500],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    
    // Bottom Navigation for Vietnamese Users
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryGreen,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      type: BottomNavigationBarType.fixed,
    ),
  );
  
  static ThemeData darkTheme = lightTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.dark,
    ).copyWith(
      primary: primaryGreen,
      secondary: goldAccent,
      error: primaryRed,
      surface: const Color(0xFF121212),
    ),
  );
  
  // Vietnamese Currency Formatting
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
  
  // Vietnamese Sports Icons
  static const Map<String, IconData> sportIcons = {
    'cau_long': Icons.sports_tennis, // Badminton
    'pickleball': Icons.sports_baseball, // Pickleball
    'bong_da': Icons.sports_soccer, // Football
  };
  
  // Vietnamese Role Colors
  static const Map<String, Color> roleColors = {
    'truong_nhom': primaryRed,      // Group leader
    'pho_nhom': primaryGreen,       // Deputy leader
    'thanh_vien': Colors.blue,      // Member
    'khach': Colors.grey,           // Guest
  };
}
```

---

## Testing Requirements

### Component Test Template

```dart
// Widget Test Template
class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => MockAuthCubit(),
        child: const LoginScreen(),
      ),
    );
  }
}

void main() {
  group('LoginScreen Widget Tests', () {
    late MockAuthCubit mockAuthCubit;
    
    setUp(() {
      mockAuthCubit = MockAuthCubit();
    });
    
    testWidgets('should display login form with Vietnamese phone input', (tester) async {
      // Arrange
      when(() => mockAuthCubit.state).thenReturn(const AuthState.unauthenticated());
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>.value(
            value: mockAuthCubit,
            child: const LoginScreen(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(VietnamesePhoneInput), findsOneWidget);
      expect(find.text('Đăng nhập'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
    
    testWidgets('should show loading indicator when authenticating', (tester) async {
      // Arrange
      when(() => mockAuthCubit.state).thenReturn(const AuthState.authenticating());
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>.value(
            value: mockAuthCubit,
            child: const LoginScreen(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    
    testWidgets('should call loginWithPhone when login button pressed', (tester) async {
      // Arrange
      when(() => mockAuthCubit.state).thenReturn(const AuthState.unauthenticated());
      when(() => mockAuthCubit.loginWithPhone(any())).thenAnswer((_) async {});
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>.value(
            value: mockAuthCubit,
            child: const LoginScreen(),
          ),
        ),
      );
      
      await tester.enterText(find.byType(VietnamesePhoneInput), '+84901234567');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      
      // Assert
      verify(() => mockAuthCubit.loginWithPhone('+84901234567')).called(1);
    });
    
    testWidgets('should show error message for invalid phone number', (tester) async {
      // Arrange
      const errorMessage = 'Số điện thoại không hợp lệ';
      when(() => mockAuthCubit.state).thenReturn(
        const AuthState.error(errorMessage, errorCode: 'INVALID_PHONE'),
      );
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthCubit>.value(
            value: mockAuthCubit,
            child: const LoginScreen(),
          ),
        ),
      );
      
      // Assert
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });
  });
  
  group('AuthCubit Unit Tests', () {
    late AuthCubit authCubit;
    late MockAuthRepository mockAuthRepository;
    late MockSecureStorage mockSecureStorage;
    
    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockSecureStorage = MockSecureStorage();
      authCubit = AuthCubit(mockAuthRepository, mockSecureStorage);
    });
    
    test('initial state should be unauthenticated', () {
      expect(authCubit.state, const AuthState.unauthenticated());
    });
    
    test('should emit [authenticating, phoneVerificationRequired] when login succeeds', () async {
      // Arrange
      const phoneNumber = '+84901234567';
      when(() => mockAuthRepository.sendVerificationCode(phoneNumber))
          .thenAnswer((_) async => const Right(null));
      
      // Assert Later
      expectLater(
        authCubit.stream,
        emitsInOrder([
          const AuthState.authenticating(),
          const AuthState.phoneVerificationRequired(phoneNumber),
        ]),
      );
      
      // Act
      await authCubit.loginWithPhone(phoneNumber);
    });
    
    test('should emit [authenticating, error] when login fails', () async {
      // Arrange
      const phoneNumber = '+84901234567';
      const failure = ServerFailure('Network error');
      when(() => mockAuthRepository.sendVerificationCode(phoneNumber))
          .thenAnswer((_) async => const Left(failure));
      
      // Assert Later
      expectLater(
        authCubit.stream,
        emitsInOrder([
          const AuthState.authenticating(),
          const AuthState.error('Network error'),
        ]),
      );
      
      // Act
      await authCubit.loginWithPhone(phoneNumber);
    });
    
    test('should verify SMS code and authenticate user', () async {
      // Arrange
      const phoneNumber = '+84901234567';
      const verificationCode = '123456';
      final user = User(id: '1', phoneNumber: phoneNumber, name: 'Test User');
      
      // Set initial state
      authCubit.emit(const AuthState.phoneVerificationRequired(phoneNumber));
      
      when(() => mockAuthRepository.verifyCode(phoneNumber, verificationCode))
          .thenAnswer((_) async => Right(user));
      when(() => mockSecureStorage.storeAuthTokens(any()))
          .thenAnswer((_) async {});
      
      // Assert Later
      expectLater(
        authCubit.stream,
        emitsInOrder([
          const AuthState.authenticating(),
          AuthState.authenticated(user),
        ]),
      );
      
      // Act
      await authCubit.verifyCode(phoneNumber, verificationCode);
      
      // Assert
      verify(() => mockSecureStorage.storeAuthTokens(user.tokens)).called(1);
    });
  });
}

// Mock Classes
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
class MockAuthRepository extends Mock implements AuthRepository {}
class MockSecureStorage extends Mock implements SecureStorage {}
```

### Testing Best Practices

1. **Unit Tests**: Test individual Cubits and business logic with Vietnamese data validation
2. **Widget Tests**: Test UI components with Vietnamese localization and cultural patterns  
3. **Integration Tests**: Test complete user flows from phone registration through payment
4. **Golden Tests**: Visual regression tests for Vietnamese UI components and themes
5. **Performance Tests**: Memory usage and frame rate tests for attendance real-time updates
6. **Payment Gateway Tests**: Comprehensive testing of Momo, VietQR, ZaloPay integrations using sandbox environments

---

## Environment Configuration

```dart
// Environment Configuration
abstract class AppConfig {
  static const String _apiBaseUrlDev = 'http://localhost:8000/api/v1';
  static const String _apiBaseUrlStaging = 'https://staging-api.gosport.vn/api/v1';
  static const String _apiBaseUrlProd = 'https://api.gosport.vn/api/v1';
  
  // Firebase Configuration
  static const String _firebaseProjectIdDev = 'go-sport-dev';
  static const String _firebaseProjectIdStaging = 'go-sport-staging';
  static const String _firebaseProjectIdProd = 'go-sport-prod';
  
  // Vietnamese Payment Gateway URLs
  static const String _momoSandboxUrl = 'https://test-payment.momo.vn/v2/gateway/api';
  static const String _momoProdUrl = 'https://payment.momo.vn/v2/gateway/api';
  
  static const String _vietQRSandboxUrl = 'https://sandbox.vietqr.io/v2';
  static const String _vietQRProdUrl = 'https://api.vietqr.io/v2';
  
  // Environment Detection
  static AppEnvironment get environment {
    const env = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
    switch (env) {
      case 'staging':
        return AppEnvironment.staging;
      case 'production':
        return AppEnvironment.production;
      default:
        return AppEnvironment.development;
    }
  }
  
  // Configuration Getters
  static String get apiBaseUrl {
    switch (environment) {
      case AppEnvironment.development:
        return _apiBaseUrlDev;
      case AppEnvironment.staging:
        return _apiBaseUrlStaging;
      case AppEnvironment.production:
        return _apiBaseUrlProd;
    }
  }
  
  static String get firebaseProjectId {
    switch (environment) {
      case AppEnvironment.development:
        return _firebaseProjectIdDev;
      case AppEnvironment.staging:
        return _firebaseProjectIdStaging;
      case AppEnvironment.production:
        return _firebaseProjectIdProd;
    }
  }
  
  static String get momoApiUrl {
    return environment == AppEnvironment.production 
        ? _momoProdUrl 
        : _momoSandboxUrl;
  }
  
  static String get vietQRApiUrl {
    return environment == AppEnvironment.production 
        ? _vietQRProdUrl 
        : _vietQRSandboxUrl;
  }
  
  // Feature Flags
  static bool get enableDebugLogging => environment != AppEnvironment.production;
  static bool get enablePaymentSandbox => environment != AppEnvironment.production;
  static bool get enableCrashReporting => true;
  
  // Vietnamese Localization Settings
  static const String defaultLocale = 'vi_VN';
  static const String fallbackLocale = 'en_US';
  static const String vietnameseTimezone = 'Asia/Ho_Chi_Minh';
}

enum AppEnvironment { development, staging, production }
```

---

## Frontend Developer Standards

### Critical Coding Rules

1. **Vietnamese Data Handling**
   - All user input forms MUST validate Vietnamese phone number format (+84/84/0 prefixes)
   - Vietnamese diacritics MUST be properly encoded and displayed using UTF-8
   - Currency amounts MUST be formatted using Vietnamese Dong (₫) with proper thousand separators
   - Date/time displays MUST account for Vietnam timezone (UTC+7) in user-facing components

2. **State Management Rules**
   - NEVER mutate state directly; always emit new states using Cubit
   - Use Freezed for all state classes to ensure immutability
   - Handle loading, success, and error states for all async operations
   - Implement proper error handling with Vietnamese error messages

3. **Navigation Rules**  
   - Use AutoRoute for all navigation with type-safe route definitions
   - Implement route guards for authentication and role-based access
   - NEVER use Navigator.push directly; use context.router methods
   - Handle deep links for attendance requests and payment flows

4. **API Integration Rules**
   - ALWAYS wrap API calls in try-catch with proper error mapping
   - Use ApiResponse wrapper for consistent error handling
   - Implement retry logic for Vietnamese network conditions
   - NEVER expose API keys or sensitive data in code

5. **Performance Rules**
   - Use BlocBuilder instead of BlocConsumer when only UI updates are needed
   - Implement proper disposal of Cubits and subscriptions
   - Cache attendance data locally using Hive for offline access
   - Optimize Vietnamese text rendering for long group names and descriptions

6. **Testing Rules**
   - Write widget tests for all custom Vietnamese UI components
   - Mock all external dependencies including payment gateways
   - Test with realistic Vietnamese test data (names, phone numbers, locations)
   - Include accessibility tests for Vietnamese screen readers

### Quick Reference

#### Common Commands
```bash
# Development
flutter run --dart-define=APP_ENV=dev
flutter test
flutter analyze

# Build Commands  
flutter build apk --dart-define=APP_ENV=production
flutter build ios --dart-define=APP_ENV=production

# Code Generation
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### Key Import Patterns
```dart
// State Management
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Dependency Injection
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Routing
import 'package:auto_route/auto_route.dart';

// Vietnamese Utilities
import '../../core/utils/vietnamese_phone_validator.dart';
import '../../core/constants/vietnamese_constants.dart';
```

#### File Naming Conventions
```plaintext
// Screen Files
login_screen.dart
phone_registration_screen.dart
group_details_screen.dart

// Cubit Files  
auth_cubit.dart
groups_cubit.dart
attendance_cubit.dart

// Model Files
user_model.dart
group_model.dart
attendance_model.dart

// Widget Files
vietnamese_phone_input.dart
sport_selection_widget.dart
payment_method_selector.dart
```

#### Vietnamese UI Patterns
```dart
// Vietnamese Currency Display
Text(VietnameseAppTheme.formatCurrency(amount))

// Vietnamese Phone Number Input
VietnamesePhoneInput(
  onChanged: (phone) => context.read<AuthCubit>().updatePhone(phone),
  validator: VietnamesePhoneValidator.validate,
)

// Vietnamese Date/Time Display  
Text(DateFormat('dd/MM/yyyy HH:mm', 'vi_VN').format(dateTime))

// Role-based UI Display
RoleBadge(
  role: membership.role,
  color: VietnameseAppTheme.roleColors[membership.role],
)
```

---

## Migration Roadmap from Current Architecture

### Phase 1: Foundation Setup (Week 1-2)
1. **Add new dependencies** to pubspec.yaml:
   - flutter_bloc: ^8.1.3
   - get_it: ^8.0.0  
   - injectable: ^2.3.2
   - auto_route: ^8.0.3
   
2. **Setup GetIt DI container** replacing Riverpod providers
3. **Initialize AutoRoute configuration** alongside existing GoRouter
4. **Create base Cubit classes** and Freezed state definitions

### Phase 2: Authentication Migration (Week 3-4)
1. **Migrate AuthProvider to AuthCubit** while keeping existing functionality
2. **Update login/registration screens** to use BlocBuilder instead of Consumer
3. **Replace GoRouter auth guards** with AutoRoute guards
4. **Test authentication flows** with new architecture

### Phase 3: Groups Feature Migration (Week 5-6)
1. **Convert Groups providers to Cubits** (GroupsCubit, CreateGroupCubit)
2. **Update group screens** to use new state management
3. **Migrate group-related routing** to AutoRoute
4. **Test group creation and management flows**

### Phase 4: Attendance & Payments (Week 7-8)
1. **Convert attendance logic to Cubit architecture**
2. **Migrate payment flows** to new state management
3. **Update Vietnamese payment integrations** to work with new architecture
4. **Comprehensive testing of critical payment flows**

### Phase 5: Cleanup & Optimization (Week 9-10)
1. **Remove Riverpod dependencies** and unused GoRouter code
2. **Optimize performance** with new architecture
3. **Update tests** to use new mocking patterns
4. **Documentation updates** and team training

This comprehensive Flutter frontend architecture document provides the complete blueprint for migrating your Vietnamese sports coordination app from Riverpod+GoRouter to Cubit+AutoRoute+GetIt+MVVM+Freezed architecture, with full Vietnamese cultural integration and payment gateway support.

<function_calls>
<invoke name="TodoWrite">
<parameter name="todos">[{"content": "Create frontend architecture document with new tech stack", "status": "completed", "activeForm": "Creating frontend architecture document with new tech stack"}, {"content": "Document migration strategy from Riverpod+GoRouter to Cubit+AutoRoute+GetIt", "status": "completed", "activeForm": "Documenting migration strategy from Riverpod+GoRouter to Cubit+AutoRoute+GetIt"}, {"content": "Define new project structure for MVVM with Cubit architecture", "status": "completed", "activeForm": "Defining new project structure for MVVM with Cubit architecture"}, {"content": "Create component standards and templates for new architecture", "status": "completed", "activeForm": "Creating component standards and templates for new architecture"}]