<!-- Powered by BMAD™ Core -->

# State Management Migration to Cubit (flutter_bloc) — Brownfield Story

## Story Title

State Management Migration to Cubit (flutter_bloc) - Brownfield Addition

## User Story

As a mobile developer,
I want lightweight, predictable Cubit state with Freezed unions
So that UI flows are easier to test and reason about.

## Story Context

### Existing System Integration

- Integrates with: Auth and Group presentation layers, DI container, services
- Technology: Flutter 3.x; current state via Riverpod providers; Freezed already present
- Follows pattern: `flutter_bloc` Cubits with `BlocProvider`, `BlocBuilder`, `BlocListener`; DI via `get_it`
- Touch points: `mobile/pubspec.yaml`, `lib/features/auth/*`, `lib/features/groups/*`, `lib/core/di/*`, `lib/main.dart`

## Acceptance Criteria

### Functional Requirements

1. Add `flutter_bloc` to dependencies.
2. Create `AuthCubit` with Freezed union states (e.g., `unauthenticated`, `codeSent`, `verifying`, `authenticated`, `failure`).
3. Create `GroupCubit` with Freezed union states for group creation/management flows.
4. Integrate Cubits with DI (`get_it`), ensuring services are injected via constructors.
5. Refactor representative screens to Bloc pattern: login, SMS verification, create group.

### Integration Requirements

6. Remove Riverpod providers only from the migrated screens; keep Riverpod elsewhere until later cleanup.
7. Ensure Cubit state transitions cover existing edge cases (timeouts, invalid codes, network errors).
8. Maintain API/service contracts; no changes to backend interactions.

### Quality Requirements

9. Add unit tests for Cubits (state transitions, error handling).
10. Add widget tests for at least one flow (e.g., login → SMS verification) asserting UI reacts to Cubit states.
11. Update documentation with examples of Cubit states and testing approach.

## Technical Notes

- Integration Approach: Introduce Cubits per-module; providers in untouched modules may temporarily coexist. Use `BlocProvider` at route scope via AutoRoute wrappers or at screen scope.
- Existing Pattern Reference: Architecture table specifies Cubit for mobile state.
- Key Constraints: Keep UI strings and behavior stable; leverage Freezed for exhaustive `when` handling.

## Definition of Done

- [ ] `flutter_bloc` added; app compiles
- [ ] `AuthCubit` and `GroupCubit` implemented and wired
- [ ] Selected screens refactored to use BlocBuilder/Listener
- [ ] Unit and widget tests added for Cubits and one end-to-end flow
- [ ] Riverpod removed from migrated screens
- [ ] Docs updated with Cubit examples

## Risk and Compatibility Check

- Primary Risk: Behavior drift during migration (e.g., edge cases not covered).
- Mitigation: Mirror existing Riverpod logic in Cubit; add transition tests; compare telemetry/logs.
- Rollback: Revert affected screens to Riverpod providers; unregister Cubits from DI.

## Validation Checklist

- [ ] Story can be completed in one development session
- [ ] Integration approach is straightforward
- [ ] Follows existing patterns exactly
- [ ] No design or architecture work required beyond state wiring

