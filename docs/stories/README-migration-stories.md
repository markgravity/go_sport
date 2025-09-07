# Migration Stories Overview

This directory contains the detailed user stories for the **Riverpod to Cubit Architecture Migration** epic.

## 📋 Story Sequence

The migration follows a **sequential dependency pattern** to minimize risk to production Vietnamese sports groups:

| Story | Title | Effort | Status | Dependencies |
|-------|-------|--------|--------|--------------|
| **MIGRATION-1** | [Foundation Setup and Dependency Migration](story-migration-1-foundation.md) | 1-2 sprints | ✅ Complete | None |
| **MIGRATION-2** | [Authentication System Migration](story-migration-2-authentication.md) | 2-3 sprints | ✅ Complete | MIGRATION-1 |
| **MIGRATION-3** | [Group Management System Migration](story-migration-3-groups.md) | 2-3 sprints | ✅ Complete | MIGRATION-2 |

**Total Estimated Effort**: 9-13 sprints (approximately 10 weeks as planned)

## 🎯 Migration Goals

### Primary Objectives
- **Simplify State Management**: Move from Riverpod's reactive patterns to Cubit's imperative approach
- **Improve Type Safety**: Replace GoRouter with AutoRoute for better navigation safety
- **Enhance DI Clarity**: Transition from Riverpod DI to explicit GetIt service management
- **Implement MVVM**: Establish clean architecture patterns with Freezed immutability
- **Zero Disruption**: Maintain 100% compatibility with Vietnamese cultural features

### Critical Success Criteria
- ✅ **Vietnamese Features Preserved**: All cultural patterns, payment gateways, phone validation
- ✅ **Performance Maintained**: <15% memory increase, <10% build time impact
- ✅ **Backend Compatible**: Zero changes required to Laravel API
- ✅ **Real-time Reliability**: Attendance tracking maintains current reliability
- ✅ **Payment Security**: All Vietnamese payment gateways (Momo, VietQR, ZaloPay) work identically

## 🚀 Implementation Strategy

### Phase-based Approach
1. **Foundation** (Week 1-2): Establish new architecture alongside existing
2. **Authentication** (Week 3-4): Migrate critical user authentication flows  
3. **Groups** (Week 5-6): Convert group management and Vietnamese role systems
4. **Attendance** (Week 7-8): Migrate real-time attendance coordination
5. **Payments & Cleanup** (Week 9-10): Complete migration and remove old architecture

### Feature Flag Strategy
Each story includes feature flags enabling **safe rollback** during migration:
- `USE_CUBIT_AUTH` - Toggle authentication system
- `USE_CUBIT_GROUPS` - Toggle group management system  
- `USE_CUBIT_ATTENDANCE` - Toggle attendance tracking
- `USE_CUBIT_PAYMENTS` - Toggle payment system

### Risk Mitigation
- **Incremental rollout** per Vietnamese sports season timing
- **Parallel architecture** during transition (Riverpod + Cubit coexistence)
- **Extensive testing** with Vietnamese test data and cultural patterns
- **Vietnamese group leader validation** at each phase

## 📊 Vietnamese Cultural Preservation

### Key Vietnamese Features Protected
- **Phone Validation**: Vietnamese phone number formats (+84, 84, 0 prefixes)
- **Role Management**: Cultural hierarchy (Trưởng nhóm, Phó nhóm, Thành viên, Khách)
- **Payment Integration**: Momo, VietQR, ZaloPay with Vietnamese currency formatting
- **Timezone Handling**: UTC+7 Vietnam timezone for all attendance coordination
- **Cultural UI**: Vietnamese sports icons, role badges, currency displays
- **Localization**: Vietnamese text rendering, diacritics, cultural messaging patterns

### Screen-ViewModel Co-location Architecture

**IMPORTANT ORGANIZATIONAL RULE**: Each screen must have its dedicated ViewModel (Cubit) placed in the same folder for better maintainability:

```
features/auth/screens/
├── login/
│   ├── login_screen.dart
│   ├── login_view_model.dart      # LoginViewModel extends Cubit<LoginState>
│   └── login_state.dart           # Freezed state classes
├── forgot_password/
│   ├── forgot_password_screen.dart
│   ├── forgot_password_view_model.dart
│   └── forgot_password_state.dart
└── phone_registration/
    ├── phone_registration_screen.dart
    ├── phone_registration_view_model.dart
    └── phone_registration_state.dart
```

This pattern ensures:
- **Clear ownership**: Each screen owns its business logic
- **Easy maintenance**: Related files are co-located  
- **Better testing**: ViewModels can be tested independently
- **Reduced coupling**: Screen-specific logic stays with the screen

### Testing with Vietnamese Data
Each story includes comprehensive testing with:
- Real Vietnamese phone numbers and names
- Vietnamese sports group scenarios (badminton, pickleball, football)
- Vietnamese payment amounts and banking patterns
- Vietnamese timezone and cultural scheduling patterns
- Vietnamese error messages and user feedback

## 🛠️ Development Team Assignment

### Recommended Team Structure
- **Migration Lead**: Oversees architectural consistency across stories
- **Vietnamese Features Specialist**: Ensures cultural patterns preserved  
- **Payment Integration Expert**: Handles Vietnamese payment gateway compatibility
- **QA Engineer**: Validates integration verification criteria

### Story Assignment Pattern
- **MIGRATION-1**: Senior developer (foundation critical)
- **MIGRATION-2**: Authentication specialist + Vietnamese features expert
- **MIGRATION-3**: Full team (complex group management)
- **MIGRATION-4**: Real-time systems expert + Vietnamese features expert  
- **MIGRATION-5**: Payment specialist + migration lead (cleanup critical)

## 📋 Definition of Done (Per Story)

Each story must meet these criteria before completion:

### Technical Requirements
- [ ] All acceptance criteria met and verified
- [ ] Integration verification tests pass with Vietnamese data
- [ ] Unit test coverage >85% for new Cubit implementations
- [ ] Widget tests validate Vietnamese UI elements
- [ ] Performance benchmarks maintained or improved

### Cultural Requirements  
- [ ] Vietnamese sports group leaders approve functionality
- [ ] Vietnamese cultural patterns preserved identically
- [ ] Vietnamese error messages and localization work correctly
- [ ] Vietnamese payment/notification patterns function properly

### Quality Requirements
- [ ] Code review completed with architectural focus
- [ ] QA sign-off on Vietnamese user workflows  
- [ ] Feature flag rollback tested and verified
- [ ] Documentation updated for new patterns

## 📚 Reference Documents

- **[Migration PRD](../frontend-architecture-migration-prd.md)**: Complete migration requirements
- **[UI Architecture](../ui-architecture.md)**: Current and target architecture details
- **[Vietnamese Data Examples](../VIETNAMESE_DATA_EXAMPLES.md)**: Test data patterns
- **[Team Onboarding](../TEAM_ONBOARDING.md)**: Developer setup and standards

## 🎉 Migration Success Celebration

Upon completion of all 5 stories:
- ✅ **10-week migration completed successfully**
- ✅ **Modern Cubit + AutoRoute + GetIt architecture implemented**
- ✅ **All Vietnamese cultural features preserved**
- ✅ **Zero disruption to active sports groups**
- ✅ **Enhanced maintainability for future development**

---

**Next**: Start with **[Story Migration 1: Foundation Setup](story-migration-1-foundation.md)** 🚀