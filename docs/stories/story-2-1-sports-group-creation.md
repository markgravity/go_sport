# Story 2.1: Sports Group Creation & Configuration

## Story
**As a group leader,**
**I want to create và configure sports groups với Vietnamese-specific settings,**
**so that my group reflects our actual playing patterns và requirements.**

## Acceptance Criteria
1. Group creation form supports cầu lông, pickleball, và bóng đá với sport-specific defaults
2. Customizable settings: minimum players, notification timing, default game locations
3. Group names support Vietnamese characters và cultural naming patterns
4. Default roles assigned automatically (creator becomes Trưởng nhóm)
5. Group visibility settings (public for discovery, private for invitation-only)
6. Group avatar/photo upload với appropriate content filtering
7. Basic group information displayed in Vietnamese-friendly formats
8. Groups saved với proper data validation và error handling

## Dev Notes
- Create Group model with Vietnamese sports support (cầu lông, pickleball, bóng đá)
- Implement sport-specific defaults for minimum players and timing
- Support Vietnamese text input and display for group names
- Create role assignment system (Trưởng nhóm, Phó nhóm, Thành viên, Khách)
- Add image upload functionality with content filtering
- Implement proper validation for Vietnamese naming patterns
- Create group settings management interface
- Ensure data integrity with proper foreign key relationships

## Testing
- [ ] Group creation form accepts Vietnamese characters in names
- [ ] Sport-specific defaults are applied correctly
- [ ] Role assignment works properly (creator becomes Trưởng nhóm)
- [ ] Image upload and content filtering function correctly
- [ ] Visibility settings control group discovery appropriately
- [ ] Validation prevents invalid group configurations
- [ ] Vietnamese text display works correctly across all UI elements
- [ ] Data persistence and retrieval work reliably

## Tasks
- [x] **Task 2.1.1**: Create Group database model and migrations
- [x] **Task 2.1.2**: Implement sports configuration with Vietnamese defaults
- [x] **Task 2.1.3**: Create group creation API endpoints
- [x] **Task 2.1.4**: Build Flutter group creation UI screens
- [ ] **Task 2.1.5**: Add image upload and content filtering
- [ ] **Task 2.1.6**: Implement role assignment system
- [ ] **Task 2.1.7**: Add Vietnamese localization for group management
- [ ] **Task 2.1.8**: Create comprehensive group creation tests

## Subtasks

### Task 2.1.1: Create Group database model and migrations
- [x] Create groups table with Vietnamese sports support
- [x] Add group_members pivot table with roles
- [x] Create group_settings table for customizations
- [x] Add proper indexes and foreign key constraints
- [x] Create Group Eloquent model with relationships
- [x] Add sport-specific validation rules
- [x] Implement group visibility and discovery settings

### Task 2.1.2: Implement sports configuration with Vietnamese defaults
- [x] Define sport types (cầu lông, pickleball, bóng đá) với defaults
- [x] Create sport-specific minimum player requirements
- [x] Add default notification timing cho each sport
- [x] Implement location suggestions for common Vietnamese venues
- [x] Create sport-specific group settings templates
- [x] Add Vietnamese naming conventions for sports
- [x] Implement sport icons and visual branding

### Task 2.1.3: Create group creation API endpoints
- [x] Create POST /api/groups endpoint với validation
- [x] Add GET /api/sports endpoint for available sports
- [x] Implement group ownership validation
- [x] Add proper error handling với Vietnamese messages
- [x] Create group settings management endpoints
- [x] Add rate limiting for group creation
- [x] Implement group discovery API endpoints

### Task 2.1.4: Build Flutter group creation UI screens
- [x] Create GroupCreationScreen với sport selection
- [x] Add group name input với Vietnamese character support
- [x] Implement sport-specific settings forms
- [x] Create group avatar selection interface
- [x] Add visibility settings toggle (public/private)
- [x] Implement location input với Vietnamese addresses
- [x] Create group creation confirmation flow

### Task 2.1.5: Add image upload and content filtering
- [ ] Integrate image picker for group avatars
- [ ] Implement image compression and resizing
- [ ] Add content filtering for inappropriate images
- [ ] Create secure image upload API endpoint
- [ ] Add image storage with proper file management
- [ ] Implement default avatar system
- [ ] Add image preview and editing capabilities

### Task 2.1.6: Implement role assignment system
- [ ] Create role-based permission system
- [ ] Assign creator as Trưởng nhóm automatically
- [ ] Implement role hierarchy (Trưởng nhóm > Phó nhóm > Thành viên > Khách)
- [ ] Add role-based UI visibility controls
- [ ] Create permission validation middleware
- [ ] Add role change audit logging
- [ ] Implement role-based group access controls

### Task 2.1.7: Add Vietnamese localization for group management
- [ ] Add Vietnamese text for all group creation forms
- [ ] Create sport name translations
- [ ] Add role name translations (Trưởng nhóm, etc.)
- [ ] Implement Vietnamese error messages
- [ ] Add help text for group creation process
- [ ] Create culturally appropriate group naming suggestions
- [ ] Add Vietnamese address format support

### Task 2.1.8: Create comprehensive group creation tests
- [ ] Unit tests for Group model validations
- [ ] API endpoint tests for group creation flow
- [ ] Flutter widget tests for group creation UI
- [ ] Integration tests for complete creation workflow
- [ ] Image upload and content filtering tests
- [ ] Role assignment and permission tests
- [ ] Vietnamese localization tests

---

## Dev Agent Record

### Status: In Progress

### Agent Model Used: claude-sonnet-4-20250514 

### Debug Log References:
- 

### File List:
- api/database/migrations/2025_09_06_110349_add_pickleball_and_vietnamese_settings_to_groups_table.php (modified groups table)
- api/database/migrations/2025_09_06_110441_update_group_membership_roles_to_vietnamese.php (added guest role)
- api/app/Models/Group.php (updated with new fields, sport types, and validation rules)
- api/app/Services/SportsConfigurationService.php (comprehensive sports configuration and Vietnamese defaults)
- api/app/SportType.php (enum for type-safe sport types with Vietnamese names)
- api/app/Http/Controllers/Api/GroupController.php (updated with new validation and sports integration)
- api/app/Http/Controllers/Api/SportsController.php (comprehensive sports API endpoints)
- api/routes/api.php (updated with new endpoints and rate limiting)
- mobile/lib/features/groups/models/sport.dart (updated to work with new API structure)
- mobile/lib/features/groups/services/groups_service.dart (enhanced with name suggestions API)
- mobile/lib/features/groups/screens/create_group_screen.dart (enhanced with Vietnamese name suggestions)

### Completion Notes:
- **Task 2.1.1 COMPLETED**: Created Group database model and migrations with Vietnamese sports support (football, badminton, tennis, pickleball), English roles (admin, moderator, member, guest, pending), sport-specific validation rules, and proper relationships
- **Task 2.1.2 COMPLETED**: Implemented comprehensive sports configuration service with Vietnamese defaults, location suggestions, naming conventions, sport-specific settings, and type-safe SportType enum
- **Task 2.1.3 COMPLETED**: Created comprehensive group creation API endpoints with Vietnamese error handling, rate limiting (5 groups/hour), sports integration, group ownership validation, and complete CRUD operations
- **Task 2.1.4 COMPLETED**: Built comprehensive Flutter group creation UI with 3-step wizard, sport selection, Vietnamese name suggestions, sport-specific settings, location input, and confirmation flow

### Change Log:
| Date | Change | Developer |
|------|--------|-----------|
| 2025-09-06 | Story 2.1 created from PRD Epic 2 requirements | James (Dev) |