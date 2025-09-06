<!-- Powered by BMAD™ Core -->

# DI Foundation with get_it + injectable — Brownfield Story

## Story Title

DI Foundation with get_it + injectable - Brownfield Addition

## User Story

As a mobile developer,
I want explicit, typed dependency injection using get_it + injectable,
So that services and state objects are easy to compose, test, and evolve safely.

## Story Context

### Existing System Integration

- Integrates with: Service layer (auth, networking, storage), app bootstrap in `main.dart`
- Technology: Flutter 3.x; current state via Riverpod; codegen via build_runner; Freezed/JSON; Dio; Firebase; Hive
- Follows pattern: Compile-time DI with `get_it` + `injectable`
- Touch points: `mobile/pubspec.yaml`, `lib/core/di/*`, `lib/main.dart`, service constructors (e.g., `FirebaseAuthService`, `PhoneAuthService`, `ApiClient`)

## Acceptance Criteria

### Functional Requirements

1. Add `get_it` and `injectable` to runtime dependencies; add `injectable_generator` to dev dependencies in `mobile/pubspec.yaml`.
2. Create DI bootstrap: `lib/core/di/injection.dart` exposing `Future<void> configureDependencies()` with environment support (`dev`, `prod`).
3. Provide modules with `@module` for: `Dio`, `FirebaseAuth`, `FirebaseMessaging`, `HiveInterface`/boxes, and any app-wide singletons (e.g., `SharedPreferences` if used later).
4. Annotate and register app services (`@lazySingleton`/`@singleton`) for: API client, auth services, repositories.
5. Initialize DI in `main.dart` before `runApp`, using the correct environment.
6. Demonstrate one service resolved from DI in production code (no global singletons).

### Integration Requirements

7. Existing functionality continues to work unchanged (no user-visible differences).
8. Riverpod providers may remain temporarily; they should resolve injected services rather than construct their own copies where feasible in the touched module.
9. Code generation wired: `build_runner` generates `injection.config.dart` without errors; checked into source or re-generated in CI (follow project policy).

### Quality Requirements

10. Add at least one unit test proving DI resolution and mock override for a service (e.g., `ApiClient` or `FirebaseAuthService`).
11. Update documentation: `docs/architecture.md` DI section references `get_it + injectable` usage and bootstrap points.
12. No new analyzer/linter errors; CI passes.

## Technical Notes

- Integration Approach: Introduce DI as a non-breaking layer first; keep Riverpod for state until a later story. Providers can read from `getIt<T>()` when needed.
- Existing Pattern Reference: Architecture table already specifies `get_it + injectable` for DI.
- Key Constraints: Keep constructors minimal; prefer interface-driven design for testability; avoid runtime reflection; prefer compile-time generation.

## Definition of Done

- [ ] Dependencies added and locked; `flutter pub get` succeeds
- [ ] `configureDependencies()` implemented and invoked in `main.dart`
- [ ] Services registered and retrieved via DI in at least one production path
- [ ] Codegen runs clean; generated file present/ignored per policy
- [ ] Unit test verifies DI and mocks
- [ ] Documentation updated where applicable

## Risk and Compatibility Check

- Primary Risk: Misconfigured singletons leading to duplicate instances or lifecycle issues.
- Mitigation: Use `@lazySingleton` for services; centralize creation in modules; add a smoke test to validate a single instance per type.
- Rollback: Remove DI initialization and service annotations; revert `pubspec.yaml` changes.

## Validation Checklist

- [ ] Story can be completed in one development session
- [ ] Integration approach is straightforward
- [ ] Follows existing patterns exactly
- [ ] No design or architecture work required beyond DI wiring

