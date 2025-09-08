# Story 2.2: Unified Invitation System Implementation

## Story
**As a group leader,**
**I want to invite people via both shareable links và direct phone invitations,**
**so that I can recruit members using familiar Vietnamese social patterns.**

## Acceptance Criteria
1. Invitation links generated với expiration options (1 day, 1 week, permanent)
2. Phone number invitation sends SMS với group information và join link
3. Invitation links contain group preview (name, sport, member count)
4. Link clicks by registered users trigger join request workflow
5. Unregistered users prompted to register before joining
6. Invitation analytics track usage và conversion rates
7. Invitation limits prevent spam (10 pending invites maximum)
8. Invitation revocation functionality với immediate link invalidation

## Dev Notes
- Create invitation links với unique secure tokens
- Implement SMS invitation service with Vietnamese messaging
- Build group preview landing page for invitation links
- Add invitation management interface for group leaders
- Track invitation analytics (sent, clicked, converted)
- Implement rate limiting and spam protection
- Support Vietnamese phone number formats for SMS invitations
- Create join request workflow integrating with existing group management
- Add proper error handling and user feedback
- Ensure invitation system works on mobile web for link sharing

## Testing
- [ ] Invitation links generate correctly với proper expiration
- [ ] SMS invitations send với Vietnamese group information
- [ ] Group preview displays accurate information for invites
- [ ] Join request workflow functions properly for registered users
- [ ] Registration prompt works for unregistered users clicking links
- [ ] Invitation analytics track correctly
- [ ] Rate limiting prevents invitation spam
- [ ] Link revocation immediately invalidates invitations

## Tasks
- [ ] **Task 2.2.1**: Create invitation database schema and models
- [ ] **Task 2.2.2**: Implement invitation link generation and management API
- [ ] **Task 2.2.3**: Create SMS invitation service with Vietnamese messaging
- [ ] **Task 2.2.4**: Build group preview landing page for invitation links
- [ ] **Task 2.2.5**: Implement join request workflow
- [ ] **Task 2.2.6**: Create Flutter invitation management UI
- [ ] **Task 2.2.7**: Add invitation analytics and tracking
- [ ] **Task 2.2.8**: Implement comprehensive invitation tests

## Subtasks

### Task 2.2.1: Create invitation database schema and models
- [ ] Create group_invitations table với token, expiration, creator
- [ ] Add invitation analytics tracking table
- [ ] Create Invitation Eloquent model với relationships
- [ ] Add invitation status enum (pending, used, expired, revoked)
- [ ] Implement invitation token generation và validation
- [ ] Add proper indexes for performance
- [ ] Create migration for invitation features

### Task 2.2.2: Implement invitation link generation and management API
- [ ] Create POST /api/groups/{id}/invitations endpoint
- [ ] Add GET /api/groups/{id}/invitations for invitation management
- [ ] Implement invitation link validation endpoint
- [ ] Add DELETE /api/invitations/{token} for revocation
- [ ] Create group preview API endpoint với public access
- [ ] Add rate limiting for invitation creation
- [ ] Implement proper error handling và Vietnamese messages

### Task 2.2.3: Create SMS invitation service with Vietnamese messaging
- [ ] Extend existing SMS service for invitations
- [ ] Create Vietnamese invitation message templates
- [ ] Integrate phone number invitation API endpoint
- [ ] Add SMS invitation tracking và delivery status
- [ ] Implement phone number validation for invitations
- [ ] Add invitation SMS rate limiting
- [ ] Create fallback messaging for SMS failures

### Task 2.2.4: Build group preview landing page for invitation links
- [ ] Create mobile-optimized group preview page
- [ ] Display group name, sport type, member count, creator info
- [ ] Add join button for registered users
- [ ] Create registration prompt for unregistered users
- [ ] Implement proper error handling for invalid/expired links
- [ ] Add Vietnamese localization for preview page
- [ ] Ensure preview works on mobile browsers

### Task 2.2.5: Implement join request workflow
- [ ] Create join request API endpoints
- [ ] Implement notification system for join requests
- [ ] Add join request approval/rejection workflow
- [ ] Create join request status tracking
- [ ] Implement automatic group role assignment on approval
- [ ] Add join request rate limiting per user
- [ ] Create Vietnamese notifications for join requests

### Task 2.2.6: Create Flutter invitation management UI
- [ ] Build invitation management screen for group leaders
- [ ] Add invitation creation form với expiration options
- [ ] Create phone invitation interface với contact picker
- [ ] Implement invitation list với status tracking
- [ ] Add invitation revocation functionality
- [ ] Create share invitation link functionality
- [ ] Add Vietnamese localization for invitation UI

### Task 2.2.7: Add invitation analytics and tracking
- [ ] Create analytics dashboard for invitation performance
- [ ] Track invitation creation, clicks, và conversions
- [ ] Implement invitation source tracking
- [ ] Add group growth analytics
- [ ] Create invitation success rate metrics
- [ ] Add analytics API endpoints for group leaders
- [ ] Implement privacy-compliant analytics storage

### Task 2.2.8: Implement comprehensive invitation tests
- [ ] Unit tests for invitation models và validation
- [ ] API endpoint tests for invitation workflow
- [ ] SMS invitation integration tests
- [ ] Group preview landing page tests
- [ ] Join request workflow tests
- [ ] Flutter widget tests for invitation UI
- [ ] End-to-end invitation flow tests

---

## Dev Agent Record

### Status: Not Started

### Agent Model Used: 

### Debug Log References:

### File List:

### Completion Notes:

### Change Log:
| Date | Change | Developer |
|------|--------|-----------|
| 2025-09-08 | Story 2.2 created from PRD Epic 2 requirements | Claude (AI Dev) |