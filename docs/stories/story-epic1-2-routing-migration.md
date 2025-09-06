<!-- Powered by BMAD™ Core -->

# Routing Migration to AutoRoute — Brownfield Story

## Story Title

Routing Migration to AutoRoute - Brownfield Addition

## User Story

As a mobile developer,
I want typed, declarative routing using AutoRoute with guards and deep links,
So that navigation is safer, testable, and easier to refactor.

## Story Context

### Existing System Integration

- Integrates with: App shell in `main.dart`, authentication flows, group flows, dialogs
- Technology: Flutter 3.x; current router `go_router` 13.x
- Follows pattern: `auto_route` with `@AutoRouter` and codegen
- Touch points: `mobile/pubspec.yaml`, `lib/core/router/app_router.dart`, `lib/core/router/router_guard.dart`, `lib/main.dart`, affected screens (login, SMS verification, group create)

## Acceptance Criteria

### Functional Requirements

1. Add `auto_route` to dependencies and `auto_route_generator` to dev dependencies.
2. Create `lib/core/router/app_router.dart` with `@AutoRouter` route tree for primary flows: splash/onboarding, login, phone registration, SMS verification, home, group creation, role management.
3. Implement an auth guard that checks authenticated state and redirects accordingly.
4. Replace `go_router` usage in `main.dart` with `MaterialApp.router` configured for AutoRoute.
5. Migrate representative flows (at minimum: login → SMS verification → home; create group) to use generated route classes and typed arguments.

### Integration Requirements

6. Preserve deep links and back stack behavior for migrated flows.
7. Ensure `Navigator`-based pop/close calls in migrated screens are compatible or refactored to AutoRoute patterns.
8. Do not change non-migrated modules; `go_router` may temporarily coexist in untouched areas if needed, but should not be used by migrated screens.

### Quality Requirements

9. Add widget tests covering one routed happy path and a guard redirect.
10. Update documentation to show new route definitions and navigation examples.
11. No new analyzer/linter errors; CI passes; app builds and runs on both platforms.

## Technical Notes

- Integration Approach: Introduce AutoRoute alongside `go_router`, migrate critical flows, then remove `go_router` in a later cleanup when all flows have moved.
- Existing Pattern Reference: Architecture table specifies AutoRoute for mobile routing.
- Key Constraints: Keep route names and paths stable for existing links; provide adapters for any imperative navigation still needed during transition.

## Definition of Done

- [ ] Dependencies added; codegen succeeds producing `app_router.gr.dart`
- [ ] App uses AutoRoute in `main.dart` with guard(s) wired
- [ ] Login/SMS/Home and Create Group flows navigate via AutoRoute
- [ ] Deep link and back stack parity verified for migrated flows
- [ ] Widget tests added for routes and guard
- [ ] Docs updated with examples

## Risk and Compatibility Check

- Primary Risk: Navigation regressions (unexpected back stack, guard loops).
- Mitigation: Guard logic unit-tested; manual exploratory testing scripts; keep scope to specific flows.
- Rollback: Revert `main.dart` changes and route definitions; retain `go_router` config.

## Validation Checklist

- [ ] Story can be completed in one development session
- [ ] Integration approach is straightforward
- [ ] Follows existing patterns exactly
- [ ] No database or API changes required

