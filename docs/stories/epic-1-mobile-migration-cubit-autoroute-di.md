<!-- Powered by BMAD™ Core -->

# Mobile Migration to Cubit + AutoRoute + get_it/injectable — Brownfield Enhancement

## Epic Goal

Align the mobile app with the intended architecture to enable typed navigation, explicit dependency injection, and predictable, testable state management, while maintaining feature parity and minimizing regression risk.

## Epic Description

### Existing System Context

- Current relevant functionality: Mobile app implements auth (phone/SMS), group creation/management, and various flows using Riverpod for state and go_router for navigation; services are constructed ad hoc; Freezed and codegen are already in use.
- Technology stack: Flutter 3.x; `flutter_riverpod` 2.x; `go_router` 13.x; Freezed; Dio; Hive; Firebase Auth/Messaging.
- Integration points: Auth flows (`login_screen.dart`, `sms_verification_screen.dart`), group flows (`create_group_screen.dart`, related widgets/services), global navigation in `main.dart`, service layer (e.g., `PhoneAuthService`, `FirebaseAuthService`), and UI widgets using Riverpod providers.

### Enhancement Details

- What's being added/changed: Introduce `get_it` + `injectable` for DI; adopt `auto_route` for typed navigation; migrate presentation state to Cubit via `flutter_bloc`.
- How it integrates:
  - DI: Add `lib/core/di` modules with `@module` and `@injectable` annotations; generate container via `injectable_generator`; initialize DI in `main.dart` before `runApp`; wire services (Dio, Hive, Firebase, repositories) through DI.
  - Routing: Add `lib/core/router/app_router.dart` with `@AutoRouter` definitions; generate `router.gr.dart`; add auth guards; replace `go_router` calls with typed `AutoRoute` APIs and deep-link support.
  - State: Add Cubits (e.g., `AuthCubit`, `GroupCubit`) with Freezed union states; refactor UI to `BlocProvider/BlocBuilder/BlocListener`; inject Cubits via DI; progressively replace Riverpod providers.
- Success criteria: App builds and runs; primary flows (onboarding/login, SMS verification, group creation/role management) function via AutoRoute and Cubit; services resolved through DI; `go_router` and Riverpod references removed in targeted modules; docs updated to match.

## Stories

1. DI Foundation with get_it + injectable  
   - Add packages and codegen; define modules and register services; initialize DI in `main.dart`; convert key services (auth/network/storage) to DI; add one mockable injection test.

2. Routing Migration to AutoRoute  
   - Add packages and codegen; define route tree and guards; migrate main navigation flows to AutoRoute; ensure deep links and back stack parity; remove `go_router` from migrated areas.

3. State Management Migration to Cubit (flutter_bloc)  
   - Add packages; implement core Cubits (`AuthCubit`, `GroupCubit`), refactor representative screens to Bloc; integrate with DI; remove Riverpod in those areas; add unit/widget tests for Cubits and flows.

4. Screen ViewModels (Cubit-based)  
   - Introduce a ViewModel (Cubit) per screen; move business logic from Widgets to ViewModels with Freezed states; inject via DI; refactor `Login`, `SMS Verification`, and `Create Group` screens first; add unit and widget tests.

## Compatibility Requirements

- Existing APIs and backend contracts remain unchanged.
- Any data/storage changes are additive and backward compatible.
- UI/UX aligns with current patterns; no disruptive navigation changes.
- Performance remains at or better than current levels.

## Risk Mitigation

- Primary Risk: Wide-scope refactor causing regressions across auth/navigation and group flows.
- Mitigation: Staged migration by module with feature flags, interoperability wrappers during transition, and targeted test coverage on migrated areas.
- Rollback Plan: Keep changes per module in isolated commits/PRs; retain old navigation/state behind flags until verified; revert at module boundary if needed.

## Definition of Done

- All three stories completed with acceptance criteria met.
- Primary flows validated end-to-end on both platforms.
- Tests added/updated for DI initialization, routed flows, and Cubits.
- `go_router` and Riverpod removed from migrated modules; dependency list reflects new stack.
- Architecture docs updated to reflect Cubit + AutoRoute + get_it/injectable.

## Story Manager Handoff

"Please develop detailed user stories for this brownfield epic. Key considerations:

- This is an enhancement to an existing system running Flutter with Riverpod and go_router today, moving to Cubit, AutoRoute, and get_it/injectable.
- Integration points: Auth and onboarding, group creation/management, shared navigation shell, service layer for auth/network/storage.
- Existing patterns to follow: DI modules (`get_it` + `injectable`), typed AutoRoute with guards, Cubit + Freezed union states.
- Critical compatibility requirements: Preserve deep-link behavior, back stack parity, and feature parity across flows; avoid breaking API/storage contracts.
- Each story must include verification that existing functionality remains intact.

The epic should maintain system integrity while delivering the target architecture alignment."


