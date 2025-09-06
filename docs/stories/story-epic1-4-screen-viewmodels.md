<!-- Powered by BMAD™ Core -->

# Screen ViewModels (Cubit-based) — Brownfield Story

## Story Title

Introduce Screen ViewModels (Cubit-based) - Brownfield Addition

## User Story

As a mobile developer,
I want a ViewModel per screen implemented as a Cubit with Freezed state,
So that each screen has isolated, testable state and clear input/output contracts.

## Story Context

### Existing System Integration

- Integrates with: Screens in Auth and Groups features; DI container; services; AutoRoute
- Technology: Flutter 3.x; `flutter_bloc` Cubits; Freezed; `get_it` + `injectable`; AutoRoute
- Follows pattern: One Cubit per screen acting as the ViewModel; exposes intent methods; immutable state variants
- Touch points: `lib/features/**/screens/*_screen.dart`, `lib/features/**/cubit/*_cubit.dart`, `lib/core/di/*`

## Acceptance Criteria

### Functional Requirements

1. Define a ViewModel (Cubit) per targeted screen, starting with: `LoginScreen`, `SmsVerificationScreen`, `CreateGroupScreen`.
2. Each ViewModel exposes explicit intent methods (e.g., `submitPhone()`, `verifyCode()`, `createGroup()`), no direct service calls from Widgets.
3. Each ViewModel uses Freezed state sealed classes capturing loading/success/error and data payloads.
4. Wire ViewModels via DI and provide using `BlocProvider` at route or screen scope.
5. Widgets observe state using `BlocBuilder`/`BlocListener` and render purely from state.

### Integration Requirements

6. Keep business logic inside ViewModels; Widgets only dispatch intents and render.
7. Maintain parity with current flows and validation; no behavioral regressions.
8. Ensure ViewModels consume injected services (Auth, API, Storage) via constructors.

### Quality Requirements

9. Add unit tests for each ViewModel intent covering happy/error paths.
10. Add a widget test per screen asserting UI binds to state updates.
11. Update documentation to include ViewModel pattern guidance and examples.

## Technical Notes

- Integration Approach: Incremental per-screen adoption; screens can temporarily remain on Riverpod until migrated.
- Pattern Reference: MVVM-like with Cubit as ViewModel; state represented by Freezed unions; DI for dependencies.
- Constraints: No direct Navigator calls in ViewModel; navigation handled by UI via AutoRoute in response to states.

## Definition of Done

- [ ] ViewModels created for targeted screens and injected via DI
- [ ] Screens refactored to dispatch intents and render from state
- [ ] Unit and widget tests added
- [ ] Docs updated with ViewModel guidance

## Risk and Compatibility Check

- Primary Risk: Duplicate logic between Cubits and residual Riverpod providers during transition.
- Mitigation: Remove provider logic as soon as the screen migrates; centralize business rules in ViewModel.
- Rollback: Revert screen to previous provider; unregister Cubit from DI.

## Validation Checklist

- [ ] Story can be completed in one development session
- [ ] Integration approach is straightforward
- [ ] Follows existing patterns exactly
- [ ] No API or data model changes required

