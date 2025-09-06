# Story Migration 5: Payment System Migration and Architecture Cleanup

**Epic**: Riverpod to Cubit Architecture Migration  
**Story ID**: MIGRATION-5  
**Estimated Effort**: 1-2 sprints  
**Priority**: Critical  
**Dependencies**: MIGRATION-4 (Attendance and Real-time Features)  

## User Story

As a Vietnamese sports group member,  
I want payment splitting to work identically with all Vietnamese payment methods,  
So that cost coordination remains transparent and reliable while completing the architectural migration.

## Story Context

**Migration Phase**: Final Migration and Cleanup (Week 9-10 of 10-week migration)  
**Risk Level**: Critical (affects Vietnamese payment gateway integrations)  
**Rollback Strategy**: Feature flag reversion with payment system isolation

## Acceptance Criteria

### AC1: PaymentSession Provider to PaymentSessionCubit Migration
- [ ] Create `PaymentSessionCubit` in `features/payments/presentation/viewmodels/payment_session_cubit.dart`
- [ ] Create `PaymentSessionState` using Freezed with states: `initial, creating, active, completed, error`
- [ ] Migrate payment session creation based on final attendance headcount
- [ ] Preserve Vietnamese currency formatting (₫) and thousand separators
- [ ] Maintain cost splitting logic with Vietnamese rounding rules
- [ ] Register PaymentSessionCubit in GetIt container

### AC2: QrPayment Provider to QrPaymentCubit Migration
- [ ] Create `QrPaymentCubit` in `features/payments/presentation/viewmodels/qr_payment_cubit.dart`
- [ ] Create `QrPaymentState` using Freezed for QR payment management
- [ ] Migrate QR code generation for Vietnamese payment gateways
- [ ] Preserve Momo QR code format and payment flow
- [ ] Maintain VietQR integration with Vietnamese bank compatibility
- [ ] Keep ZaloPay QR scanning and payment verification

### AC3: Vietnamese Payment Gateway Integration Preservation
- [ ] Ensure **Momo SDK** integration works identically with new architecture
- [ ] Maintain **VietQR API** calls and Vietnamese bank account validation
- [ ] Preserve **ZaloPay SDK** functionality and payment callbacks
- [ ] Keep Vietnamese payment method selection UI identical
- [ ] Maintain payment gateway error handling in Vietnamese
- [ ] Preserve payment success/failure notifications in Vietnamese

### AC4: Screen Updates to BlocBuilder Patterns
- [ ] Update `PaymentSessionScreen` to use `BlocBuilder<PaymentSessionCubit, PaymentSessionState>`
- [ ] Update `QrPaymentScreen` to use `BlocBuilder<QrPaymentCubit, QrPaymentState>`
- [ ] Replace all payment-related `Consumer` patterns with `BlocBuilder`
- [ ] Maintain identical Vietnamese payment UI rendering
- [ ] Preserve Vietnamese payment method icons and branding

### AC5: Vietnamese Currency and Payment Patterns
- [ ] Ensure Vietnamese Dong (₫) formatting works identically
- [ ] Preserve Vietnamese payment splitting cultural patterns
- [ ] Maintain Vietnamese payment amount validation (minimum/maximum)
- [ ] Keep Vietnamese payment description formatting
- [ ] Preserve Vietnamese receipt generation and sharing
- [ ] Maintain Vietnamese payment history display patterns

### AC6: Complete Riverpod Architecture Removal
- [ ] Remove all Riverpod dependencies from pubspec.yaml
- [ ] Delete all Provider classes and related files
- [ ] Remove ProviderScope from main.dart
- [ ] Complete migration to GetIt dependency injection
- [ ] Remove GoRouter completely and use only AutoRoute
- [ ] Clean up all remaining Riverpod imports and references

### AC7: Performance Optimization and Testing Updates
- [ ] Optimize Cubit memory usage compared to previous Riverpod implementation
- [ ] Update all existing tests to use BlocTest instead of ProviderContainer
- [ ] Ensure code generation build times are acceptable (<30 seconds)
- [ ] Validate app startup time hasn't degraded with new architecture
- [ ] Confirm hot reload performance maintained during development

## Integration Verification

### IV1: All Vietnamese Payment Gateway Integrations Function Without Changes
- [ ] Momo payments work identically to current implementation
- [ ] VietQR generation and bank transfers function correctly
- [ ] ZaloPay integration maintains existing user experience
- [ ] Payment gateway callbacks and webhooks processed correctly
- [ ] Vietnamese bank account validation works for all major banks (Vietcombank, BIDV, Techcombank, etc.)

### IV2: QR Code Payment Flows Maintain Existing Security and UX Patterns
- [ ] QR code generation speed identical to current system
- [ ] QR code scanning accuracy maintained across Vietnamese payment apps
- [ ] Payment amount verification displays correctly in Vietnamese Dong
- [ ] Payment confirmation flows preserve Vietnamese user experience
- [ ] Security patterns for payment data handling unchanged

### IV3: Vietnamese Currency Formatting and Cultural Payment Patterns Preserved
- [ ] Currency displays show proper Vietnamese thousand separators (123.456 ₫)
- [ ] Payment splitting respects Vietnamese cultural fairness patterns
- [ ] Vietnamese payment descriptions and notes format correctly
- [ ] Payment history displays Vietnamese dates and amounts properly
- [ ] Vietnamese receipt sharing maintains cultural messaging patterns

## Technical Implementation Notes

### PaymentSessionState Design Pattern
```dart
@freezed
class PaymentSessionState with _$PaymentSessionState {
  const factory PaymentSessionState.initial() = _Initial;
  const factory PaymentSessionState.creating() = _Creating;
  const factory PaymentSessionState.active({
    required PaymentSession session,
    required List<PaymentParticipant> participants,
    required double totalAmount,
  }) = _Active;
  const factory PaymentSessionState.completed(PaymentResult result) = _Completed;
  const factory PaymentSessionState.error(String vietnameseMessage) = _Error;
}
```

### Vietnamese Payment Gateway Integration
```dart
class QrPaymentCubit extends Cubit<QrPaymentState> {
  Future<void> generateMomoQR(double amount, String description) async {
    emit(const QrPaymentState.generating());
    try {
      final qrData = await _momoService.generateQR(
        amount: _formatVietnameseCurrency(amount),
        description: _sanitizeVietnameseText(description),
        callbackUrl: AppConfig.momoCallbackUrl,
      );
      emit(QrPaymentState.generated(qrData));
    } catch (e) {
      emit(QrPaymentState.error(_translatePaymentError(e, 'vi')));
    }
  }
}
```

### Architecture Cleanup Pattern
```dart
// main.dart - Final clean architecture
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Only GetIt DI (Riverpod completely removed)
  await configureDependencies();
  
  runApp(MyApp()); // No ProviderScope wrapper needed
}

class MyApp extends StatelessWidget {
  @override  
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Only AutoRoute (GoRouter completely removed)
      routerConfig: GetIt.instance<AppRouter>().config(),
      theme: VietnameseAppTheme.lightTheme,
    );
  }
}
```

## Vietnamese Payment Cultural Considerations

### Payment Method Preferences
- [ ] Maintain Vietnamese user preference order: Momo → VietQR → ZaloPay → Cash
- [ ] Preserve Vietnamese payment amount cultural limits and expectations
- [ ] Keep Vietnamese payment timing patterns (immediate vs scheduled)
- [ ] Maintain Vietnamese group payment etiquette in UI messaging

### Currency and Amount Handling
- [ ] Preserve Vietnamese Dong amount validation (no decimal places for small amounts)
- [ ] Maintain Vietnamese cultural rounding preferences for group payments
- [ ] Keep Vietnamese payment description patterns and language
- [ ] Preserve Vietnamese receipt and payment proof formatting

### Payment Security and Trust
- [ ] Maintain Vietnamese user trust patterns in payment confirmation flows
- [ ] Preserve Vietnamese security expectations for payment data handling  
- [ ] Keep Vietnamese payment dispute resolution patterns
- [ ] Maintain Vietnamese payment verification and proof sharing

## Vietnamese Payment Gateway Testing

### Momo Integration Testing
- [ ] Test with real Momo sandbox environment
- [ ] Validate Vietnamese phone number linking with Momo accounts
- [ ] Test QR code generation and scanning with Momo app
- [ ] Verify payment callbacks and success/failure handling
- [ ] Test with Vietnamese Momo account types (personal/business)

### VietQR Integration Testing
- [ ] Test with major Vietnamese banks (Vietcombank, BIDV, Techcombank)
- [ ] Validate QR code format compliance with VietQR standards
- [ ] Test bank account validation with Vietnamese account patterns
- [ ] Verify transfer amount limits and Vietnamese banking rules
- [ ] Test QR scanning with Vietnamese banking apps

### ZaloPay Integration Testing
- [ ] Test with ZaloPay sandbox environment
- [ ] Validate Vietnamese user account integration
- [ ] Test payment flow with ZaloPay app integration
- [ ] Verify webhook callbacks and payment status updates
- [ ] Test with Vietnamese ZaloPay wallet funding methods

## Performance and Cleanup Validation

### Architecture Performance
- [ ] App startup time ≤ previous Riverpod implementation
- [ ] Memory usage during payment flows ≤ 15% increase from baseline
- [ ] Payment QR generation speed ≤ 2 seconds
- [ ] Hot reload development speed maintained
- [ ] Build time with code generation ≤ 30 seconds

### Code Cleanup Verification
- [ ] Zero remaining Riverpod imports in codebase
- [ ] All Provider classes removed from project
- [ ] GoRouter references completely eliminated
- [ ] GetIt registration covers all required services
- [ ] AutoRoute handles all navigation requirements
- [ ] No dead code or unused dependencies remain

## Testing Requirements

### Unit Tests
- [ ] PaymentSessionCubit with Vietnamese currency calculations
- [ ] QrPaymentCubit with Vietnamese payment gateway mocks
- [ ] Vietnamese currency formatting and validation logic
- [ ] Payment splitting algorithms with Vietnamese cultural patterns

### Widget Tests
- [ ] PaymentSessionScreen with Vietnamese payment UI elements
- [ ] QrPaymentScreen with Vietnamese QR display and instructions
- [ ] Vietnamese currency input and display components
- [ ] Payment method selection with Vietnamese preferences

### Integration Tests
- [ ] Complete payment flow from attendance to QR generation
- [ ] Vietnamese payment gateway integration (sandbox)
- [ ] Payment session creation with real Vietnamese group data
- [ ] QR code generation and validation with Vietnamese amounts

### End-to-End Tests
- [ ] Full attendance → payment → QR → completion flow
- [ ] Multi-member payment splitting with Vietnamese currency
- [ ] Payment verification with Vietnamese banking integration
- [ ] Cross-platform payment consistency (iOS/Android)

## Definition of Done

- [ ] All acceptance criteria completed with Vietnamese payment gateway validation
- [ ] Integration verification tests pass with real Vietnamese payment data
- [ ] Unit tests achieve >90% coverage for payment-related Cubits
- [ ] All Vietnamese payment methods tested in sandbox environments
- [ ] Performance benchmarks maintained or improved vs Riverpod implementation
- [ ] Complete Riverpod architecture removal verified
- [ ] AutoRoute navigation completely replaces GoRouter
- [ ] Vietnamese sports group leaders approve payment functionality
- [ ] Payment security review completed for new architecture
- [ ] Code review focused on Vietnamese payment gateway compliance
- [ ] QA sign-off on Vietnamese payment coordination workflows

## Rollback Procedure (Emergency Only)

If critical payment issues arise:

1. **EMERGENCY STOP**: Disable payment features immediately
2. **Isolate payment system**: Use feature flags to bypass payment flows
3. **Validate attendance tracking**: Ensure attendance still works without payments
4. **Restore from backup**: Revert to previous working commit if necessary
5. **Contact payment gateways**: Notify Vietnamese payment providers of any issues
6. **Communicate with users**: Inform Vietnamese groups of temporary payment unavailability

## Vietnamese Payment Validation Checklist

- [ ] Test with real Vietnamese Momo accounts (personal and business)
- [ ] Validate with major Vietnamese bank accounts through VietQR
- [ ] Verify ZaloPay integration with Vietnamese wallet funding
- [ ] Test payment amounts typical for Vietnamese sports groups (50k-200k VND)
- [ ] Validate Vietnamese payment messaging and cultural patterns
- [ ] Confirm Vietnamese receipt generation and sharing works correctly

## Migration Completion Celebration 🎉

Upon successful completion of this final story:

- [ ] **10-week migration successfully completed**
- [ ] **Complete architectural modernization achieved**
- [ ] **All Vietnamese cultural features preserved**
- [ ] **Zero disruption to active sports groups**
- [ ] **Enhanced maintainability and developer experience**

## Next Steps (Post-Migration)

1. **Performance monitoring** of new architecture in production
2. **Developer team training** on Cubit + AutoRoute patterns
3. **Documentation updates** reflecting new architecture
4. **Vietnamese user feedback collection** on any subtle UX changes
5. **Future feature development** using new architectural patterns