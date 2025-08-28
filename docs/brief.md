# Project Brief: Go Sport App

## Executive Summary

**Go Sport** là mobile app quản lý nhóm thể thao giúp tự động hóa quy trình điểm danh, thông báo và chia tiền sân cho các nhóm chơi cầu lông, pickleball và bóng đá. App giải quyết vấn đề quản lý thành viên thủ công, thiếu transparency trong thanh toán, và khó khăn khi cần tìm người chơi bổ sung từ nhóm khác.

Target users là các nhóm trưởng và thành viên nhóm thể thao nghiệp dư tại Việt Nam, với value proposition chính là **"One-tap attendance to automatic payment splitting"** - từ điểm danh đến chia tiền hoàn toàn tự động.

## Problem Statement

**Current State & Pain Points:**

Các nhóm thể thao nghiệp dư hiện tại đang quản lý thành viên thông qua các tools không chuyên biệt (Facebook groups, WhatsApp, Excel sheets), dẫn đến:

1. **Điểm danh thủ công không hiệu quả:** Nhóm trưởng phải manually ping từng người, collect responses scattered across platforms, và tính toán xem có đủ người chơi không
2. **Bất cập trong quản lý tài chính:** Chia tiền sân và cầu thủ công, thiếu transparency, khó track ai đã trả/chưa trả
3. **Khó khăn kết nối inter-group:** Khi thiếu người, phải manually liên hệ các nhóm khác, không có visibility về availability của nhóm khác

**Impact Quantification:**
- 30-45 phút setup time cho mỗi buổi đánh (thay vì 5-10 phút)
- 15-20% games bị cancel vì coordination issues
- Financial disputes và lack of transparency gây tension trong group

**Why Existing Solutions Fall Short:**
- Generic group management tools không có sport-specific workflows
- Payment apps thiếu integration với attendance management
- Không có cross-group networking capabilities

**Urgency:** Post-COVID, sports communities đang grow rapidly, nhưng management tools chưa theo kịp nhu cầu organization.

## Proposed Solution

**Core Concept:**

Go Sport App tạo ra **unified ecosystem** cho group sports management thông qua mobile-first platform với 4 core capabilities:

1. **Smart Attendance System:** Customizable notifications → One-tap responses → Automatic headcount → Post-deadline change handling
2. **Flexible Role Management:** 4-tier permissions (Trưởng/Phó/Thành viên/Khách) với unified invitation system (link + SĐT)
3. **Integrated Payment Flow:** Attendance list → QR-based cost splitting → Multi-gateway support (Momo/Banking/ZaloPay)
4. **Inter-Group Networking:** Guest access system cho cross-group visibility và collaboration

**Key Differentiators:**

- **End-to-end automation:** Từ notification đến payment trong single workflow
- **Vietnamese-optimized:** Phone-based registration, local payment methods, Vietnamese UX patterns
- **Community-centric:** Inter-group features tạo network effects thay vì isolated group silos
- **Flexible by design:** Leaders control timing, rules, permissions thay vì rigid templates

**Why This Solution Will Succeed:**

Existing solutions tackle pieces (group chat, payment apps, scheduling tools) nhưng Go Sport addresses **complete workflow** với sport-specific optimizations. Technical foundation (Flutter + Laravel) ensures reliable performance while Vietnamese market focus allows deep localization.

**High-level Vision:**

Transform Vietnamese sports communities từ fragmented manual coordination thành connected, efficient ecosystems where organizing games takes minutes, not hours.

## Target Users

### Primary User Segment: Group Leaders (Nhóm trưởng + Phó nhóm)

**Demographic Profile:**
- Age: 25-45, predominantly male
- Location: Urban Vietnam (HCMC, Hanoi, major cities)
- Income: Middle class, stable employment
- Tech comfort: Smartphone native, uses banking apps, social media active

**Current Behaviors & Workflows:**
- Manually coordinate 2-4 games per week via WhatsApp/Facebook
- Spend 30-45 minutes per session on logistics (attendance, payment, venue)
- Act as financial intermediary - collect money, pay venues, track balances
- Maintain relationships with other group leaders for backup players

**Specific Needs & Pain Points:**
- Time efficiency: Reduce coordination overhead
- Financial transparency: Clear payment tracking to avoid disputes
- Reliability: Ensure sufficient players show up
- Authority tools: Manage member permissions and group rules

**Goals They're Trying to Achieve:**
- Consistent, well-organized games with minimal administrative burden
- Happy, engaged group members with no financial tensions
- Flexibility to scale group size up/down based on demand
- Reputation as competent, trustworthy leader in sports community

### Secondary User Segment: Group Members (Thành viên + Khách)

**Demographic Profile:**
- Age: 22-50, mixed gender (sport-dependent)
- Location: Same urban areas as leaders
- Income: Varied, but recreational sports budget allocated
- Tech comfort: Mobile-first, notification-responsive

**Current Behaviors & Workflows:**
- Respond to leader requests via multiple channels
- Often unclear about payment amounts/timing
- May participate in multiple groups simultaneously
- Prefer simple, quick interactions over complex workflows

**Specific Needs & Pain Points:**
- Clarity: Know exact costs, timing, attendance requirements
- Convenience: Quick responses, minimal app-switching
- Fairness: Transparent cost-splitting, no hidden charges
- Flexibility: Easy to indicate availability, change plans

**Goals They're Trying to Achieve:**
- Participate in sports consistently without coordination hassles
- Fair cost sharing with clear visibility
- Maintain relationships within sports community
- Balance sports commitments with other life priorities

## Goals & Success Metrics

### Business Objectives
- **User Acquisition:** 500+ active groups within 6 months, 5,000+ registered users
- **Engagement:** 70%+ weekly active rate among group leaders, 50%+ among members  
- **Revenue:** Break-even on operational costs within 12 months through premium features
- **Market Penetration:** 15% market share among organized recreational sports groups in HCMC/Hanoi

### User Success Metrics
- **Time Efficiency:** Average coordination time reduced from 35 minutes to <10 minutes per session
- **Game Consistency:** 90%+ of scheduled games proceed as planned (vs. current ~80-85%)
- **Financial Transparency:** <5% payment disputes reported per month per group
- **Inter-group Network:** 30%+ of groups use guest access feature monthly

### Key Performance Indicators (KPIs)

- **Daily Active Groups:** Number of groups using attendance feature daily
- **Notification Response Rate:** Percentage of members responding to attendance requests within 2 hours
- **Payment Completion Rate:** Percentage of payment splits completed within 24 hours
- **User Retention:** Monthly cohort retention rates for both leaders and members
- **Cross-group Engagement:** Monthly active guest users across different groups
- **Support Ticket Volume:** Customer service requests per 1,000 active users (target: <50)

## MVP Scope

### Core Features (Must Have)

- **Smart Attendance System:** Customizable notification timing và deadline, basic ✅/❌ response options, automatic headcount calculation, post-deadline change notifications to group
- **Role-based Permission System:** 4-tier access control (Trưởng/Phó/Thành viên/Khách), unified invitation system qua link hoặc SĐT với approval workflow và dynamic role assignment
- **Basic Payment QR Integration:** Generate QR codes cho cost splitting dựa trên attendance list, support multiple Vietnamese payment methods (Momo/Banking/ZaloPay), basic payment tracking UI
- **Inter-Group Guest System:** Guest access với view-only permissions, persistent invitation links, multi-group guest membership capability

### Out of Scope for MVP

- Advanced attendance options (đến trễ, có thể đến) - Phase 1.1
- Weather integration và smart notifications - Version 2.0+
- Tournament management features
- In-app messaging/chat functionality
- Advanced analytics và reporting dashboards
- Venue booking integration
- Multi-language support (Vietnamese only for MVP)

### MVP Success Criteria

MVP được considered successful khi:
- **Functional completeness:** All 4 core features working end-to-end without critical bugs
- **User adoption:** 50+ active groups using the platform within 3 months post-launch
- **Workflow efficiency:** Average time từ attendance notification đến payment QR generation <5 minutes
- **Technical stability:** 99%+ uptime, <3 second average response time
- **User satisfaction:** 4.0+ average rating trên app stores với minimum 100 reviews

## Post-MVP Vision

### Phase 2 Features

**Version 1.1 (3-6 months post-MVP):**
- Advanced attendance options với leader-controlled toggles (đến trễ, có thể đến)
- Enhanced guest invitation system với member-initiated invites and approval workflow
- Basic analytics dashboard cho group leaders (attendance patterns, payment history)
- Push notification optimizations và reminder system improvements

**Version 1.2 (6-9 months post-MVP):**
- Premium subscription tier với advanced features
- Cross-platform sync (basic web dashboard cho group management)
- Improved payment tracking với expense history và member financial profiles
- Group templates và settings backup/restore functionality

### Long-term Vision

**Year 1-2 Roadmap:**
Transform Go Sport thành **comprehensive sports community platform** cho recreational athletes. Key expansions include:

- **Smart automation:** Weather-integrated notifications, AI-driven attendance predictions, automatic venue suggestions based on group patterns
- **Community networking:** Public group directory, inter-group tournaments, skill-based matching for pickup games
- **Venue partnerships:** Direct booking integration với sports facilities, exclusive discounts cho active groups
- **Performance tracking:** Individual và group statistics, achievement systems, social features around sports milestones

### Expansion Opportunities

**Geographic Expansion:**
- Phase 1: Ho Chi Minh City, Hanoi validation
- Phase 2: Secondary cities (Da Nang, Can Tho, Hai Phong)
- Phase 3: Regional expansion (Thailand, Malaysia, Philippines)

**Sports Expansion:**
- Additional racquet sports (tennis, squash)
- Team sports (volleyball, basketball)
- Individual sports communities (running clubs, cycling groups)

**Platform Evolution:**
- Corporate team building packages
- Youth sports league management
- Integration với fitness tracking apps (Strava, MyFitnessPal)
- Marketplace for sports equipment trading within communities

## Technical Considerations

### Platform Requirements
- **Target Platforms:** iOS và Android native apps via Flutter framework
- **Minimum OS Support:** iOS 12+, Android 8.0+ (API level 26)
- **Performance Requirements:** <3 second app launch, <2 second notification-to-response time, offline-first architecture cho critical functions

### Technology Preferences
- **Frontend:** Flutter với Dart language cho cross-platform mobile development, state management via Provider/Riverpod
- **Backend:** Laravel PHP framework với REST API architecture, queue system cho background notification processing
- **Database:** MySQL cho relational data, Redis cho caching và session management
- **Hosting/Infrastructure:** AWS/Digital Ocean với auto-scaling capabilities, CDN cho static assets

### Architecture Considerations
- **Repository Structure:** Monorepo setup với separate folders: `/mobile-app` (Flutter), `/api` (Laravel), `/shared` (common assets/docs)
- **Service Architecture:** Microservices approach - separate services cho user management, notification system, payment processing
- **Integration Requirements:** 
  - Vietnamese payment gateways (Momo, VietQR, ZaloPay APIs)
  - Push notification services (Firebase Cloud Messaging)
  - SMS service cho phone-based registration (Twilio/local providers)
- **Security/Compliance:** 
  - JWT authentication với refresh tokens
  - End-to-end encryption cho financial data
  - GDPR-compliant data handling (user data export/deletion)
  - Vietnamese data localization requirements compliance

## Constraints & Assumptions

### Constraints

- **Budget:** Bootstrap/self-funded development với limited runway, targeting break-even within 12 months, initial investment focus on development costs over marketing spend
- **Timeline:** 4-6 months MVP development timeline, 3-month market validation period, aggressive but realistic launch schedule
- **Resources:** Small development team (2-3 developers), single product manager/owner, limited QA resources requiring automated testing focus
- **Technical:** Vietnamese banking API limitations và approval processes, iOS App Store và Google Play compliance requirements, potential government regulatory restrictions on financial features

### Key Assumptions

- Vietnamese smartphone users willing to adopt new app cho sports coordination (vs. existing WhatsApp/Facebook habits)
- Group leaders motivated enough về time savings để drive adoption across their members
- Payment gateway integrations technically feasible with reasonable development effort và ongoing costs
- Sports groups have sufficient size và frequency để justify app-based coordination (vs. informal methods)
- Inter-group networking creates meaningful value và competitive differentiation
- Flutter framework remains stable và performant cho production mobile app at scale
- Vietnamese regulatory environment allows financial transaction facilitation without banking license
- Target demographic has reliable internet connectivity cho real-time attendance coordination
