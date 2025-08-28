# Go Sport App Product Requirements Document (PRD)

## Goals and Background Context

### Goals
- Enable sports group coordination từ 35 minutes xuống <10 minutes per session through automated attendance and payment systems
- Reduce game cancellation rate từ ~20% xuống <10% through improved member reliability tracking và inter-group networking
- Eliminate payment disputes trong sports groups through transparent QR-based cost splitting với real-time tracking
- Create sustainable business achieving break-even within 12 months với 500+ active groups
- Establish foundation cho Vietnamese sports community platform với network effects through guest access system

### Background Context

Vietnamese recreational sports groups currently manage coordination through fragmented tools (WhatsApp, Facebook groups, manual spreadsheets), creating significant inefficiencies trong attendance tracking, payment management, và inter-group networking. Market research indicates 30-45 minutes coordination time per session với 15-20% games cancelled due to coordination issues.

Go Sport App addresses these pain points through mobile-first platform combining smart attendance system, role-based permissions, integrated Vietnamese payment gateways, và innovative inter-group guest access. The solution targets urban Vietnamese sports communities (cầu lông, pickleball, bóng đá) with focus on group leaders who drive adoption across their members.

### Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-08-28 | v1.0 | Initial PRD creation from project brief | John (PM) |

## Requirements

### Functional

**FR1:** The system shall allow group leaders to create sports groups với customizable settings (sport type, minimum players, notification timing, payment rules)

**FR2:** Users shall register accounts using Vietnamese phone numbers với SMS verification để ensure authentic local user base

**FR3:** The system shall support 4-tier role management (Trưởng nhóm, Phó nhóm, Thành viên, Khách) với distinct permission levels for each role

**FR4:** Group leaders và phó nhóm shall send attendance notifications at customizable times với customizable deadlines before game time

**FR5:** Members shall respond to attendance requests với basic options (✅ Có thể đến, ❌ Không thể đến) trong mobile interface

**FR6:** The system shall automatically calculate headcount và display real-time attendance status to all group members

**FR7:** Users shall change attendance responses after deadline với automatic notifications sent to group members about changes

**FR8:** The system shall support unified invitation system allowing both sharable links và direct phone number invitations

**FR9:** Leaders và phó nhóm shall approve new member requests với ability to assign roles dynamically during approval process

**FR10:** Guest users shall access view-only attendance information cho multiple groups simultaneously without participation rights

**FR11:** The system shall generate QR codes cho cost splitting dựa trên final attendance list với support for Vietnamese payment methods

**FR12:** Users shall track payment completion status với basic payment history interface

**FR13:** The mobile app shall function on iOS và Android platforms với offline capability cho critical attendance functions

### Non Functional

**NFR1:** The system shall achieve <3 second app launch time và <2 second notification-to-response time on target Vietnamese mobile devices

**NFR2:** The platform shall maintain 99%+ uptime với auto-scaling infrastructure to handle Vietnamese peak usage patterns

**NFR3:** All financial data shall be encrypted end-to-end với compliance to Vietnamese data localization requirements

**NFR4:** The system shall support up to 50 members per group với scalable architecture for future expansion

**NFR5:** Push notifications shall be delivered within 30 seconds của generation với fallback SMS for critical attendance deadlines

**NFR6:** The mobile app shall work on devices running iOS 12+ và Android 8.0+ để cover 95%+ của target market device base

**NFR7:** Vietnamese payment gateway integrations shall process transactions với <5% failure rate và real-time status updates

**NFR8:** User data export/deletion capabilities shall be available để meet GDPR compliance requirements cho Vietnamese users

## User Interface Design Goals

### Overall UX Vision

Go Sport App shall deliver a mobile-first, culturally-aware Vietnamese user experience optimized for quick task completion. The interface prioritizes speed of common actions (attendance response, payment generation) over feature discovery, with clear visual hierarchy emphasizing group status and member roles. Vietnamese language patterns, color preferences, and interaction expectations shall guide all UX decisions.

### Key Interaction Paradigms

- **One-tap primary actions:** Critical functions (attend/decline, generate QR) accessible within 1-2 taps from notifications or home screen
- **Role-based progressive disclosure:** Interface complexity scales with user permissions - guests see minimal UI, leaders see full management capabilities
- **Status-first design:** Current game status, headcount, and payment status prominently displayed using Vietnamese cultural color coding (red for incomplete, green for confirmed)
- **Notification-driven workflow:** Primary user entry points through push notifications rather than app-opening habits

### Core Screens and Views

- **Home Dashboard:** Real-time status của upcoming games, quick attendance responses, notifications feed
- **Group Management:** Member list with roles, invitation tools, group settings (leader/co-leader only)
- **Attendance Detail:** Full member attendance status, headcount visualization, late response handling
- **Payment QR Generator:** Cost calculation, QR code display, payment status tracking
- **Profile Settings:** Personal info, notification preferences, multi-group management
- **Guest Access View:** Read-only attendance visibility với simplified navigation

### Accessibility: WCAG AA

Vietnamese market focus with high mobile usage requires strong accessibility baseline. WCAG AA compliance ensures compatibility with Vietnamese assistive technology and supports diverse user abilities across age ranges typical in sports communities.

### Branding

Clean, sports-focused design reflecting Vietnamese cultural preferences for functional clarity over decorative elements. Color palette emphasizes trust (blues), success (greens), and attention (appropriate reds for urgent actions). Typography supports Vietnamese diacritics perfectly với excellent mobile readability.

### Target Device and Platforms: Mobile Only

iOS và Android native apps via Flutter framework. No web interface for MVP - Vietnamese users heavily mobile-first với sporadic desktop usage for recreational activities. Focus ensures optimal mobile experience within development resources.

## Technical Assumptions

### Repository Structure: Monorepo

Single repository containing `/mobile-app` (Flutter), `/api` (Laravel), `/shared` (documentation, assets) facilitating coordination between small development team và enabling atomic releases của frontend/backend changes.

### Service Architecture

**Microservices within Monorepo:** Separate Laravel services for user management, notification system, payment processing while maintaining single codebase. Enables independent scaling của high-traffic components (notifications, payment) while preserving development simplicity for MVP stage.

### Testing Requirements

**Unit + Integration testing:** Comprehensive test coverage for financial components, notification reliability, và role-based access control. Manual testing focus on Vietnamese payment gateway integrations và device compatibility across target Android/iOS versions.

### Additional Technical Assumptions and Requests

- **Vietnamese Payment Gateway Priority:** Momo integration first, followed by VietQR và ZaloPay based on API documentation quality
- **Flutter State Management:** Provider/Riverpod for predictable state handling across complex role-based UI variations
- **Background Processing:** Laravel queues for attendance notifications, payment processing, với Redis backing for high-reliability messaging
- **Local Development Environment:** Docker setup enabling rapid onboarding của Vietnamese developers familiar with PHP ecosystem
- **Monitoring và Logging:** Comprehensive application monitoring cho Vietnamese network conditions và device performance characteristics

## Epic List

### Epic 1: Foundation & Authentication System
Establish project infrastructure, user registration với Vietnamese phone verification, và basic role-based access control. Delivers functional user onboarding và secure authentication foundation.

### Epic 2: Core Group Management & Invitations  
Create sports groups, manage member roles, và implement unified invitation system (links + phone). Delivers complete group lifecycle management với Vietnamese-specific UX patterns.

### Epic 3: Smart Attendance System
Implement customizable notifications, attendance responses, real-time headcount tracking, và post-deadline change handling. Delivers core value proposition của automated coordination.

### Epic 4: Payment Integration & QR Generation
Integrate Vietnamese payment gateways, generate QR codes dựa trên attendance, và track payment completion status. Delivers financial transparency và automation completing MVP scope.

## Epic 1: Foundation & Authentication System

**Epic Goal:** Establish robust project foundation với secure user authentication, basic mobile app architecture, và core infrastructure supporting Vietnamese market requirements. All subsequent features depend on reliable user identity và role management established here.

### Story 1.1: Project Setup & Development Environment
**As a developer,**
**I want a complete development environment với Flutter/Laravel integration,**
**so that I can build và test the Go Sport app efficiently.**

**Acceptance Criteria:**
1. Flutter mobile app project initialized với iOS và Android targets
2. Laravel API project configured với MySQL database và Redis caching
3. Docker development environment setup với all dependencies
4. CI/CD pipeline configured cho automated testing và deployment
5. Basic app shell displays "Go Sport" branding và navigation structure
6. API health check endpoint returns status information
7. Mobile app successfully connects to local Laravel API
8. Documentation includes setup instructions cho Vietnamese developers

### Story 1.2: Phone-based User Registration
**As a Vietnamese sports player,**
**I want to register using my phone number với SMS verification,**
**so that I have a secure, locally-appropriate account.**

**Acceptance Criteria:**
1. Registration screen accepts Vietnamese phone number formats (+84, 0x formats)
2. SMS verification code sent via Vietnamese SMS provider
3. Users enter 6-digit verification code với 5-minute expiration
4. Account creation includes basic profile (name, phone, preferred sports)
5. Invalid phone numbers show appropriate Vietnamese error messages
6. SMS resend functionality với rate limiting (max 3 per 15 minutes)
7. Successful registration navigates to onboarding flow
8. Phone numbers stored encrypted và compliant với Vietnamese data laws

### Story 1.3: Basic Authentication & Session Management
**As a registered user,**
**I want secure login và automatic session handling,**
**so that I stay logged in conveniently while maintaining security.**

**Acceptance Criteria:**
1. Login screen accepts phone number và password/SMS authentication
2. JWT tokens issued với 7-day expiration và refresh capability
3. Biometric authentication option (fingerprint/face) cho returning users
4. Automatic token refresh handled transparently
5. Secure logout clears all local authentication data
6. Session timeout protection với re-authentication prompts
7. Login attempts rate-limited để prevent brute force attacks
8. Remember device functionality cho trusted devices

### Story 1.4: Role-based Access Control Foundation
**As a system administrator,**
**I want user roles properly enforced throughout the application,**
**so that permissions work correctly across all features.**

**Acceptance Criteria:**
1. User model includes role assignment (Trưởng nhóm, Phó nhóm, Thành viên, Khách)
2. API middleware enforces role-based access control
3. Mobile app UI adapts based on user roles và permissions
4. Role changes require appropriate authorization levels
5. Guest users have read-only access enforced at API level
6. Admin panel allows role assignment với proper audit logging
7. Role inheritance properly implemented (Phó nhóm có Thành viên permissions)
8. Error messages appropriate cho permission denied scenarios

## Epic 2: Core Group Management & Invitations

**Epic Goal:** Enable complete sports group lifecycle management từ creation đến member management, implementing flexible invitation system supporting both Vietnamese social patterns (phone-based) và modern link sharing. Groups become functional coordination units ready for attendance features.

### Story 2.1: Sports Group Creation & Configuration
**As a group leader,**
**I want to create và configure sports groups với Vietnamese-specific settings,**
**so that my group reflects our actual playing patterns và requirements.**

**Acceptance Criteria:**
1. Group creation form supports cầu lông, pickleball, và bóng đá với sport-specific defaults
2. Customizable settings: minimum players, notification timing, default game locations
3. Group names support Vietnamese characters và cultural naming patterns
4. Default roles assigned automatically (creator becomes Trưởng nhóm)
5. Group visibility settings (public for discovery, private for invitation-only)
6. Group avatar/photo upload với appropriate content filtering
7. Basic group information displayed in Vietnamese-friendly formats
8. Groups saved với proper data validation và error handling

### Story 2.2: Unified Invitation System Implementation
**As a group leader,**
**I want to invite people via both shareable links và direct phone invitations,**
**so that I can recruit members using familiar Vietnamese social patterns.**

**Acceptance Criteria:**
1. Invitation links generated với expiration options (1 day, 1 week, permanent)
2. Phone number invitation sends SMS với group information và join link
3. Invitation links contain group preview (name, sport, member count)
4. Link clicks by registered users trigger join request workflow
5. Unregistered users prompted to register before joining
6. Invitation analytics track usage và conversion rates
7. Invitation limits prevent spam (10 pending invites maximum)
8. Invitation revocation functionality với immediate link invalidation

### Story 2.3: Member Approval & Role Assignment Workflow
**As a group leader hoặc phó nhóm,**
**I want to review join requests và assign appropriate roles,**
**so that group membership reflects actual participation levels.**

**Acceptance Criteria:**
1. Join request notifications sent to leaders và phó nhóm within 30 seconds
2. Approval interface shows requestor profile và invitation source
3. Role selection during approval (Thành viên default, Khách option)
4. Batch approval capability cho multiple pending requests
5. Rejection with optional reason message sent to requestor
6. Automatic approval option với configurable criteria
7. Role change functionality post-approval với proper permissions
8. Member removal capability với confirmation dialogs

### Story 2.4: Group Member Management & Overview
**As a group leader,**
**I want to view và manage all group members với their roles và activity,**
**so that I can maintain healthy group dynamics.**

**Acceptance Criteria:**
1. Member list displays roles, join dates, và recent activity status
2. Search và filter members by role, activity level, attendance patterns
3. Member profile access with contact information và statistics
4. Role modification requiring appropriate authorization levels
5. Member removal with confirmation và optional reason
6. Activity indicators showing last attendance, payment status
7. Group statistics dashboard với member engagement metrics
8. Export member list functionality cho external coordination

## Epic 3: Smart Attendance System

**Epic Goal:** Deliver core value proposition através automated attendance coordination, reducing manual effort từ 35+ minutes to <10 minutes per session. Smart notifications, real-time tracking, và flexible response handling create reliable game planning foundation.

### Story 3.1: Customizable Attendance Notifications
**As a group leader,**
**I want to configure automated attendance notifications cho different scheduling patterns,**
**so that my group receives timely reminders matching our playing habits.**

**Acceptance Criteria:**
1. Notification scheduling supports daily, specific days, hoặc custom intervals
2. Timing configuration with multiple options (2 hours before, day before, custom)
3. Deadline settings với countdown timers visible to members
4. Notification templates customizable với group-specific messaging
5. Sport-specific defaults (cầu lông evening notifications, football weekend scheduling)
6. Preview functionality showing exact notification timing
7. Bulk scheduling capability cho recurring games
8. Notification history tracking cho troubleshooting

### Story 3.2: Mobile Attendance Response Interface
**As a group member,**
**I want quick, intuitive attendance responses from notifications,**
**so that I can confirm availability without app navigation friction.**

**Acceptance Criteria:**
1. Push notification displays attendance options (✅ Có thể đến, ❌ Không thể đến)
2. One-tap response directly from notification saves preference
3. In-app response interface với clear status indicators
4. Response confirmation shown với option to change before deadline
5. Late response warnings với clear deadline information
6. Response history visible trong personal profile
7. Bulk response capability cho multiple upcoming games
8. Offline response queueing với sync when connectivity restored

### Story 3.3: Real-time Headcount & Status Tracking
**As a group member,**
**I want to see live attendance status và headcount,**
**so that I understand game likelihood và can plan accordingly.**

**Acceptance Criteria:**
1. Real-time headcount updates visible to all group members
2. Attendance status visualization với member names và responses
3. Minimum player threshold indicators với status colors
4. Game likelihood assessment (confirmed, likely, at risk, cancelled)
5. Non-responder identification với gentle reminder options
6. Time remaining until deadline prominently displayed
7. Historical attendance patterns accessible for planning
8. Push notifications cho significant status changes

### Story 3.4: Post-Deadline Change Management
**As a group member,**
**I want to change my attendance after deadline trong emergency situations,**
**so that the group receives accurate last-minute updates.**

**Acceptance Criteria:**
1. Post-deadline changes allowed với confirmation dialogs
2. Automatic notifications sent to all group members về changes
3. Change reasons optional với common templates (traffic, work, family)
4. Group leader notification priority cho critical changes
5. Change history tracking cho reliability assessment
6. Late arrival estimation capability với ETA sharing
7. Impact assessment showing effect on game viability
8. Emergency contact options cho last-minute coordination

## Epic 4: Payment Integration & QR Generation

**Epic Goal:** Complete MVP value delivery através seamless financial coordination, eliminating payment disputes và manual money collection. Vietnamese payment gateway integration enables transparent, efficient cost splitting dựa trên actual attendance.

### Story 4.1: Vietnamese Payment Gateway Integration
**As a system administrator,**
**I want reliable connections to Vietnamese payment providers,**
**so that users can split costs using familiar local payment methods.**

**Acceptance Criteria:**
1. Momo API integration với transaction creation và status tracking
2. VietQR standard compliance cho banking app compatibility
3. ZaloPay integration với merchant account setup
4. Payment provider fallback logic trong case của service issues
5. Transaction fee calculation với transparent cost display
6. Webhook handling cho real-time payment status updates
7. Refund capability cho cancelled games hoặc overpayments
8. Payment history storage với proper data encryption

### Story 4.2: Attendance-based Cost Calculation
**As a group leader,**
**I want automatic cost splitting dựa trên final attendance list,**
**so that payment amounts are fair và transparent.**

**Acceptance Criteria:**
1. Cost input interface cho venue fees, equipment, other expenses
2. Automatic per-person calculation based on confirmed attendees
3. Manual adjustment capability cho special circumstances
4. Cost breakdown display với itemized expenses
5. Different cost rules cho different member types (guests pay more)
6. Historical cost tracking cho budgeting assistance
7. Cost estimation tools based on typical group expenses
8. Export cost summaries cho group financial records

### Story 4.3: QR Code Generation & Payment Tracking
**As a group leader,**
**I want to generate payment QR codes và track completion status,**
**so that money collection becomes automated và transparent.**

**Acceptance Criteria:**
1. QR code generation với embedded payment amounts và recipient details
2. Individual QR codes cho each attendee với personalized amounts
3. QR code display optimized cho mobile screen sharing
4. Payment completion tracking với real-time status updates
5. Reminder notifications cho outstanding payments
6. Receipt generation và storage cho completed payments
7. Group payment dashboard với completion percentages
8. Integration với venue payment sistemas where possible

### Story 4.4: Payment History & Transparency Features
**As a group member,**
**I want clear payment history và transparent cost breakdowns,**
**so that I trust the payment process và can track my expenses.**

**Acceptance Criteria:**
1. Personal payment history với dates, amounts, và purposes
2. Group expense transparency với detailed cost breakdowns
3. Payment status indicators cho all group members
4. Dispute reporting mechanism với escalation to group leaders
5. Payment analytics showing spending patterns over time
6. Export functionality cho personal expense tracking
7. Group financial summary reports cho budget planning
8. Integration preparation cho expense sharing apps

## Checklist Results Report

### Executive Summary

**Overall PRD Completeness:** 95% - Excellent comprehensive documentation
**MVP Scope Appropriateness:** Just Right - Well-balanced feature set for market validation
**Readiness for Architecture Phase:** Ready - Clear technical guidance and constraints provided
**Most Critical Gaps:** Minor areas needing clarification around testing strategies and operational monitoring

### Category Analysis Table

| Category                         | Status   | Critical Issues |
| -------------------------------- | -------- | --------------- |
| 1. Problem Definition & Context  | PASS     | None - Clear problem statement with quantified impact |
| 2. MVP Scope Definition          | PASS     | None - Well-defined boundaries with future roadmap |
| 3. User Experience Requirements  | PASS     | None - Comprehensive UX vision with Vietnamese cultural considerations |
| 4. Functional Requirements       | PASS     | None - Complete FR coverage with clear acceptance criteria |
| 5. Non-Functional Requirements   | PASS     | Minor - Could benefit from more specific monitoring requirements |
| 6. Epic & Story Structure        | PASS     | None - Well-sequenced epics with appropriate story sizing |
| 7. Technical Guidance            | PASS     | None - Clear architecture direction with Vietnamese market constraints |
| 8. Cross-Functional Requirements | PARTIAL  | Missing detailed data schema evolution planning |
| 9. Clarity & Communication       | PASS     | None - Excellent documentation quality and stakeholder handoff guidance |

### Top Issues by Priority

**HIGH Priority:**
- **Data Schema Evolution:** Stories should include more specific guidance on database schema changes tied to epic progression
- **Payment Gateway Risk Mitigation:** More detailed contingency planning for Vietnamese payment integration challenges

**MEDIUM Priority:**
- **Monitoring Strategy:** Enhanced operational monitoring requirements for Vietnamese network conditions
- **Testing Strategy Detail:** More specific guidance on Vietnamese payment gateway testing approaches

**LOW Priority:**
- **User Research Validation:** Recommendations for validating user persona assumptions post-MVP launch

### MVP Scope Assessment

**Scope Analysis:** ✅ **Appropriately Sized**
- **Core Features:** All essential for value proposition validation
- **Vietnamese Localization:** Critical differentiator properly prioritized  
- **Inter-group Networking:** Smart inclusion - low complexity, high differentiation potential
- **Payment Integration:** Complex but essential for market fit in Vietnamese context

**Timeline Realism:** ✅ **Achievable** 
- 4 epics properly sequenced for 4-6 month MVP timeline
- Story sizing appropriate for AI agent execution (2-4 hour completion windows)
- Technical assumptions realistic given Flutter + Laravel stack

### Technical Readiness

**Architecture Clarity:** ✅ **Excellent**
- Clear monorepo structure with microservices approach
- Vietnamese payment gateway priorities established
- Performance targets specific and measurable
- Security and compliance requirements well-defined

**Technical Risk Areas Identified:**
- Vietnamese payment gateway integration complexity
- Real-time notification delivery reliability 
- Flutter performance on diverse Vietnamese device ecosystem
- SMS provider integration for phone-based registration

### Recommendations

**Before Architecture Phase:**
1. **Validate Payment Gateway APIs:** Architect should begin with proof-of-concept integrations for Momo, VietQR
2. **Performance Baseline Research:** Establish Flutter performance benchmarks on target Vietnamese devices
3. **SMS Provider Selection:** Research and select Vietnamese SMS provider for registration workflow

**PRD Enhancements (Optional):**
- Add specific data retention policies for financial transaction records
- Include more detailed offline functionality requirements for attendance responses
- Expand monitoring requirements section with Vietnamese network-specific metrics

**Next Steps:**
1. **UX Expert Handoff:** PRD ready for UI/UX specification creation
2. **Architect Handoff:** All technical constraints and assumptions clearly documented
3. **Stakeholder Review:** PRD suitable for final stakeholder approval before development

### Final Decision

✅ **READY FOR ARCHITECT**: The PRD and epics are comprehensive, properly structured, and ready for architectural design. Technical guidance is clear, MVP scope is well-balanced, and Vietnamese market requirements are thoroughly addressed.

## Next Steps

### UX Expert Prompt

Review this PRD thoroughly và create comprehensive UI/UX specification cho Go Sport App. Focus on Vietnamese cultural preferences, mobile-first design patterns, và role-based interface variations. Ensure all user journeys from brainstorming session are addressed với particular attention to attendance flow optimization và payment transparency.

### Architect Prompt

Create detailed technical architecture for Go Sport App using this PRD as foundation. Design scalable Flutter + Laravel system supporting Vietnamese payment integrations, real-time notifications, và role-based access control. Prioritize MVP implementation feasibility while planning for post-MVP feature expansion outlined trong project brief.
