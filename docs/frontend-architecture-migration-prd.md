# Go Sport App Frontend Architecture Migration PRD
*Riverpod to Cubit Architecture Enhancement*

## Intro Project Analysis and Context

### Existing Project Overview

**Analysis Source**: IDE-based analysis with comprehensive existing documentation including:
- Complete PRD v1.0 (Vietnamese sports coordination platform)
- Architecture document v1.0 (Laravel backend + Flutter frontend)
- Frontend Architecture document v2.0 (current: Riverpod + GoRouter)
- Comprehensive technical documentation suite

**Current Project State**:  
Go Sport App is a **Vietnamese sports group coordination platform** enabling group leaders to automate attendance tracking and payment coordination. The project currently operates with Flutter mobile frontend using **Riverpod + GoRouter architecture** and Laravel backend API. Core functionality includes SMS-based authentication, role-based group management (Trưởng nhóm, Phó nhóm, Thành viên, Khách), real-time attendance tracking, and Vietnamese payment gateway integration (Momo, VietQR, ZaloPay).

### Available Documentation Analysis

✅ **Available Documentation:**
- [x] Tech Stack Documentation (architecture.md - Laravel/Flutter stack)
- [x] Source Tree/Architecture (ui-architecture.md v2.0 - complete frontend architecture) 
- [x] Coding Standards (detailed in ui-architecture.md)
- [x] API Documentation (API_DOCUMENTATION.md)
- [x] External API Documentation (Vietnamese payment gateways documented)
- [x] UX/UI Guidelines (Vietnamese cultural patterns in ui-architecture.md)
- [x] Technical Debt Documentation (noted in architecture documents)
- [x] **Other**: Vietnamese data examples, team onboarding, development setup

**Documentation Status**: **Comprehensive** - No additional document-project analysis needed.

### Enhancement Scope Definition

**Enhancement Type**: 
- [x] **Technology Stack Upgrade** (Primary)
- [x] **Major Feature Modification** (State management overhaul)
- [x] **UI/UX Overhaul** (Navigation system change)

**Enhancement Description**:  
Migrate the entire Flutter frontend from **Riverpod + GoRouter architecture** to **Cubit + AutoRoute + GetIt + MVVM + Freezed architecture**. This comprehensive migration involves replacing state management (Riverpod→Cubit), navigation (GoRouter→AutoRoute), dependency injection (Riverpod DI→GetIt), and implementing clean MVVM patterns throughout all features while maintaining 100% compatibility with existing Laravel backend APIs and preserving all Vietnamese cultural integrations.

**Impact Assessment**:
- [x] **Major Impact** (architectural changes required)
- Complete state management system replacement
- All screens and widgets require architectural updates
- Navigation system complete replacement
- Dependency injection system overhaul

### Goals and Background Context

**Goals**:
- Simplify state management complexity by moving from Riverpod's reactive patterns to Cubit's imperative approach
- Improve type safety and developer experience with AutoRoute vs GoRouter
- Enhance dependency injection clarity and explicit service management through GetIt
- Implement clean MVVM architecture patterns for better maintainability and testing
- Maintain 100% compatibility with existing Vietnamese features and Laravel backend integration
- Enable easier onboarding for Vietnamese developers familiar with imperative state management

**Background Context**:

The current Riverpod + GoRouter architecture, while functional, presents complexity challenges for the Vietnamese development team. Riverpod's reactive patterns require deep understanding of provider composition and can be difficult to debug in attendance notification flows. GoRouter lacks the type safety needed for the complex navigation patterns in multi-group workflows. The migration to Cubit + AutoRoute + GetIt addresses these pain points while maintaining all existing functionality including Vietnamese phone validation, cultural UI patterns, payment gateway integrations, and role-based permission systems.

Based on your existing ui-architecture.md analysis, this migration is already **well-planned with a 10-week roadmap** spanning 5 phases from foundation setup through complete cleanup. The enhancement is critical for long-term maintainability as the Vietnamese sports coordination features become more complex.

### Change Log

| Change | Date | Version | Description | Author |
|--------|------|---------|-------------|--------|
| Initial PRD | 2025-09-06 | v1.0 | Frontend architecture migration PRD creation | John (PM) |

## Requirements

### Functional

**FR1**: The migration shall replace all Riverpod providers with equivalent Cubit implementations while maintaining identical state management behavior for attendance tracking, authentication flows, and group management features.

**FR2**: The system shall migrate all GoRouter navigation to AutoRoute with type-safe route definitions, preserving existing navigation patterns including deep links for attendance requests and Vietnamese payment flows.

**FR3**: All existing Vietnamese cultural UI components (VietnamesePhoneInput, RoleBadge, currency formatting) shall be preserved with identical functionality using the new Cubit + AutoRoute architecture.

**FR4**: The migration shall implement GetIt dependency injection to replace Riverpod's provider dependency system while maintaining the same service registration and lifecycle management.

**FR5**: All authentication flows (SMS verification, phone registration, session management) shall function identically in the new architecture with preserved Vietnamese phone validation and secure token storage.

**FR6**: Group management features (creation, role assignment, member management) shall maintain exact functionality with new Cubit state management replacing existing Riverpod providers.

**FR7**: Real-time attendance tracking and notifications shall continue working with identical user experience while using Cubit for state management instead of Riverpod reactive patterns.

**FR8**: Vietnamese payment gateway integrations (Momo, VietQR, ZaloPay) shall remain fully functional with new architecture while preserving QR code generation and payment tracking features.

**FR9**: The migration shall implement Freezed for all state classes and data models to ensure immutability and proper code generation in the new architecture.

**FR10**: All screens shall be updated to use BlocBuilder/BlocListener patterns instead of Consumer/Provider patterns while maintaining identical UI behavior and Vietnamese localization.

### Non Functional

**NFR1**: The migration must maintain existing performance characteristics and not exceed current memory usage by more than 15% during state management operations.

**NFR2**: All Vietnamese text rendering, cultural patterns, and accessibility features must perform identically with the new architecture.

**NFR3**: The migration shall be completed in incremental phases allowing the app to remain functional throughout the 10-week migration period.

**NFR4**: Build times and hot reload performance must not degrade by more than 10% with the new architecture and code generation requirements.

**NFR5**: The new architecture must support the same Vietnamese timezone handling (UTC+7) and cultural date formatting without performance impact.

**NFR6**: Testing coverage must be maintained at current levels with updated mock patterns for Cubit testing instead of Riverpod provider testing.

**NFR7**: Code generation time for Freezed classes and AutoRoute definitions must not exceed 30 seconds during development builds.

### Compatibility Requirements

**CR1**: **Existing API Compatibility**: All Laravel backend API calls, authentication headers, and data formatting must remain unchanged. The migration is frontend-only and cannot affect backend integration.

**CR2**: **Database Schema Compatibility**: Local storage using Hive and secure storage for Vietnamese user data must remain compatible with existing data schemas and encryption patterns.

**CR3**: **UI/UX Consistency**: All Vietnamese cultural UI patterns, Material 3 theming, sport icons, and role-based color coding must render identically in the new architecture.

**CR4**: **Integration Compatibility**: Firebase notifications, Vietnamese SMS gateways, payment gateway SDKs, and deep linking must function without any changes to their integration patterns.

## Technical Constraints and Integration Requirements

### Existing Technology Stack

**Languages**: Dart 3.35.2, PHP 8.2+  
**Frameworks**: Flutter 3.35.2, Laravel 10+  
**Database**: MySQL (production), Hive (local caching)  
**Infrastructure**: Laravel backend API, Firebase (notifications), Vietnamese SMS gateways  
**External Dependencies**: Vietnamese payment SDKs (Momo, VietQR, ZaloPay), Google Fonts (Nunito)

### Integration Approach

**Database Integration Strategy**: Maintain existing Hive local storage patterns and MySQL API integration through repository pattern. New Cubit architecture will use identical data models with Freezed generation.

**API Integration Strategy**: Zero changes to Laravel API endpoints. New Cubit architecture will use same Dio HTTP client configuration with identical authentication interceptors and Vietnamese error handling.

**Frontend Integration Strategy**: Incremental migration using coexistence patterns where Riverpod and Cubit can temporarily coexist during 10-week migration phases. AutoRoute will be implemented alongside GoRouter until complete replacement.

**Testing Integration Strategy**: Update existing widget tests to use BlocTest instead of ProviderContainer. Maintain same Vietnamese test data and cultural pattern validation.

### Code Organization and Standards

**File Structure Approach**: Follow established MVVM pattern with features folder containing data/domain/presentation layers. **IMPORTANT**: Each screen should have its dedicated ViewModel (Cubit) placed in the same folder as the screen for better organization and maintainability.

**Screen-ViewModel Co-location Pattern**:
```
features/auth/screens/
├── login/
│   ├── login_screen.dart
│   ├── login_view_model.dart (AuthCubit)
│   └── login_state.dart (Freezed state)
├── forgot_password/
│   ├── forgot_password_screen.dart
│   ├── forgot_password_view_model.dart (ForgotPasswordCubit)
│   └── forgot_password_state.dart (Freezed state)
└── phone_registration/
    ├── phone_registration_screen.dart
    ├── phone_registration_view_model.dart (PhoneRegistrationCubit)
    └── phone_registration_state.dart (Freezed state)
```

**Naming Conventions**: Maintain existing Vietnamese cultural naming patterns. Cubit classes: `{Feature}Cubit`, State classes: `{Feature}State`, Screen classes: `{Feature}Screen`. ViewModels should be named `{screen_name}_view_model.dart` and contain the appropriate Cubit implementation.

**Coding Standards**: Preserve existing Vietnamese code patterns, comments, and cultural UI component standards. All new Cubit code follows established Flutter lint rules.

**Documentation Standards**: Update existing component documentation to reflect Cubit patterns while maintaining Vietnamese development team onboarding materials.

### Deployment and Operations

**Build Process Integration**: Add build_runner to existing CI/CD for Freezed and AutoRoute code generation. Maintain existing Flutter build commands with new --dart-define configurations.

**Deployment Strategy**: Incremental feature flagging during migration allows production deployment of individual migrated features without full cutover.

**Monitoring and Logging**: Preserve existing crash reporting and analytics. Update state tracking to monitor Cubit state transitions instead of Riverpod provider changes.

**Configuration Management**: Maintain existing environment configuration patterns. New GetIt service registration follows established injectable patterns.

### Risk Assessment and Mitigation

**Technical Risks**: State management complexity during coexistence period, code generation build failures, AutoRoute type safety integration with existing deep links

**Integration Risks**: Vietnamese payment gateway compatibility during navigation changes, SMS authentication flow disruption, cultural UI component regression

**Deployment Risks**: Build time increases due to code generation, hot reload performance during development, production rollback complexity during migration phases

**Mitigation Strategies**: Comprehensive feature flagging, incremental rollout per Vietnamese sports season timing, extensive automated testing of payment flows, parallel development environment for testing

## Epic and Story Structure

**Epic Structure Decision**: Single comprehensive epic with sequential story implementation based on existing 10-week migration roadmap to minimize integration complexity and risk to active Vietnamese sports groups.

## Epic 1: Riverpod to Cubit Architecture Migration

**Epic Goal**: Completely migrate Go Sport App frontend from Riverpod + GoRouter to Cubit + AutoRoute + GetIt + MVVM architecture while maintaining 100% compatibility with Vietnamese cultural features, payment integrations, and Laravel backend APIs.

**Integration Requirements**: Preserve all Vietnamese phone validation, cultural UI patterns, payment gateway flows, role-based permissions, SMS authentication, and real-time attendance tracking functionality during architectural transition.

### Story 1.1: Foundation Setup and Dependency Migration

As a Vietnamese sports app developer,  
I want the new Cubit architecture foundation established,  
so that I can begin incremental feature migration safely.

**Acceptance Criteria**:
1. Flutter Bloc, GetIt, Injectable, AutoRoute, Freezed dependencies added to pubspec.yaml
2. GetIt dependency injection container configured with existing service patterns
3. Base Cubit classes and Freezed state templates created
4. AutoRoute configuration initialized alongside existing GoRouter
5. Build runner configuration updated for code generation
6. Vietnamese development team onboarding documentation updated

**Integration Verification**:
- IV1: Existing Riverpod authentication flows continue functioning unchanged
- IV2: GoRouter navigation remains operational during foundation setup
- IV3: Vietnamese payment gateway integrations unaffected by new dependencies

### Story 1.2: Authentication System Migration

As a Vietnamese sports group member,  
I want to log in with my phone number exactly as before,  
so that my authentication experience remains seamless during the migration.

**Acceptance Criteria**:
1. AuthProvider converted to AuthCubit with identical state management
2. Login, registration, and SMS verification screens updated to use BlocBuilder
3. Vietnamese phone validation preserved with new architecture
4. Secure token storage maintains existing patterns
5. Session management and timeout handling identical to current implementation
6. Authentication guards migrated from GoRouter to AutoRoute

**Integration Verification**:
- IV1: Existing user sessions remain valid after migration
- IV2: Vietnamese SMS gateway integration functions identically
- IV3: Token refresh and logout flows maintain existing security patterns

### Story 1.3: Group Management System Migration

As a Vietnamese sports group leader,  
I want to manage my groups with identical functionality,  
so that group coordination continues seamlessly.

**Acceptance Criteria**:
1. Groups, CreateGroup, and GroupDetails providers converted to respective Cubits
2. Group screens updated to use new state management patterns
3. Role-based permissions (Trưởng nhóm, Phó nhóm, Thành viên, Khách) function identically
4. Vietnamese cultural UI components (RoleBadge, SportIcon) preserved
5. Group creation and member management flows maintain existing UX
6. AutoRoute navigation for group-related screens implemented

**Integration Verification**:
- IV1: Existing group data and member roles remain intact
- IV2: Vietnamese cultural role displays function identically
- IV3: Group navigation and deep linking preserve existing patterns

### Story 1.4: Attendance and Real-time Features Migration

As a Vietnamese sports group member,  
I want attendance tracking to work exactly as before,  
so that my game coordination remains reliable.

**Acceptance Criteria**:
1. Attendance and AttendanceResponse providers converted to Cubits
2. Real-time attendance updates preserved with new state management
3. Vietnamese notification patterns and timing maintained
4. Attendance response screens updated to use BlocBuilder patterns
5. Headcount calculations and display logic identical to existing
6. Offline attendance caching using Hive remains functional

**Integration Verification**:
- IV1: Real-time attendance updates function across all group members
- IV2: Vietnamese timezone handling (UTC+7) preserved in new architecture
- IV3: Offline attendance responses sync correctly when connectivity restored

### Story 1.5: Payment System Migration and Architecture Cleanup

As a Vietnamese sports group member,  
I want payment splitting to work identically,  
so that cost coordination remains transparent and reliable.

**Acceptance Criteria**:
1. Payment-related providers (PaymentSession, QrPayment) converted to Cubits
2. Vietnamese payment gateways (Momo, VietQR, ZaloPay) integration preserved
3. QR code generation and payment tracking function identically
4. Vietnamese currency formatting and display maintained
5. All Riverpod dependencies removed from codebase
6. GoRouter completely replaced with AutoRoute
7. Performance optimization and testing updates completed

**Integration Verification**:
- IV1: All Vietnamese payment gateway integrations function without changes
- IV2: QR code payment flows maintain existing security and UX patterns  
- IV3: Vietnamese currency formatting and cultural payment patterns preserved