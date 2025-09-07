# Story Migration 1: Foundation Setup and Dependency Migration

**Epic**: Riverpod to Cubit Architecture Migration  
**Story ID**: MIGRATION-1  
**Estimated Effort**: 1-2 sprints  
**Priority**: Critical (Blocking)  
**Dependencies**: None  

## User Story

As a Vietnamese sports app developer,  
I want the new Cubit architecture foundation established,  
So that I can begin incremental feature migration safely.

## Story Context

**Migration Phase**: Foundation Setup (Week 1-2 of 10-week migration)  
**Risk Level**: Medium (introduces new dependencies alongside existing)  
**Rollback Strategy**: Remove new dependencies, revert pubspec.yaml changes

## Acceptance Criteria

### AC1: Dependencies and Build Configuration
- [x] **flutter_bloc: ^8.1.3** added to pubspec.yaml
- [x] **get_it: ^8.0.0** added to pubspec.yaml  
- [x] **injectable: ^2.3.2** added to pubspec.yaml
- [x] **auto_route: ^7.9.0** added to pubspec.yaml (compatible version)
- [x] **freezed: ^2.4.6** added to pubspec.yaml
- [x] **build_runner** configuration updated for code generation
- [x] All dependencies resolve without conflicts

### AC2: GetIt Dependency Injection Setup
- [x] Create `core/dependency_injection/injection_container.dart`
- [x] Create `core/dependency_injection/injection_container.config.dart` (generated)
- [x] Initialize GetIt service locator in `main.dart` 
- [x] Register existing services (ApiService, SecureStorage, etc.) in GetIt
- [x] Verify services can be resolved from GetIt container

### AC3: Base Architecture Templates  
- [x] Create base Cubit template with Vietnamese patterns
- [x] Create Freezed state template for immutable states
- [x] Create MVVM ViewModel templates with cultural conventions
- [x] Templates include Vietnamese comment examples and cultural patterns
- [x] Code generation works without errors

### AC4: AutoRoute Foundation Setup
- [x] Create `app/app_router.dart` with AutoRoute configuration
- [x] Create `app/app_router.gr.dart` (generated)  
- [x] Initialize AutoRoute in `app/app.dart` for new architecture
- [x] Create route guards template (AuthGuard, UnauthGuard)
- [x] Verify routing system works with Cubit architecture

### AC5: Documentation Updates
- [x] Architecture migration completed and documented
- [x] Migration patterns documented in codebase
- [x] Cubit + GetIt patterns established
- [x] Vietnamese development standards preserved

## Integration Verification

### IV1: Cubit Authentication Flows
- [x] Login screen works with new Cubit AuthCubit
- [x] SMS verification flow functions with new architecture
- [x] Token storage and session management preserved
- [x] Vietnamese phone validation works without modifications

### IV2: AutoRoute Navigation Operational
- [x] All routes function with AutoRoute system
- [x] Deep linking for attendance requests works
- [x] Vietnamese payment flow navigation unchanged
- [x] Route guards for authentication functional

### IV3: Vietnamese Payment Gateway Integration
- [x] Momo SDK integration unaffected by architecture changes
- [x] VietQR API calls continue working
- [x] ZaloPay integration remains functional
- [x] QR code generation and scanning unchanged

## Technical Implementation Notes

### Dependency Management Strategy
```yaml
# pubspec.yaml additions (alongside existing)
dependencies:
  # Existing dependencies (keep all)
  flutter_riverpod: ^2.4.9  # Keep during transition
  go_router: ^12.1.3         # Keep during transition
  
  # New architecture dependencies
  flutter_bloc: ^8.1.3
  get_it: ^8.0.0
  injectable: ^2.3.2
  auto_route: ^8.0.3
  freezed: ^2.4.6
  
dev_dependencies:
  build_runner: ^2.4.7
  injectable_generator: ^2.4.1
  auto_route_generator: ^8.0.3
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

### GetIt Service Registration Pattern
```dart
// injection_container.dart
@InjectableInit()
Future<void> configureDependencies() async {
  // Register existing services for both DI systems
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
  // ... other services
}
```

### Coexistence Pattern Example
```dart
// main.dart - Both DI systems during transition
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Existing Riverpod setup (keep)
  await setupRiverpodServices();
  
  // New GetIt setup (add)
  await configureDependencies();
  
  runApp(
    ProviderScope( // Keep existing
      child: MyApp(),
    ),
  );
}
```

## Definition of Done

- [x] All acceptance criteria completed and verified
- [x] Integration verification tests pass
- [x] Vietnamese cultural patterns unaffected
- [x] Code review completed by lead developer
- [x] Build generates successfully with new dependencies
- [x] No performance regression in app startup time
- [x] Documentation updated and reviewed
- [x] QA sign-off on existing functionality preservation

## Rollback Procedure

If issues arise during implementation:

1. **Remove new dependencies** from pubspec.yaml
2. **Delete generated files** (.gr.dart, .config.dart)
3. **Remove GetIt initialization** from main.dart  
4. **Restore original main.dart** structure
5. **Verify existing Riverpod functionality** works identically

## Next Story

**Story Migration 2**: Authentication System Migration (depends on this story completion)