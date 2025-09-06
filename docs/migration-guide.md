# Go Sport Architecture Migration Guide
# Hướng dẫn Migration kiến trúc Go Sport

*Available in: [English](#english) | [Tiếng Việt](#vietnamese)*

---

## <a name="english"></a>🇺🇸 English

### Migration Overview

This guide covers the migration from **Riverpod + GoRouter** to **Cubit + GetIt + AutoRoute** architecture for the Go Sport mobile application.

**Migration Timeline**: 10 weeks (Phased approach)  
**Current Status**: Foundation Setup Complete ✅

### Migration Phases

#### ✅ Phase 1: Foundation Setup (Week 1-2)
**Status**: **COMPLETE**

**Implemented Components:**
- ✅ **Dependencies**: flutter_bloc, get_it, injectable, auto_route, freezed
- ✅ **GetIt DI**: Service registration and coexistence with Riverpod
- ✅ **Base Architecture**: BaseCubit, BaseState, BaseViewModel templates
- ✅ **AutoRoute Foundation**: Basic routing setup alongside GoRouter
- ✅ **Code Generation**: Build runner configuration working

**Verification:**
- All new dependencies resolve without conflicts
- Services accessible via both Riverpod and GetIt
- Code generation (`flutter packages pub run build_runner build`) works
- Both routing systems functional

#### ⏳ Phase 2: Authentication Migration (Week 3-4)
**Status**: **READY TO START**

**Tasks:**
- [ ] Create AuthCubit using BaseCubit template
- [ ] Migrate AuthProvider logic to AuthCubit
- [ ] Update login screens to use BlocBuilder
- [ ] Test authentication flow with new architecture
- [ ] Maintain backward compatibility

#### ⏳ Phase 3: Groups Feature Migration (Week 5-6)
**Status**: **PENDING**

**Tasks:**
- [ ] Migrate GroupsProvider to GroupsCubit
- [ ] Update group management screens
- [ ] Implement group creation flow with new architecture
- [ ] Test group permissions and role management

#### ⏳ Phase 4: Navigation Migration (Week 7-8)
**Status**: **PENDING**

**Tasks:**
- [ ] Fully implement AutoRoute configuration
- [ ] Migrate deep linking from GoRouter
- [ ] Update route guards implementation
- [ ] Test navigation flows

#### ⏳ Phase 5: Cleanup and Optimization (Week 9-10)
**Status**: **PENDING**

**Tasks:**
- [ ] Remove Riverpod dependencies
- [ ] Remove GoRouter dependencies  
- [ ] Code cleanup and optimization
- [ ] Performance testing and optimization

### Architecture Comparison

#### Current (Riverpod + GoRouter)
```dart
// State Management
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// UI Consumption
Consumer(
  builder: (context, ref, child) {
    final authState = ref.watch(authProvider);
    return authState.when(
      data: (user) => UserWidget(user),
      loading: () => LoadingWidget(),
      error: (error, _) => ErrorWidget(error),
    );
  },
)

// Navigation
context.go('/login');
```

#### New (Cubit + GetIt + AutoRoute)
```dart
// State Management
class AuthCubit extends BaseCubit<User> {
  AuthCubit({required this.authService});
  
  final AuthService authService;
  
  Future<void> login(String phone, String password) async {
    await safeExecute(
      () => authService.login(phone: phone, password: password),
      loadingMessage: "Đang đăng nhập...",
    );
  }
}

// UI Consumption
BlocBuilder<AuthCubit, BaseState<User>>(
  builder: (context, state) {
    return state.when(
      initial: () => LoginForm(),
      loading: (_) => LoadingWidget(),
      success: (user, _) => UserWidget(user),
      error: (message, _) => ErrorWidget(message),
    );
  },
)

// Navigation
context.router.pushNamed('/login');
```

### Coexistence Patterns

During the migration period, both architectures will coexist:

#### Service Access Pattern
```dart
// Both DI systems available
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Legacy Riverpod access
    final apiClient = ref.read(apiClientProvider);
    
    // New GetIt access
    final authService = getIt<AuthService>();
    
    return SomeWidget();
  }
}
```

#### State Management Bridge
```dart
// Bridge pattern for gradual migration
class LegacyToNewBridge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider(
      create: (_) => AuthCubit(authService: getIt<AuthService>()),
      child: BlocBuilder<AuthCubit, BaseState<User>>(
        builder: (context, state) {
          // New UI with Cubit state
          return ModernUserInterface();
        },
      ),
    );
  }
}
```

#### Navigation Coexistence
```dart
// Both navigation systems available
class NavigationHelper {
  // Legacy GoRouter
  static void goToLegacyRoute(BuildContext context, String route) {
    context.go(route);
  }
  
  // New AutoRoute
  static void navigateToNewRoute(BuildContext context, String route) {
    context.router.pushNamed(route);
  }
}
```

### Development Guidelines During Migration

#### For New Features
- ✅ **MUST USE**: Cubit + GetIt + AutoRoute
- ✅ **Base Classes**: Extend BaseCubit, BaseViewModel
- ✅ **State Classes**: Use BaseState<T> with Freezed
- ✅ **DI**: Register services with GetIt
- ✅ **Navigation**: Use AutoRoute for new routes

#### For Bug Fixes in Existing Features
- ✅ **MAINTAIN**: Existing Riverpod + GoRouter architecture
- ⚠️ **AVOID**: Mixing architectures in same feature
- ✅ **DOCUMENT**: Any temporary workarounds

#### For Feature Updates/Enhancements  
- 🔄 **EVALUATE**: Cost/benefit of migration vs maintaining
- ✅ **PREFER**: Incremental migration when possible
- ✅ **DISCUSS**: Architecture decision with team lead

### Testing Strategy

#### Unit Tests
```dart
// Test Cubit logic
void main() {
  group('AuthCubit', () {
    late AuthCubit authCubit;
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      authCubit = AuthCubit(authService: mockAuthService);
    });

    test('should emit success state on successful login', () async {
      // Arrange
      when(mockAuthService.login(phone: any, password: any))
          .thenAnswer((_) async => User(id: '1'));

      // Act
      await authCubit.login('0987654321', 'password');

      // Assert
      expect(authCubit.state.isSuccess, true);
    });
  });
}
```

#### Widget Tests
```dart
// Test UI with Cubit
testWidgets('should show loading when authenticating', (tester) async {
  final mockCubit = MockAuthCubit();
  when(mockCubit.state).thenReturn(BaseState.loading());

  await tester.pumpWidget(
    BlocProvider.value(
      value: mockCubit,
      child: LoginScreen(),
    ),
  );

  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

### Common Pitfalls and Solutions

#### ❌ Problem: Mixing architectures in same widget
```dart
// DON'T DO THIS
class BadWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riverpodState = ref.watch(someProvider);
    
    return BlocBuilder<SomeCubit, BaseState>(
      builder: (context, cubitState) {
        // Mixing both architectures - confusing and error-prone
        return ComplexWidget();
      },
    );
  }
}
```

#### ✅ Solution: Use bridge pattern or migrate completely
```dart
// DO THIS INSTEAD
class GoodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SomeCubit, BaseState>(
      builder: (context, state) {
        // Consistent architecture usage
        return CleanWidget();
      },
    );
  }
}
```

### Code Generation Commands

```bash
# Generate all code (Freezed, Injectable, AutoRoute)
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch for changes during development
flutter packages pub run build_runner watch --delete-conflicting-outputs

# Clean generated files
flutter packages pub run build_runner clean
```

### Performance Considerations

#### Memory Management
- Both DI systems consume memory during coexistence
- Monitor memory usage during migration
- Clean up unused providers/cubits promptly

#### Build Time
- Additional code generation increases build time
- Use `--delete-conflicting-outputs` for clean builds
- Consider splitting large generated files

### Migration Checklist for Features

When migrating a feature from Riverpod to Cubit:

- [ ] **Audit Dependencies**: List all providers and dependencies
- [ ] **Create Cubit**: Extend appropriate base class
- [ ] **Define States**: Use BaseState<T> pattern
- [ ] **Implement Business Logic**: Move from Provider to Cubit
- [ ] **Update UI**: Replace Consumer with BlocBuilder
- [ ] **Register Services**: Add to GetIt if needed
- [ ] **Write Tests**: Unit tests for Cubit, widget tests for UI
- [ ] **Update Navigation**: Use AutoRoute if applicable
- [ ] **Remove Legacy Code**: Clean up Riverpod providers
- [ ] **Documentation**: Update feature documentation

---

## <a name="vietnamese"></a>🇻🇳 Tiếng Việt

### Tổng quan Migration

Hướng dẫn này hướng dẫn migration từ kiến trúc **Riverpod + GoRouter** sang **Cubit + GetIt + AutoRoute** cho ứng dụng mobile Go Sport.

**Timeline Migration**: 10 tuần (Tiếp cận theo giai đoạn)  
**Trạng thái hiện tại**: Hoàn thành Foundation Setup ✅

### Các giai đoạn Migration

#### ✅ Giai đoạn 1: Thiết lập Foundation (Tuần 1-2)
**Trạng thái**: **HOÀN THÀNH**

**Các thành phần đã triển khai:**
- ✅ **Dependencies**: flutter_bloc, get_it, injectable, auto_route, freezed
- ✅ **GetIt DI**: Đăng ký service và coexist với Riverpod
- ✅ **Base Architecture**: Templates BaseCubit, BaseState, BaseViewModel
- ✅ **AutoRoute Foundation**: Thiết lập routing cơ bản cùng với GoRouter
- ✅ **Code Generation**: Cấu hình build runner hoạt động

**Xác minh:**
- Tất cả dependencies mới resolve không xung đột
- Services có thể truy cập qua cả Riverpod và GetIt
- Code generation hoạt động
- Cả hai hệ thống routing functional

#### ⏳ Giai đoạn 2: Migration Authentication (Tuần 3-4)
**Trạng thái**: **SẴN SÀNG BẮT ĐẦU**

**Tasks:**
- [ ] Tạo AuthCubit sử dụng template BaseCubit
- [ ] Di chuyển logic AuthProvider sang AuthCubit
- [ ] Cập nhật màn hình login sử dụng BlocBuilder
- [ ] Test authentication flow với architecture mới
- [ ] Duy trì backward compatibility

### So sánh Architecture

#### Hiện tại (Riverpod + GoRouter)
```dart
// Quản lý state
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Sử dụng trong UI
Consumer(
  builder: (context, ref, child) {
    final authState = ref.watch(authProvider);
    return authState.when(
      data: (user) => UserWidget(user),
      loading: () => LoadingWidget(),
      error: (error, _) => ErrorWidget(error),
    );
  },
)
```

#### Mới (Cubit + GetIt + AutoRoute)
```dart
// Quản lý state
class AuthCubit extends BaseCubit<User> {
  AuthCubit({required this.authService});
  
  final AuthService authService;
  
  Future<void> login(String phone, String password) async {
    await safeExecute(
      () => authService.login(phone: phone, password: password),
      loadingMessage: "Đang đăng nhập...",
    );
  }
}

// Sử dụng trong UI
BlocBuilder<AuthCubit, BaseState<User>>(
  builder: (context, state) {
    return state.when(
      initial: () => LoginForm(),
      loading: (_) => LoadingWidget(),
      success: (user, _) => UserWidget(user),
      error: (message, _) => ErrorWidget(message),
    );
  },
)
```

### Patterns Coexistence

Trong thời gian migration, cả hai architecture sẽ tồn tại song song:

#### Pattern truy cập Service
```dart
// Cả hai hệ thống DI có sẵn
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Truy cập Riverpod legacy
    final apiClient = ref.read(apiClientProvider);
    
    // Truy cập GetIt mới
    final authService = getIt<AuthService>();
    
    return SomeWidget();
  }
}
```

### Hướng dẫn phát triển trong thời gian Migration

#### Cho tính năng mới
- ✅ **BẮT BUỘC SỬ DỤNG**: Cubit + GetIt + AutoRoute
- ✅ **Base Classes**: Extend BaseCubit, BaseViewModel
- ✅ **State Classes**: Sử dụng BaseState<T> với Freezed
- ✅ **DI**: Đăng ký services với GetIt

#### Cho việc sửa bug trong tính năng hiện tại
- ✅ **DUY TRÌ**: Architecture Riverpod + GoRouter hiện tại
- ⚠️ **TRÁNH**: Trộn lẫn architectures trong cùng feature
- ✅ **DOCUMENT**: Bất kỳ workaround tạm thời nào

### Lệnh Code Generation

```bash
# Generate tất cả code (Freezed, Injectable, AutoRoute)
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch changes trong development
flutter packages pub run build_runner watch --delete-conflicting-outputs

# Clean generated files
flutter packages pub run build_runner clean
```

### Checklist Migration cho Features

Khi migrate một feature từ Riverpod sang Cubit:

- [ ] **Audit Dependencies**: Liệt kê tất cả providers và dependencies
- [ ] **Tạo Cubit**: Extend base class phù hợp
- [ ] **Define States**: Sử dụng pattern BaseState<T>
- [ ] **Implement Business Logic**: Chuyển từ Provider sang Cubit
- [ ] **Cập nhật UI**: Thay Consumer bằng BlocBuilder
- [ ] **Đăng ký Services**: Thêm vào GetIt nếu cần
- [ ] **Viết Tests**: Unit tests cho Cubit, widget tests cho UI
- [ ] **Cập nhật Navigation**: Sử dụng AutoRoute nếu applicable
- [ ] **Xóa Legacy Code**: Clean up Riverpod providers
- [ ] **Documentation**: Cập nhật tài liệu feature

### Lỗi thường gặp và Giải pháp

#### ❌ Vấn đề: Trộn lẫn architectures trong cùng widget
```dart
// ĐỪNG LÀM NHƯ NÀY
class BadWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riverpodState = ref.watch(someProvider);
    
    return BlocBuilder<SomeCubit, BaseState>(
      builder: (context, cubitState) {
        // Trộn cả hai architectures - gây confusion và dễ lỗi
        return ComplexWidget();
      },
    );
  }
}
```

#### ✅ Giải pháp: Sử dụng bridge pattern hoặc migrate hoàn toàn
```dart
// LÀM NHƯ NÀY THAY VÀO ĐÓ
class GoodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SomeCubit, BaseState>(
      builder: (context, state) {
        // Sử dụng architecture nhất quán
        return CleanWidget();
      },
    );
  }
}
```

### Hỗ trợ và Liên hệ

**Khi cần hỗ trợ về Migration:**
1. Kiểm tra guide này trước
2. Tìm kiếm trong Slack #migration-support
3. Hỏi team lead architecture
4. Escalate lên senior developer nếu cần

**Resource Links:**
- [Flutter Bloc Documentation](https://bloclibrary.dev/)
- [GetIt Documentation](https://pub.dev/packages/get_it)
- [AutoRoute Documentation](https://pub.dev/packages/auto_route)
- [Freezed Documentation](https://pub.dev/packages/freezed)