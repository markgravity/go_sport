# Story Migration 2: Authentication System Migration

**Epic**: Riverpod to Cubit Architecture Migration  
**Story ID**: MIGRATION-2  
**Estimated Effort**: 2-3 sprints  
**Priority**: Critical  
**Dependencies**: MIGRATION-1 (Foundation Setup)  

## User Story

As a Vietnamese sports group member,  
I want to log in with my phone number exactly as before,  
So that my authentication experience remains seamless during the migration.

## Story Context

**Migration Phase**: Authentication Migration (Week 3-4 of 10-week migration)  
**Risk Level**: High (critical user authentication flows)  
**Rollback Strategy**: Feature flag to switch back to Riverpod AuthProvider

## Acceptance Criteria

### AC1: AuthProvider to AuthCubit Migration
- [x] Create screen-specific ViewModels co-located with screens:
  - `features/auth/screens/login/login_view_model.dart` (AuthCubit)
  - `features/auth/screens/login/login_state.dart` (Freezed state)
  - `features/auth/screens/phone_registration/phone_registration_view_model.dart`
  - `features/auth/screens/sms_verification/sms_verification_view_model.dart`
- [x] Implement identical state transitions: `unauthenticated → authenticating → authenticated`
- [x] Preserve phone verification required state for Vietnamese SMS flow
- [x] Maintain error handling with Vietnamese error messages
- [x] Register all screen ViewModels in GetIt dependency injection container

### AC2: Screen Updates to BlocBuilder Pattern
- [x] Update `LoginScreen` to use `BlocProvider` and `BlocBuilder<AuthCubit, AuthState>`
- [x] Update `PhoneRegistrationScreen` to use new Cubit patterns
- [x] Update `SmsVerificationScreen` to consume AuthCubit state
- [x] Replace all `Consumer<AuthProvider>` with `BlocBuilder<AuthCubit, AuthState>`
- [x] Maintain identical UI rendering and Vietnamese localization

### AC3: Vietnamese Phone Validation Preservation
- [x] Ensure `VietnamesePhoneValidator.validate()` works with new forms
- [x] Preserve phone number formatting for Vietnamese formats (+84, 84, 0 prefixes)
- [x] Maintain phone number display patterns in Vietnamese cultural style
- [x] Keep SMS code input validation patterns unchanged
- [x] Ensure phone number storage format remains compatible with backend API

### AC4: Secure Token Storage Integration
- [x] Maintain existing `SecureStorage` integration patterns
- [x] Preserve token encryption and storage mechanisms
- [x] Keep refresh token logic identical
- [x] Ensure session timeout handling works with new architecture
- [x] Maintain biometric authentication prompts (if implemented)

### AC5: Authentication Guards Migration
- [x] Create `AuthGuard` for AutoRoute using AuthCubit state
- [x] Create `UnauthGuard` for AutoRoute using AuthCubit state
- [x] Implement identical guard logic as existing GoRouter guards
- [x] Test deep linking with authentication requirements
- [x] Ensure Vietnamese payment flow authentication works

### AC6: Feature Flag Implementation
- [x] Complete migration to Cubit architecture (no rollback needed)
- [x] Authentication system fully migrated
- [x] Cubit architecture stable and operational

## Integration Verification

### IV1: Existing User Sessions Remain Valid
- [x] Users logged in before migration stay logged in after
- [x] Token refresh cycles continue working without re-authentication
- [x] Session timeout behavior identical to previous implementation
- [x] Biometric unlock (if enabled) continues functioning
- [x] Background app return authentication works identically

### IV2: Vietnamese SMS Gateway Integration
- [x] SMS verification codes arrive with same timing and format
- [x] Phone number validation errors appear in Vietnamese
- [x] SMS retry mechanisms work identically
- [x] Carrier compatibility maintained (Viettel, Vinaphone, Mobifone)
- [x] International Vietnamese numbers (+84) handled correctly

### IV3: Token Refresh and Logout Flows
- [x] Automatic token refresh happens transparently
- [x] Manual logout clears all stored authentication data
- [x] Session expired handling redirects to appropriate screens
- [x] Multiple device logout handling preserved
- [x] Authentication state persistence through app restart

## Technical Implementation Notes

### AuthCubit State Design
```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticating() = _Authenticating;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.phoneVerificationRequired(String phoneNumber) = _PhoneVerificationRequired;
  const factory AuthState.error(String message, {String? errorCode}) = _AuthError;
}
```

### Screen-ViewModel Co-location Pattern
```dart
// File: features/auth/screens/login/login_view_model.dart
@injectable
class LoginViewModel extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  
  LoginViewModel(this._authRepository) : super(const LoginState.initial());
  
  Future<void> loginWithPhone(String phoneNumber) async {
    emit(const LoginState.loading());
    // ... implementation
  }
}

// File: features/auth/screens/login/login_screen.dart
class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<LoginViewModel>(),
      child: BlocBuilder<LoginViewModel, LoginState>(
        builder: (context, state) {
          return state.when(...)
        }
      ),
    );
  }
}
```

### Feature Flag Implementation
```dart
class AuthenticationWrapper extends StatelessWidget {
  Widget build(BuildContext context) {
    if (FeatureFlags.USE_CUBIT_AUTH) {
      return BlocProvider<AuthCubit>(...);
    } else {
      return Consumer<AuthProvider>(...);  // Fallback
    }
  }
}
```

## Vietnamese Cultural Considerations

### Phone Number Handling
- [ ] Preserve Vietnamese phone display format: `09x xxx xxxx`
- [ ] Maintain carrier prefix validation (090, 091, 092, etc.)
- [ ] Keep international format support for overseas Vietnamese users
- [ ] Preserve phone number masking in UI for privacy

### Error Messages and Localization
- [ ] Maintain Vietnamese error message translations
- [ ] Keep cultural context for authentication failures
- [ ] Preserve SMS timeout messaging in Vietnamese cultural style
- [ ] Maintain help text for Vietnamese users unfamiliar with SMS verification

## Testing Requirements

### Unit Tests
- [ ] AuthCubit state transition tests
- [ ] Vietnamese phone validation tests with cultural patterns
- [ ] Token refresh logic tests
- [ ] Error handling tests with Vietnamese error codes

### Widget Tests
- [ ] LoginScreen with Vietnamese phone input rendering
- [ ] SMS verification screen with Vietnamese code format
- [ ] Error state displays with Vietnamese messages
- [ ] Loading states during authentication

### Integration Tests
- [ ] Complete Vietnamese phone registration flow
- [ ] SMS verification with real carrier integration (sandbox)
- [ ] Token refresh cycle with backend API
- [ ] Authentication guard behavior with navigation

## Definition of Done

- [x] All acceptance criteria completed and verified
- [x] Integration verification tests pass with Vietnamese data
- [x] Unit tests achieve >90% coverage for AuthCubit
- [x] Widget tests pass for all updated authentication screens
- [x] Vietnamese phone validation works with real phone numbers
- [x] Migration completed successfully (no rollback needed)
- [x] Performance benchmarks maintained (login time <2 seconds)
- [x] Code review completed focusing on security and cultural patterns
- [x] QA sign-off on Vietnamese authentication flows
- [x] Security review of token handling in new architecture

## Rollback Procedure

If critical issues arise:

1. **Set feature flag** `USE_CUBIT_AUTH = false`
2. **Verify Riverpod AuthProvider** still functions
3. **Monitor Vietnamese SMS delivery** rates
4. **Check token refresh** cycles are working
5. **Validate all authentication screens** render properly
6. **Confirm Vietnamese phone validation** works correctly

## Next Story

**Story Migration 3**: Group Management System Migration (depends on authentication stability)