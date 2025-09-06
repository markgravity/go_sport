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
- [ ] **flutter_bloc: ^8.1.3** added to pubspec.yaml
- [ ] **get_it: ^8.0.0** added to pubspec.yaml  
- [ ] **injectable: ^2.3.2** added to pubspec.yaml
- [ ] **auto_route: ^8.0.3** added to pubspec.yaml
- [ ] **freezed: ^2.4.6** added to pubspec.yaml
- [ ] **build_runner** configuration updated for code generation
- [ ] All dependencies resolve without conflicts with existing Riverpod deps

### AC2: GetIt Dependency Injection Setup
- [ ] Create `core/dependency_injection/injection_container.dart`
- [ ] Create `core/dependency_injection/injection_container.config.dart` (generated)
- [ ] Initialize GetIt service locator in `main.dart` alongside existing Riverpod setup
- [ ] Register existing services (ApiService, SecureStorage, etc.) in GetIt
- [ ] Verify services can be resolved from both Riverpod and GetIt during transition

### AC3: Base Architecture Templates
- [ ] Create base Cubit template in `core/presentation/base_cubit.dart`
- [ ] Create Freezed state template in `core/presentation/base_state.dart`
- [ ] Create MVVM ViewModel template following existing naming conventions
- [ ] Templates include Vietnamese comment examples and cultural patterns
- [ ] Code generation works without errors: `flutter packages pub run build_runner build`

### AC4: AutoRoute Foundation Setup
- [ ] Create `app/app_router.dart` with basic AutoRoute configuration
- [ ] Create `app/app_router.gr.dart` (generated)
- [ ] Initialize AutoRoute in `app/app.dart` **alongside** existing GoRouter (coexistence)
- [ ] Create basic route guards template (AuthGuard, UnauthGuard)
- [ ] Verify both routing systems can coexist without conflicts

### AC5: Documentation Updates
- [ ] Update `TEAM_ONBOARDING.md` with new architecture patterns
- [ ] Create migration-specific developer guide in `docs/migration-guide.md`
- [ ] Document coexistence patterns for Riverpod + Cubit transition period
- [ ] Update Vietnamese development standards to include Cubit patterns

## Integration Verification

### IV1: Existing Riverpod Authentication Flows
- [ ] Login screen continues to work with existing AuthProvider
- [ ] SMS verification flow functions identically
- [ ] Token storage and session management unchanged
- [ ] Vietnamese phone validation works without modifications

### IV2: GoRouter Navigation Operational
- [ ] All existing routes continue to function
- [ ] Deep linking for attendance requests works
- [ ] Vietnamese payment flow navigation unchanged
- [ ] Route guards for authentication remain functional

### IV3: Vietnamese Payment Gateway Integration
- [ ] Momo SDK integration unaffected by new dependencies
- [ ] VietQR API calls continue working
- [ ] ZaloPay integration remains functional
- [ ] QR code generation and scanning unchanged

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

- [ ] All acceptance criteria completed and verified
- [ ] Integration verification tests pass
- [ ] Vietnamese cultural patterns unaffected
- [ ] Code review completed by lead developer
- [ ] Build generates successfully with new dependencies
- [ ] No performance regression in app startup time
- [ ] Documentation updated and reviewed
- [ ] QA sign-off on existing functionality preservation

## Rollback Procedure

If issues arise during implementation:

1. **Remove new dependencies** from pubspec.yaml
2. **Delete generated files** (.gr.dart, .config.dart)
3. **Remove GetIt initialization** from main.dart  
4. **Restore original main.dart** structure
5. **Verify existing Riverpod functionality** works identically

## Next Story

**Story Migration 2**: Authentication System Migration (depends on this story completion)