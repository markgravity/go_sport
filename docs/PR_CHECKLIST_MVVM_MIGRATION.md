# PR Checklist — MVVM Migration (Mobile)

Use this checklist when submitting PRs related to the MVVM migration (Cubit ViewModels, AutoRoute, get_it/injectable).

## Scope Validation
- [ ] PR is limited to one story/module (DI / Routing / State / ViewModels)
- [ ] No unrelated refactors or formatting changes

## Dependencies & Codegen
- [ ] `pubspec.yaml` updated only when necessary (auto_route/flutter_bloc/get_it/injectable)
- [ ] Code generation (`build_runner`) executed and generated files included/ignored per policy

## Dependency Injection
- [ ] `configureDependencies()` invoked in `main.dart`
- [ ] Services/Cubits registered with correct lifetimes (`@lazySingleton`, `@singleton`)
- [ ] No global singletons or service location in Widgets

## Routing (AutoRoute)
- [ ] Route tree defined with typed arguments
- [ ] Guards implemented and tested for auth flows
- [ ] Deep links and back stack parity verified for migrated flows

## State (Cubit ViewModels)
- [ ] One Cubit (ViewModel) per screen updated in this PR
- [ ] Freezed union state used; UI renders from state only
- [ ] Widgets dispatch intents only; no business logic in Widgets

## Testing
- [ ] Unit tests for Cubit transitions and error handling
- [ ] Widget tests for at least one routed flow/guard
- [ ] DI resolution test(s) for injected services/Cubits

## Documentation
- [ ] `docs/architecture.md` updated if patterns/wiring changed
- [ ] Story document acceptance criteria met

## Compatibility & Rollback
- [ ] No breaking API/storage changes
- [ ] Feature parity maintained for migrated screens
- [ ] Clear rollback plan documented in PR description


