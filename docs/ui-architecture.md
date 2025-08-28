# Go Sport App Frontend Architecture Document

## Template and Framework Selection

**Framework Decision:** Flutter 3.35.2 - Cross-platform mobile development

Based on analysis of the PRD, main architecture document, and UI/UX specifications, Go Sport App uses **Flutter** as the mobile framework without any starter template. This is a greenfield Flutter project optimized for Vietnamese sports group coordination.

**Key Framework Constraints:**
- Mobile-only application (iOS and Android)
- Vietnamese cultural UI patterns and diacritics support
- Real-time attendance coordination capabilities
- Offline-first attendance response functionality
- Integration with Vietnamese payment gateways (Momo, VietQR, ZaloPay)

### Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-08-28 | v1.0 | Initial Flutter frontend architecture creation | Winston (Architect) |

## Frontend Tech Stack

### Technology Stack Table

| Category | Technology | Version | Purpose | Rationale |
|----------|------------|---------|---------|-----------|
| **Framework** | Flutter | 3.35.2 | Cross-platform mobile development | Strong Vietnamese developer community, single codebase for iOS/Android, excellent UI performance |
| **State Management** | Riverpod | 2.4.9 | Reactive state management | Better performance than Provider, excellent testing support, handles complex role-based UI |
| **Routing** | GoRouter | 13.2.0 | Declarative routing | Type-safe navigation, deep linking support, role-based route guards |
| **HTTP Client** | Dio | 5.4.0 | API integration | Interceptor support for auth tokens, excellent error handling, Vietnamese network optimization |
| **Local Storage** | Hive | 4.0.0 | Offline data caching | Fast NoSQL database, supports complex objects, offline attendance responses |
| **Push Notifications** | Firebase Messaging | 14.7.5 | Real-time notifications | Vietnamese network reliability, attendance notification delivery |
| **QR Code** | QR Flutter | 4.1.0 | Payment QR generation | Vietnamese payment gateway QR compatibility |
| **UI Components** | Flutter Material 3 | Built-in | Material Design components | Vietnamese mobile app familiarity, accessibility support |
| **Animation** | Flutter Animations | Built-in | Micro-interactions | Status transitions, attendance updates, role-based UI changes |
| **Testing** | Flutter Test | Built-in | Unit and widget testing | Comprehensive testing for attendance logic and payment flows |
| **Code Generation** | Build Runner | 2.4.7 | Code generation support | Riverpod code generation, JSON serialization |

## Project Structure

```
mobile-app/
├── lib/
│   ├── main.dart                           # App entry point with Vietnamese localization
│   ├── app/
│   │   ├── app.dart                        # App-level configuration and routing
│   │   ├── theme/
│   │   │   ├── app_theme.dart              # Vietnamese cultural color scheme
│   │   │   ├── text_theme.dart             # Vietnamese diacritics typography
│   │   │   └── colors.dart                 # Fitness app inspired colors
│   │   └── routes/
│   │       ├── app_router.dart             # GoRouter configuration
│   │       ├── route_paths.dart            # Named route constants
│   │       └── auth_guard.dart             # Role-based route protection
│   ├── core/
│   │   ├── constants/
│   │   │   ├── api_constants.dart          # Backend API endpoints
│   │   │   ├── vietnamese_constants.dart   # Vietnamese sports, roles, formats
│   │   │   └── app_constants.dart          # General app constants
│   │   ├── network/
│   │   │   ├── dio_client.dart             # HTTP client configuration
│   │   │   ├── api_interceptor.dart        # Auth token and error handling
│   │   │   └── network_checker.dart        # Vietnamese network connectivity
│   │   ├── storage/
│   │   │   ├── local_storage.dart          # Hive database wrapper
│   │   │   ├── secure_storage.dart         # Sensitive data (tokens, phone)
│   │   │   └── cache_manager.dart          # Offline data synchronization
│   │   ├── utils/
│   │   │   ├── vietnamese_formatter.dart   # Phone number, date formatting
│   │   │   ├── validation.dart             # Form validation rules
│   │   │   ├── extensions.dart             # Dart extensions
│   │   │   └── logger.dart                 # Debug and error logging
│   │   └── widgets/
│   │       ├── loading_widget.dart         # Consistent loading states
│   │       ├── error_widget.dart           # Vietnamese error messages
│   │       ├── empty_state.dart            # Empty state illustrations
│   │       └── vietnamese_input.dart       # Vietnamese keyboard support
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── auth_api.dart       # Authentication API calls
│   │   │   │   │   └── auth_cache.dart     # Local auth data caching
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── models/
│   │   │   │       ├── user_model.dart     # User data model
│   │   │   │       └── auth_response.dart  # API response models
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── user_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── login_usecase.dart
│   │   │   │       ├── register_usecase.dart
│   │   │   │       └── verify_phone_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── auth_provider.dart  # Riverpod auth state
│   │   │       │   └── phone_provider.dart # Vietnamese phone handling
│   │   │       ├── pages/
│   │   │       │   ├── login_page.dart
│   │   │       │   ├── register_page.dart
│   │   │       │   └── verify_phone_page.dart
│   │   │       └── widgets/
│   │   │           ├── phone_input.dart    # Vietnamese phone format
│   │   │           ├── sms_code_input.dart
│   │   │           └── auth_button.dart
│   │   ├── groups/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── groups_api.dart
│   │   │   │   │   └── groups_cache.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── groups_repository.dart
│   │   │   │   └── models/
│   │   │   │       ├── group_model.dart
│   │   │   │       ├── membership_model.dart
│   │   │   │       └── invitation_model.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── group_entity.dart
│   │   │   │   │   └── membership_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── groups_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── create_group_usecase.dart
│   │   │   │       ├── join_group_usecase.dart
│   │   │   │       └── manage_members_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── groups_provider.dart
│   │   │       │   ├── current_group_provider.dart
│   │   │       │   └── members_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── groups_list_page.dart
│   │   │       │   ├── group_detail_page.dart
│   │   │       │   ├── create_group_page.dart
│   │   │       │   └── members_page.dart
│   │   │       └── widgets/
│   │   │           ├── group_card.dart     # Vietnamese sports icons
│   │   │           ├── member_list_tile.dart
│   │   │           ├── role_badge.dart     # Vietnamese role display
│   │   │           └── invitation_widget.dart
│   │   ├── attendance/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── attendance_api.dart
│   │   │   │   │   └── attendance_cache.dart # Offline response storage
│   │   │   │   ├── repositories/
│   │   │   │   │   └── attendance_repository.dart
│   │   │   │   └── models/
│   │   │   │       ├── attendance_request_model.dart
│   │   │   │       ├── attendance_response_model.dart
│   │   │   │       └── attendance_status_model.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── attendance_request_entity.dart
│   │   │   │   │   └── attendance_response_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── attendance_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── create_attendance_request_usecase.dart
│   │   │   │       ├── respond_attendance_usecase.dart
│   │   │   │       └── get_attendance_status_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── attendance_provider.dart
│   │   │       │   ├── real_time_status_provider.dart
│   │   │       │   └── offline_responses_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── attendance_list_page.dart
│   │   │       │   ├── attendance_detail_page.dart
│   │   │       │   └── create_attendance_page.dart
│   │   │       └── widgets/
│   │   │           ├── attendance_card.dart
│   │   │           ├── response_buttons.dart # ✅ Có thể đến, ❌ Không thể đến
│   │   │           ├── headcount_display.dart
│   │   │           └── status_indicator.dart # Vietnamese status colors
│   │   ├── payments/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── payments_api.dart
│   │   │   │   │   └── payments_cache.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── payments_repository.dart
│   │   │   │   └── models/
│   │   │   │       ├── payment_session_model.dart
│   │   │   │       ├── payment_transaction_model.dart
│   │   │   │       └── qr_code_model.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── payment_session_entity.dart
│   │   │   │   │   └── payment_transaction_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── payments_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── create_payment_session_usecase.dart
│   │   │   │       ├── generate_qr_codes_usecase.dart
│   │   │   │       └── track_payments_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── payment_session_provider.dart
│   │   │       │   ├── qr_codes_provider.dart
│   │   │       │   └── payment_status_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── payment_session_page.dart
│   │   │       │   ├── qr_display_page.dart
│   │   │       │   └── payment_history_page.dart
│   │   │       └── widgets/
│   │   │           ├── cost_breakdown_card.dart
│   │   │           ├── qr_code_widget.dart # Vietnamese payment QR
│   │   │           ├── payment_method_selector.dart # Momo/VietQR/ZaloPay
│   │   │           └── payment_status_list.dart
│   │   └── notifications/
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   │   ├── fcm_datasource.dart
│   │       │   │   └── local_notifications.dart
│   │       │   ├── repositories/
│   │       │   │   └── notifications_repository.dart
│   │       │   └── models/
│   │       │       └── notification_model.dart
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   │   └── notification_entity.dart
│   │       │   ├── repositories/
│   │       │   │   └── notifications_repository.dart
│   │       │   └── usecases/
│   │       │       ├── handle_attendance_notification_usecase.dart
│   │       │       └── handle_payment_notification_usecase.dart
│   │       └── presentation/
│   │           ├── providers/
│   │           │   └── notifications_provider.dart
│   │           ├── pages/
│   │           │   └── notifications_page.dart
│   │           └── widgets/
│   │               ├── notification_tile.dart
│   │               └── notification_action_buttons.dart
│   ├── shared/
│   │   ├── widgets/
│   │   │   ├── app_bar/
│   │   │   │   ├── custom_app_bar.dart
│   │   │   │   └── role_indicator.dart      # Vietnamese role badges
│   │   │   ├── buttons/
│   │   │   │   ├── primary_button.dart      # Fitness app style gradients
│   │   │   │   ├── secondary_button.dart
│   │   │   │   └── icon_button.dart
│   │   │   ├── cards/
│   │   │   │   ├── white_card.dart         # Fitness app white cards
│   │   │   │   ├── gradient_card.dart      # Blue/Orange gradients
│   │   │   │   └── status_card.dart
│   │   │   ├── inputs/
│   │   │   │   ├── vietnamese_text_field.dart
│   │   │   │   ├── phone_input_field.dart
│   │   │   │   └── dropdown_field.dart
│   │   │   ├── dialogs/
│   │   │   │   ├── confirmation_dialog.dart
│   │   │   │   ├── vietnamese_alert_dialog.dart
│   │   │   │   └── loading_dialog.dart
│   │   │   └── layouts/
│   │   │       ├── safe_area_wrapper.dart
│   │   │       ├── scroll_wrapper.dart
│   │   │       └── bottom_nav_wrapper.dart
│   │   ├── mixins/
│   │   │   ├── validation_mixin.dart
│   │   │   ├── loading_mixin.dart
│   │   │   └── vietnamese_formatting_mixin.dart
│   │   └── extensions/
│   │       ├── context_extensions.dart
│   │       ├── datetime_extensions.dart    # Vietnamese timezone
│   │       ├── string_extensions.dart      # Vietnamese text processing
│   │       └── widget_extensions.dart
│   └── l10n/
│       ├── app_localizations.dart          # Generated localization
│       ├── arb/
│       │   ├── app_vi.arb                 # Vietnamese strings
│       │   └── app_en.arb                 # English fallback
│       └── vietnamese_sports_terms.dart   # Sports-specific terminology
├── assets/
│   ├── images/
│   │   ├── sports_icons/                   # Cầu lông, pickleball, bóng đá icons
│   │   ├── payment_methods/               # Momo, VietQR, ZaloPay logos
│   │   └── illustrations/                 # Empty states, onboarding
│   ├── fonts/                             # Vietnamese diacritics support
│   └── animations/                        # Lottie files for loading states
├── test/
│   ├── unit/
│   │   ├── features/
│   │   ├── core/
│   │   └── shared/
│   ├── widget/
│   │   ├── features/
│   │   └── shared/
│   ├── integration/
│   │   ├── attendance_flow_test.dart      # Complete attendance workflow
│   │   ├── payment_flow_test.dart         # Vietnamese payment integration
│   │   └── offline_sync_test.dart         # Offline functionality
│   └── mocks/
│       ├── mock_api_client.dart
│       ├── mock_local_storage.dart
│       └── vietnamese_test_data.dart      # Vietnamese test datasets
├── android/                               # Android-specific configuration
├── ios/                                   # iOS-specific configuration
├── pubspec.yaml                           # Flutter dependencies
└── analysis_options.yaml                  # Dart linter configuration
```

## Component Standards

### Component Template

```typescript
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/example_provider.dart';

class ExampleWidget extends ConsumerWidget {
  const ExampleWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.onPressed,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exampleProvider);
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Usage example with Vietnamese content
class AttendanceCard extends ExampleWidget {
  const AttendanceCard({
    super.key,
    required String gameName,
    required String gameTime,
    VoidCallback? onRespond,
  }) : super(
    title: gameName,
    subtitle: gameTime,
    onPressed: onRespond,
  );
}
```

### Naming Conventions

**Files and Directories:**
- **Pages:** `snake_case` ending with `_page.dart` (e.g., `group_detail_page.dart`)
- **Widgets:** `snake_case` ending with `_widget.dart` (e.g., `attendance_card_widget.dart`)
- **Providers:** `snake_case` ending with `_provider.dart` (e.g., `groups_provider.dart`)
- **Models:** `snake_case` ending with `_model.dart` (e.g., `user_model.dart`)
- **Services:** `snake_case` ending with `_service.dart` (e.g., `vietnamese_sms_service.dart`)

**Classes and Variables:**
- **Classes:** `PascalCase` with descriptive Vietnamese context (e.g., `VietnamesePhoneValidator`)
- **Variables:** `camelCase` (e.g., `phoneNumber`, `attendanceStatus`)
- **Constants:** `camelCase` for local, `SCREAMING_SNAKE_CASE` for global (e.g., `kVietnamesePhonePattern`)
- **Enums:** `PascalCase` with Vietnamese enum values (e.g., `SportType.cauLong`)

**Vietnamese-specific Naming:**
- **Sports:** Use Vietnamese terms in enums (`SportType.cauLong`, `SportType.bongDa`)
- **Roles:** Vietnamese hierarchy terms (`Role.truongNhom`, `Role.phoNhom`)
- **UI Text:** Use localization keys (`l10n.attendanceConfirmButton`)

## State Management

### Store Structure

```
lib/features/{feature}/presentation/providers/
├── {feature}_provider.dart          # Main feature state provider
├── {feature}_notifier.dart          # State management logic
├── {feature}_state.dart             # State models and classes
└── {feature}_repository_provider.dart # Repository dependency injection

# Example for attendance feature:
lib/features/attendance/presentation/providers/
├── attendance_provider.dart         # Main attendance state
├── attendance_notifier.dart         # Business logic
├── attendance_state.dart            # AttendanceState classes
├── real_time_status_provider.dart   # Live attendance updates
├── offline_responses_provider.dart  # Offline attendance caching
└── attendance_repository_provider.dart
```

### State Management Template

```typescript
// attendance_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_request_entity.dart';
import '../../domain/entities/attendance_response_entity.dart';

part 'attendance_state.freezed.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState({
    @Default([]) List<AttendanceRequestEntity> attendanceRequests,
    @Default({}) Map<String, List<AttendanceResponseEntity>> responses,
    @Default(false) bool isLoading,
    @Default([]) List<AttendanceResponseEntity> offlineResponses,
    String? error,
  }) = _AttendanceState;
}

// attendance_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'attendance_state.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../../domain/entities/attendance_response_entity.dart';

class AttendanceNotifier extends StateNotifier<AttendanceState> {
  AttendanceNotifier(this._repository) : super(const AttendanceState());

  final AttendanceRepository _repository;

  Future<void> loadAttendanceRequests(String groupId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final requests = await _repository.getAttendanceRequests(groupId);
      state = state.copyWith(
        attendanceRequests: requests,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Không thể tải danh sách điểm danh: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  Future<void> respondToAttendance({
    required String requestId,
    required AttendanceResponse response,
    bool isOffline = false,
  }) async {
    try {
      if (isOffline) {
        // Store offline response for later sync
        final offlineResponse = AttendanceResponseEntity(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          attendanceRequestId: requestId,
          response: response,
          isOffline: true,
          createdAt: DateTime.now(),
        );
        
        state = state.copyWith(
          offlineResponses: [...state.offlineResponses, offlineResponse],
        );
      } else {
        await _repository.respondToAttendance(requestId, response);
        await loadAttendanceRequests(requestId); // Refresh data
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Không thể gửi phản hồi điểm danh: ${e.toString()}',
      );
    }
  }

  Future<void> syncOfflineResponses() async {
    if (state.offlineResponses.isEmpty) return;

    try {
      for (final response in state.offlineResponses) {
        await _repository.respondToAttendance(
          response.attendanceRequestId,
          response.response,
        );
      }
      
      // Clear offline responses after successful sync
      state = state.copyWith(offlineResponses: []);
    } catch (e) {
      // Keep offline responses for retry
      state = state.copyWith(
        error: 'Không thể đồng bộ phản hồi offline: ${e.toString()}',
      );
    }
  }
}

// attendance_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'attendance_notifier.dart';
import 'attendance_state.dart';
import 'attendance_repository_provider.dart';

final attendanceProvider = StateNotifierProvider<AttendanceNotifier, AttendanceState>(
  (ref) => AttendanceNotifier(
    ref.watch(attendanceRepositoryProvider),
  ),
);

// Real-time status provider for live updates
final attendanceStatusProvider = StreamProvider.family<AttendanceStatus, String>(
  (ref, requestId) {
    final repository = ref.watch(attendanceRepositoryProvider);
    return repository.watchAttendanceStatus(requestId);
  },
);

// Offline responses count for UI indicator
final offlineResponsesCountProvider = Provider<int>((ref) {
  final state = ref.watch(attendanceProvider);
  return state.offlineResponses.length;
});
```

## API Integration

### Service Template

```typescript
// attendance_api.dart
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../models/attendance_request_model.dart';
import '../models/attendance_response_model.dart';
import '../models/attendance_status_model.dart';

abstract class AttendanceApi {
  Future<List<AttendanceRequestModel>> getAttendanceRequests(String groupId);
  Future<AttendanceStatusModel> getAttendanceStatus(String requestId);
  Future<void> respondToAttendance(String requestId, AttendanceResponse response);
  Future<AttendanceRequestModel> createAttendanceRequest(CreateAttendanceRequest request);
}

class AttendanceApiImpl implements AttendanceApi {
  final DioClient _dioClient;
  
  AttendanceApiImpl(this._dioClient);

  @override
  Future<List<AttendanceRequestModel>> getAttendanceRequests(String groupId) async {
    try {
      final response = await _dioClient.get(
        '/groups/$groupId/attendance',
        queryParameters: {
          'status': 'active',
          'sort': 'game_datetime',
        },
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => AttendanceRequestModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleApiError(e);
    }
  }

  @override
  Future<void> respondToAttendance(String requestId, AttendanceResponse response) async {
    try {
      await _dioClient.post(
        '/attendance/$requestId/respond',
        data: {
          'response': response.name, // attending, not_attending, maybe
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } on DioException catch (e) {
      throw _handleApiError(e);
    }
  }

  @override
  Future<AttendanceStatusModel> getAttendanceStatus(String requestId) async {
    try {
      final response = await _dioClient.get('/attendance/$requestId/status');
      return AttendanceStatusModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleApiError(e);
    }
  }

  Exception _handleApiError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Kết nối mạng chậm. Vui lòng thử lại.');
      case DioExceptionType.connectionError:
        return Exception('Không thể kết nối đến máy chủ.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 401:
            return Exception('Phiên đăng nhập đã hết hạn.');
          case 403:
            return Exception('Bạn không có quyền thực hiện thao tác này.');
          case 404:
            return Exception('Không tìm thấy thông tin yêu cầu.');
          case 500:
            return Exception('Lỗi máy chủ. Vui lòng thử lại sau.');
          default:
            return Exception('Có lỗi xảy ra. Vui lòng thử lại.');
        }
      default:
        return Exception('Có lỗi không xác định xảy ra.');
    }
  }
}
```

### API Client Configuration

```typescript
// dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import 'api_interceptor.dart';

class DioClient {
  late final Dio _dio;
  
  DioClient() {
    _dio = Dio();
    _setupInterceptors();
    _setupBaseOptions();
  }

  void _setupBaseOptions() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'vi-VN,vi;q=0.9,en;q=0.8', // Vietnamese preference
      },
    );
  }

  void _setupInterceptors() {
    _dio.interceptors.add(ApiInterceptor());
    
    // Add logging in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ));
    }
  }

  // HTTP Methods
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(
    String path, {
    dynamic data,
  }) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
}

// api_interceptor.dart
import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';

class ApiInterceptor extends Interceptor {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add auth token to requests
    final token = await _secureStorage.getAuthToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Add correlation ID for request tracking
    options.headers['X-Correlation-ID'] = _generateCorrelationId();
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token expiration
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshAuthToken();
      if (refreshed) {
        // Retry the request with new token
        final options = err.requestOptions;
        final token = await _secureStorage.getAuthToken();
        options.headers['Authorization'] = 'Bearer $token';
        
        try {
          final response = await Dio().fetch(options);
          handler.resolve(response);
          return;
        } catch (e) {
          // If retry fails, continue with error
        }
      }
      
      // Clear invalid token and redirect to login
      await _secureStorage.clearAuthToken();
      // TODO: Navigate to login screen
    }

    super.onError(err, handler);
  }

  String _generateCorrelationId() {
    return '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(9999)}';
  }

  Future<bool> _refreshAuthToken() async {
    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken == null) return false;

      final dio = Dio();
      final response = await dio.post(
        '${ApiConstants.baseUrl}/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      final newToken = response.data['access_token'];
      await _secureStorage.setAuthToken(newToken);
      return true;
    } catch (e) {
      return false;
    }
  }
}

// Provider for DioClient
final dioClientProvider = Provider<DioClient>((ref) => DioClient());
```

## Routing

### Route Configuration

```typescript
// app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/auth/presentation/pages/verify_phone_page.dart';
import '../features/groups/presentation/pages/groups_list_page.dart';
import '../features/groups/presentation/pages/group_detail_page.dart';
import '../features/attendance/presentation/pages/attendance_detail_page.dart';
import '../features/payments/presentation/pages/qr_display_page.dart';
import 'auth_guard.dart';
import 'route_paths.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authGuard = ref.watch(authGuardProvider);
  
  return GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: (context, state) => authGuard.redirect(context, state),
    routes: [
      // Splash and Auth Routes
      GoRoute(
        path: RoutePaths.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
        routes: [
          GoRoute(
            path: 'verify',
            name: 'verify-phone',
            builder: (context, state) {
              final phoneNumber = state.extra as String?;
              return VerifyPhonePage(phoneNumber: phoneNumber);
            },
          ),
        ],
      ),

      // Main App Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Groups Tab
          GoRoute(
            path: RoutePaths.groups,
            name: 'groups',
            builder: (context, state) => const GroupsListPage(),
            routes: [
              GoRoute(
                path: ':groupId',
                name: 'group-detail',
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId']!;
                  return GroupDetailPage(groupId: groupId);
                },
                routes: [
                  GoRoute(
                    path: 'members',
                    name: 'group-members',
                    builder: (context, state) {
                      final groupId = state.pathParameters['groupId']!;
                      return GroupMembersPage(groupId: groupId);
                    },
                  ),
                  GoRoute(
                    path: 'attendance/:requestId',
                    name: 'attendance-detail',
                    builder: (context, state) {
                      final groupId = state.pathParameters['groupId']!;
                      final requestId = state.pathParameters['requestId']!;
                      return AttendanceDetailPage(
                        groupId: groupId,
                        requestId: requestId,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'payment',
                        name: 'payment-qr',
                        builder: (context, state) {
                          final requestId = state.pathParameters['requestId']!;
                          return QRDisplayPage(requestId: requestId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Attendance Tab
          GoRoute(
            path: RoutePaths.attendance,
            name: 'attendance',
            builder: (context, state) => const AttendanceListPage(),
          ),

          // Payments Tab
          GoRoute(
            path: RoutePaths.payments,
            name: 'payments',
            builder: (context, state) => const PaymentHistoryPage(),
          ),

          // Profile Tab
          GoRoute(
            path: RoutePaths.profile,
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),

      // Deep Link Routes (from notifications)
      GoRoute(
        path: '/attendance-notification/:requestId',
        name: 'attendance-notification',
        builder: (context, state) {
          final requestId = state.pathParameters['requestId']!;
          return AttendanceNotificationPage(requestId: requestId);
        },
      ),

      GoRoute(
        path: '/payment-notification/:sessionId',
        name: 'payment-notification',
        builder: (context, state) {
          final sessionId = state.pathParameters['sessionId']!;
          return PaymentNotificationPage(sessionId: sessionId);
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
});

// auth_guard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import 'route_paths.dart';

class AuthGuard {
  const AuthGuard(this._ref);
  
  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authProvider);
    final isLoggedIn = authState.isAuthenticated;
    final isLoggingIn = state.matchedLocation == RoutePaths.login ||
                        state.matchedLocation == RoutePaths.register ||
                        state.matchedLocation.startsWith('${RoutePaths.register}/verify');

    // Redirect to login if not authenticated and not on auth pages
    if (!isLoggedIn && !isLoggingIn) {
      return RoutePaths.login;
    }

    // Redirect to home if logged in and on auth pages
    if (isLoggedIn && isLoggingIn) {
      return RoutePaths.groups;
    }

    // Check role-based access for specific routes
    if (isLoggedIn) {
      final userRole = authState.user?.role;
      return _checkRoleAccess(state.matchedLocation, userRole);
    }

    return null; // No redirect needed
  }

  String? _checkRoleAccess(String location, UserRole? role) {
    // Guest users have limited access
    if (role == UserRole.khach) {
      final guestAllowedPaths = [
        RoutePaths.groups,
        RoutePaths.attendance,
        RoutePaths.profile,
      ];
      
      final isAllowed = guestAllowedPaths.any((path) => location.startsWith(path));
      if (!isAllowed && !location.contains('/attendance/')) {
        return RoutePaths.groups; // Redirect guests to safe area
      }
    }

    return null; // Access granted
  }
}

final authGuardProvider = Provider<AuthGuard>((ref) => AuthGuard(ref));

// route_paths.dart
class RoutePaths {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const groups = '/groups';
  static const attendance = '/attendance';
  static const payments = '/payments';
  static const profile = '/profile';
}
```

## Styling Guidelines

### Styling Approach

Go Sport App uses **Material Design 3** with custom Vietnamese cultural adaptations and fitness app-inspired design system. The approach combines Flutter's built-in theming system with custom components that reflect Vietnamese sports community preferences.

**Key Styling Decisions:**
- **Material 3 Foundation:** Leverages Flutter's modern design system for accessibility and consistency
- **Custom Color Palette:** Fitness app-inspired gradients with Vietnamese cultural color meanings
- **Vietnamese Typography:** Optimized for Vietnamese diacritics with clear hierarchy
- **White Card Design:** Clean white cards on gradient backgrounds matching fitness app aesthetic

### Global Theme Variables

```css
/* Global CSS Custom Properties for Go Sport App */
:root {
  /* Primary Colors - Fitness App Blue Gradient */
  --color-primary-start: #4A90E2;
  --color-primary-end: #2E5BDA;
  --color-primary-solid: #3A7BD5;
  
  /* Secondary Colors - Fitness App Orange Gradient */
  --color-secondary-start: #FF8A50;
  --color-secondary-end: #FF6B35;
  --color-secondary-solid: #FF7742;
  
  /* Accent Colors */
  --color-accent-purple: #8B5CF6;
  --color-accent-green: #10B981;
  --color-accent-red: #EF4444;
  
  /* Vietnamese Cultural Status Colors */
  --color-success: #22C55E;        /* Vietnamese green for confirmed */
  --color-warning: #F59E0B;        /* Vietnamese gold for pending */
  --color-error: #DC2626;          /* Vietnamese red for cancelled */
  --color-info: #3B82F6;           /* Vietnamese blue for information */
  
  /* Neutral Colors */
  --color-white: #FFFFFF;
  --color-gray-50: #F8FAFC;
  --color-gray-100: #F1F5F9;
  --color-gray-200: #E2E8F0;
  --color-gray-300: #CBD5E1;
  --color-gray-400: #94A3B8;
  --color-gray-500: #64748B;
  --color-gray-600: #475569;
  --color-gray-700: #334155;
  --color-gray-800: #1E293B;
  --color-gray-900: #0F172A;
  
  /* Background Gradients */
  --gradient-primary: linear-gradient(135deg, var(--color-primary-start) 0%, var(--color-primary-end) 100%);
  --gradient-secondary: linear-gradient(135deg, var(--color-secondary-start) 0%, var(--color-secondary-end) 100%);
  --gradient-background: linear-gradient(180deg, #F8FAFC 0%, #E2E8F0 100%);
  
  /* Typography Scale - Vietnamese Optimized */
  --font-family-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui;
  --font-family-display: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui;
  
  /* Display Typography */
  --font-size-display: 32px;
  --font-weight-display: 800;
  --line-height-display: 1.2;
  
  /* Heading Typography */
  --font-size-h1: 28px;
  --font-weight-h1: 700;
  --line-height-h1: 1.3;
  
  --font-size-h2: 24px;
  --font-weight-h2: 600;
  --line-height-h2: 1.4;
  
  --font-size-h3: 20px;
  --font-weight-h3: 600;
  --line-height-h3: 1.4;
  
  /* Body Typography */
  --font-size-body-large: 18px;
  --font-weight-body-large: 500;
  --line-height-body-large: 1.5;
  
  --font-size-body: 16px;
  --font-weight-body: 400;
  --line-height-body: 1.5;
  
  --font-size-small: 14px;
  --font-weight-small: 400;
  --line-height-small: 1.4;
  
  /* Spacing Scale */
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
  --spacing-xl: 32px;
  --spacing-2xl: 48px;
  
  /* Border Radius */
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 16px;
  --radius-xl: 24px;
  --radius-full: 50px;
  
  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
  
  /* Card Styles - Fitness App Inspired */
  --card-background: var(--color-white);
  --card-border-radius: var(--radius-lg);
  --card-shadow: var(--shadow-md);
  --card-padding: var(--spacing-md);
  
  /* Button Styles */
  --button-height: 48px;
  --button-border-radius: var(--radius-md);
  --button-padding-horizontal: var(--spacing-lg);
  
  /* Vietnamese Sports Colors */
  --color-cau-long: #22C55E;       /* Badminton - Green */
  --color-pickleball: #F59E0B;     /* Pickleball - Orange */
  --color-bong-da: #3B82F6;        /* Football - Blue */
  
  /* Role Badge Colors */
  --color-truong-nhom: #DC2626;    /* Group Leader - Red */
  --color-pho-nhom: #F59E0B;       /* Co-leader - Orange */
  --color-thanh-vien: #3B82F6;     /* Member - Blue */
  --color-khach: #6B7280;          /* Guest - Gray */
  
  /* Dark Mode Support */
  --color-dark-background: #0F172A;
  --color-dark-surface: #1E293B;
  --color-dark-text: #F8FAFC;
  --color-dark-text-secondary: #CBD5E1;
}

/* Dark Mode Variables */
@media (prefers-color-scheme: dark) {
  :root {
    --gradient-background: linear-gradient(180deg, #1E293B 0%, #0F172A 100%);
    --card-background: var(--color-dark-surface);
    --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3), 0 2px 4px -1px rgba(0, 0, 0, 0.2);
  }
}

/* Vietnamese Text Support */
.vietnamese-text {
  font-feature-settings: "kern" 1, "liga" 1;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Utility Classes for Flutter Integration */
.gradient-primary {
  background: var(--gradient-primary);
}

.gradient-secondary {
  background: var(--gradient-secondary);
}

.card-white {
  background: var(--card-background);
  border-radius: var(--card-border-radius);
  box-shadow: var(--card-shadow);
  padding: var(--card-padding);
}

.text-display {
  font-size: var(--font-size-display);
  font-weight: var(--font-weight-display);
  line-height: var(--line-height-display);
}

.text-vietnamese {
  font-family: var(--font-family-primary);
  font-feature-settings: "kern" 1, "liga" 1;
}
```

## Testing Requirements

### Component Test Template

```typescript
// test/widget/features/attendance/attendance_card_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:go_sport_app/features/attendance/presentation/widgets/attendance_card.dart';
import 'package:go_sport_app/features/attendance/domain/entities/attendance_request_entity.dart';
import 'package:go_sport_app/core/constants/vietnamese_constants.dart';

import 'attendance_card_widget_test.mocks.dart';
import '../../../vietnamese_test_helper.dart';

@GenerateMocks([AttendanceRequestEntity])
void main() {
  group('AttendanceCard Widget Tests', () {
    late MockAttendanceRequestEntity mockRequest;
    late Widget testWidget;

    setUp(() {
      mockRequest = MockAttendanceRequestEntity();
      when(mockRequest.id).thenReturn('test-request-id');
      when(mockRequest.gameDateTime).thenReturn(DateTime(2025, 1, 15, 19, 0));
      when(mockRequest.location).thenReturn('Sân cầu lông Thành Công');
      when(mockRequest.sportType).thenReturn(SportType.cauLong);
      when(mockRequest.minimumRequired).thenReturn(8);
      when(mockRequest.currentHeadcount).thenReturn(6);
      when(mockRequest.status).thenReturn(AttendanceStatus.pending);
    });

    Widget createWidgetUnderTest({
      VoidCallback? onTap,
      bool showActions = true,
    }) {
      return ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: AttendanceCard(
              request: mockRequest,
              onTap: onTap,
              showActions: showActions,
            ),
          ),
          localizationsDelegates: VietnameseTestHelper.localizationsDelegates,
          supportedLocales: VietnameseTestHelper.supportedLocales,
          locale: const Locale('vi', 'VN'),
        ),
      );
    }

    testWidgets('should display Vietnamese game information correctly', (tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.pump();

      // Assert
      expect(find.text('Cầu lông'), findsOneWidget);
      expect(find.text('Sân cầu lông Thành Công'), findsOneWidget);
      expect(find.text('19:00 - 15/01/2025'), findsOneWidget);
      expect(find.text('6/8 người'), findsOneWidget);
    });

    testWidgets('should show correct status color for pending attendance', (tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.pump();

      // Assert
      final statusIndicator = find.byType(Container).first;
      final container = tester.widget<Container>(statusIndicator);
      final decoration = container.decoration as BoxDecoration?;
      
      expect(decoration?.color, equals(VietnameseColors.pendingOrange));
    });

    testWidgets('should handle tap events correctly', (tester) async {
      // Arrange
      bool wasTapped = false;
      await tester.pumpWidget(createWidgetUnderTest(
        onTap: () => wasTapped = true,
      ));

      // Act
      await tester.tap(find.byType(AttendanceCard));
      await tester.pump();

      // Assert
      expect(wasTapped, isTrue);
    });

    testWidgets('should show attendance response buttons for active requests', (tester) async {
      // Arrange
      when(mockRequest.status).thenReturn(AttendanceStatus.active);
      when(mockRequest.canRespond).thenReturn(true);
      
      await tester.pumpWidget(createWidgetUnderTest(showActions: true));

      // Act
      await tester.pump();

      // Assert
      expect(find.text('✅ Có thể đến'), findsOneWidget);
      expect(find.text('❌ Không thể đến'), findsOneWidget);
    });

    testWidgets('should not show action buttons for cancelled requests', (tester) async {
      // Arrange
      when(mockRequest.status).thenReturn(AttendanceStatus.cancelled);
      
      await tester.pumpWidget(createWidgetUnderTest(showActions: true));

      // Act
      await tester.pump();

      // Assert
      expect(find.text('✅ Có thể đến'), findsNothing);
      expect(find.text('❌ Không thể đến'), findsNothing);
      expect(find.text('Đã hủy'), findsOneWidget);
    });

    testWidgets('should display Vietnamese sport type correctly', (tester) async {
      // Arrange
      when(mockRequest.sportType).thenReturn(SportType.bongDa);
      
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.pump();

      // Assert
      expect(find.text('Bóng đá'), findsOneWidget);
    });

    testWidgets('should handle offline response state', (tester) async {
      // Arrange
      when(mockRequest.hasOfflineResponse).thenReturn(true);
      when(mockRequest.offlineResponse).thenReturn(AttendanceResponse.attending);
      
      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.pump();

      // Assert
      expect(find.byIcon(Icons.sync_problem), findsOneWidget);
      expect(find.text('Chờ đồng bộ'), findsOneWidget);
    });

    group('Vietnamese Date Formatting', () {
      testWidgets('should format Vietnamese date correctly', (tester) async {
        // Arrange
        when(mockRequest.gameDateTime).thenReturn(DateTime(2025, 12, 25, 14, 30));
        
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.pump();

        // Assert
        expect(find.text('14:30 - 25/12/2025'), findsOneWidget);
      });

      testWidgets('should show relative time for today games', (tester) async {
        // Arrange
        final today = DateTime.now();
        final todayGame = DateTime(today.year, today.month, today.day, 19, 0);
        when(mockRequest.gameDateTime).thenReturn(todayGame);
        
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.pump();

        // Assert
        expect(find.textContaining('Hôm nay'), findsOneWidget);
      });
    });

    group('Role-based UI Tests', () {
      testWidgets('should show admin actions for group leaders', (tester) async {
        // Arrange - Mock user role as group leader
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              currentUserRoleProvider.overrideWithValue(UserRole.truongNhom),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: AttendanceCard(
                  request: mockRequest,
                  showActions: true,
                ),
              ),
              localizationsDelegates: VietnameseTestHelper.localizationsDelegates,
              supportedLocales: VietnameseTestHelper.supportedLocales,
              locale: const Locale('vi', 'VN'),
            ),
          ),
        );

        // Act
        await tester.pump();

        // Assert
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
      });

      testWidgets('should hide admin actions for regular members', (tester) async {
        // Arrange - Mock user role as regular member
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              currentUserRoleProvider.overrideWithValue(UserRole.thanhVien),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: AttendanceCard(
                  request: mockRequest,
                  showActions: true,
                ),
              ),
              localizationsDelegates: VietnameseTestHelper.localizationsDelegates,
              supportedLocales: VietnameseTestHelper.supportedLocales,
              locale: const Locale('vi', 'VN'),
            ),
          ),
        );

        // Act
        await tester.pump();

        // Assert
        expect(find.byIcon(Icons.more_vert), findsNothing);
      });
    });
  });
}

// test/unit/core/utils/vietnamese_formatter_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:go_sport_app/core/utils/vietnamese_formatter.dart';

void main() {
  group('VietnameseFormatter Tests', () {
    late VietnameseFormatter formatter;

    setUp(() {
      formatter = VietnameseFormatter();
    });

    group('Phone Number Formatting', () {
      test('should format Vietnamese phone numbers correctly', () {
        // Test various Vietnamese phone formats
        expect(formatter.formatPhoneNumber('0901234567'), equals('+84 901 234 567'));
        expect(formatter.formatPhoneNumber('84901234567'), equals('+84 901 234 567'));
        expect(formatter.formatPhoneNumber('+84901234567'), equals('+84 901 234 567'));
      });

      test('should validate Vietnamese phone numbers', () {
        expect(formatter.isValidVietnamesePhone('0901234567'), isTrue);
        expect(formatter.isValidVietnamesePhone('84901234567'), isTrue);
        expect(formatter.isValidVietnamesePhone('+84901234567'), isTrue);
        expect(formatter.isValidVietnamesePhone('1234567890'), isFalse);
        expect(formatter.isValidVietnamesePhone('09012345'), isFalse);
      });
    });

    group('Date Time Formatting', () {
      test('should format Vietnamese dates correctly', () {
        final date = DateTime(2025, 1, 15, 19, 30);
        expect(formatter.formatDate(date), equals('15/01/2025'));
        expect(formatter.formatTime(date), equals('19:30'));
        expect(formatter.formatDateTime(date), equals('19:30 - 15/01/2025'));
      });

      test('should format relative Vietnamese dates', () {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day, 19, 0);
        final tomorrow = today.add(const Duration(days: 1));
        final yesterday = today.subtract(const Duration(days: 1));

        expect(formatter.formatRelativeDate(today), contains('Hôm nay'));
        expect(formatter.formatRelativeDate(tomorrow), contains('Ngày mai'));
        expect(formatter.formatRelativeDate(yesterday), contains('Hôm qua'));
      });
    });

    group('Sports Terminology', () {
      test('should translate sport types to Vietnamese', () {
        expect(formatter.translateSportType(SportType.cauLong), equals('Cầu lông'));
        expect(formatter.translateSportType(SportType.pickleball), equals('Pickleball'));
        expect(formatter.translateSportType(SportType.bongDa), equals('Bóng đá'));
      });

      test('should translate user roles to Vietnamese', () {
        expect(formatter.translateRole(UserRole.truongNhom), equals('Trưởng nhóm'));
        expect(formatter.translateRole(UserRole.phoNhom), equals('Phó nhóm'));
        expect(formatter.translateRole(UserRole.thanhVien), equals('Thành viên'));
        expect(formatter.translateRole(UserRole.khach), equals('Khách'));
      });
    });
  });
}
```

### Testing Best Practices

1. **Unit Tests**: Test individual components in isolation with Vietnamese test data
2. **Integration Tests**: Test component interactions with Vietnamese cultural scenarios
3. **Widget Tests**: Test UI rendering with Vietnamese text and cultural elements
4. **Golden Tests**: Visual regression testing for Vietnamese UI layouts
5. **Network Tests**: Mock Vietnamese API responses and error scenarios
6. **Offline Tests**: Test offline functionality with Vietnamese network conditions
7. **Payment Tests**: Mock Vietnamese payment gateway interactions
8. **Role-based Tests**: Test UI variations based on Vietnamese group hierarchy

## Environment Configuration

```typescript
# .env.development
FLUTTER_APP_ENV=development
API_BASE_URL=http://localhost:8000/api/v1
WS_BASE_URL=ws://localhost:8000/ws

# Vietnamese SMS Configuration
SMS_PROVIDER=viettel
SMS_API_KEY=dev-sms-key-123
SMS_TEST_MODE=true

# Firebase Configuration
FIREBASE_PROJECT_ID=go-sport-dev
FIREBASE_API_KEY=dev-firebase-key
FIREBASE_MESSAGING_SENDER_ID=123456789

# Vietnamese Payment Gateway (Sandbox)
MOMO_PARTNER_CODE=dev-partner-code
MOMO_PARTNER_NAME=GoSportDev
MOMO_ENVIRONMENT=sandbox

VIETQR_API_KEY=dev-vietqr-key
VIETQR_CLIENT_ID=go-sport-dev

ZALOPAY_APP_ID=12345
ZALOPAY_ENVIRONMENT=sandbox

# Debug Settings
DEBUG_NETWORK_LOGS=true
DEBUG_PAYMENT_LOGS=true
DEBUG_NOTIFICATIONS=true

# .env.production
FLUTTER_APP_ENV=production
API_BASE_URL=https://api.gosport.vn/v1
WS_BASE_URL=wss://api.gosport.vn/ws

# Vietnamese SMS Configuration
SMS_PROVIDER=viettel
SMS_API_KEY=prod-sms-key-xxx
SMS_TEST_MODE=false

# Firebase Configuration
FIREBASE_PROJECT_ID=go-sport-prod
FIREBASE_API_KEY=prod-firebase-key
FIREBASE_MESSAGING_SENDER_ID=987654321

# Vietnamese Payment Gateway (Production)
MOMO_PARTNER_CODE=prod-partner-code
MOMO_PARTNER_NAME=GoSport
MOMO_ENVIRONMENT=production

VIETQR_API_KEY=prod-vietqr-key
VIETQR_CLIENT_ID=go-sport-prod

ZALOPAY_APP_ID=67890
ZALOPAY_ENVIRONMENT=production

# Security Settings
DEBUG_NETWORK_LOGS=false
DEBUG_PAYMENT_LOGS=false
DEBUG_NOTIFICATIONS=false
SSL_CERT_VALIDATION=true
```

## Frontend Developer Standards

### Critical Coding Rules

1. **Vietnamese Data Handling**: All user-facing text must properly handle Vietnamese diacritics with UTF-8 encoding
2. **Offline-First Attendance**: Attendance responses must work offline and sync when connectivity returns
3. **Role-Based UI**: Every screen must adapt UI based on user role (Guest, Member, Co-leader, Leader)
4. **Payment Security**: Never log payment amounts, QR codes, or transaction details
5. **Phone Number Privacy**: Always use formatted display, store encrypted phone numbers only
6. **Real-time Updates**: Use StreamProvider for attendance status changes affecting multiple users
7. **Vietnamese Network Resilience**: Implement retry logic for Vietnamese mobile network conditions
8. **Cultural Color Coding**: Use Vietnamese-appropriate colors for status indicators (green=good, red=urgent)
9. **Notification-Driven UX**: Primary user entry through push notifications, optimize notification-to-action flow
10. **Memory Management**: Properly dispose of StreamSubscriptions and Controllers in Vietnamese real-time features

### Quick Reference

**Development Commands:**
```bash
# Start development server
flutter run --debug --flavor development

# Build for Vietnamese testing
flutter build apk --flavor staging --dart-define=ENVIRONMENT=staging

# Generate Vietnamese localization
flutter gen-l10n

# Run tests with Vietnamese data
flutter test --coverage test/vietnamese_test_suite/

# Generate code (Riverpod, JSON serialization)
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**Key Import Patterns:**
```dart
// Feature imports (Clean Architecture)
import 'package:go_sport_app/features/attendance/domain/entities/attendance_entity.dart';
import 'package:go_sport_app/features/attendance/presentation/providers/attendance_provider.dart';

// Core utilities
import 'package:go_sport_app/core/utils/vietnamese_formatter.dart';
import 'package:go_sport_app/core/constants/vietnamese_constants.dart';

// Shared widgets
import 'package:go_sport_app/shared/widgets/buttons/primary_button.dart';
import 'package:go_sport_app/shared/widgets/cards/white_card.dart';

// Localization
import 'package:go_sport_app/l10n/l10n.dart';
```

**File Naming Conventions:**
- Pages: `{feature}_page.dart`
- Widgets: `{purpose}_widget.dart` or `{purpose}_card.dart`
- Providers: `{feature}_provider.dart`, `{feature}_notifier.dart`
- Models: `{entity}_model.dart`
- Vietnamese-specific: `vietnamese_{purpose}.dart`

**Project-Specific Patterns:**
```dart
// Vietnamese text handling
Text(
  context.l10n.attendanceConfirmButton,
  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    fontFeatureSettings: [const FontFeature.enable('kern')],
  ),
)

// Role-based UI rendering
if (ref.watch(userRoleProvider) == UserRole.truongNhom) {
  // Show admin actions
}

// Offline attendance response
await ref.read(attendanceProvider.notifier).respondToAttendance(
  requestId: requestId,
  response: AttendanceResponse.attending,
  isOffline: !ref.read(connectivityProvider),
);

// Vietnamese phone number formatting
final formattedPhone = VietnameseFormatter.formatPhoneNumber(phoneNumber);

// Gradient backgrounds (Fitness app style)
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Theme.of(context).extension<VietnameseColors>()!.primaryStart,
        Theme.of(context).extension<VietnameseColors>()!.primaryEnd,
      ],
    ),
  ),
  child: child,
)
```