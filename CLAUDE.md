# 🤖 Claude AI Assistant Notes

## ⚠️ CRITICAL: Backend Setup

### **ALWAYS USE LARAVEL SAIL** - NOT php artisan serve!

```bash
# ✅ CORRECT - Use Laravel Sail
cd api && ./vendor/bin/sail up -d
./vendor/bin/sail artisan migrate
./vendor/bin/sail artisan cache:clear

# ❌ WRONG - Don't use these
php artisan serve  # NO!
php artisan migrate  # NO!
```

### API Base URL
- **Sail URL**: `http://localhost/api` (Port 80)
- **NOT**: `http://localhost:8000/api`

---

## 🔧 Quick Commands

### Start Development
```bash
# Backend (Sail)
cd api && ./vendor/bin/sail up -d

# Frontend (Flutter) 
cd mobile && flutter run
```

### Check Services
```bash
# Sail status
cd api && ./vendor/bin/sail ps

# API health
curl http://localhost/api/health
```

### Common Fixes
```bash
# Clear Laravel cache
./vendor/bin/sail artisan config:clear
./vendor/bin/sail artisan cache:clear

# Restart Sail
./vendor/bin/sail down && ./vendor/bin/sail up -d
```

---

## 📝 Recent Work Log

### 2025-09-07
- ✅ Fixed 401 authentication error by adding AuthInterceptor
- ✅ Fixed PHP syntax error in Group.php model (match statement)
- ✅ Created comprehensive development documentation
- ✅ Verified Laravel Sail is the required backend setup

### Key Files Modified
- `/mobile/lib/core/network/interceptors/auth_interceptor.dart` (Created)
- `/mobile/lib/core/network/api_client.dart` (Added auth interceptor)
- `/api/app/Models/Group.php` (Fixed syntax error line 153)

---

## 📱 iOS Simulator Validation

### **MANDATORY: Validate All Flutter Changes in iOS Simulator**

After implementing any Flutter/mobile feature:

1. **Start iOS Simulator validation**
```bash
# Get the booted simulator ID
mcp__ios-simulator__get_booted_sim_id

# Start video recording for documentation
mcp__ios-simulator__record_video --output_path "validation_$(date +%Y%m%d_%H%M%S).mp4"

# Take initial screenshot
mcp__ios-simulator__ui_view
```

2. **Interactive Testing Process**
- Use `mcp__ios-simulator__ui_describe_all` to understand current screen
- Navigate using `mcp__ios-simulator__ui_tap` with coordinates
- Input text with `mcp__ios-simulator__ui_type`
- Perform gestures with `mcp__ios-simulator__ui_swipe`
- Validate each feature implementation step-by-step

3. **Document Results**
```bash
# Stop recording when validation complete
mcp__ios-simulator__stop_recording

# Take final screenshot for documentation
mcp__ios-simulator__screenshot --output_path "validation_complete.png"
```

### Validation Checklist
- ✅ UI renders correctly
- ✅ User interactions work as expected
- ✅ Navigation flows properly
- ✅ Data displays accurately
- ✅ Error states handle gracefully
- ✅ Vietnamese localization displays correctly

### Example Validation Flow
```bash
# After implementing a new feature
cd mobile && flutter run

# Start recording
mcp__ios-simulator__record_video

# Navigate to the feature
mcp__ios-simulator__ui_tap --x 100 --y 200

# Test text input
mcp__ios-simulator__ui_type --text "Test input"

# Verify screen content
mcp__ios-simulator__ui_describe_all

# Stop recording when done
mcp__ios-simulator__stop_recording
```

---

## ✅ Command Whitelist (No Confirmation Required)

### These commands can be run without user confirmation:

#### Laravel/Backend Commands
- `cd api && ./vendor/bin/sail up -d`
- `cd api && ./vendor/bin/sail down`
- `cd api && ./vendor/bin/sail ps`
- `cd api && ./vendor/bin/sail artisan migrate`
- `cd api && ./vendor/bin/sail artisan migrate:status`
- `cd api && ./vendor/bin/sail artisan migrate:rollback`
- `cd api && ./vendor/bin/sail artisan cache:clear`
- `cd api && ./vendor/bin/sail artisan config:clear`
- `cd api && ./vendor/bin/sail artisan route:list`
- `cd api && ./vendor/bin/sail artisan tinker`
- `cd api && ./vendor/bin/sail test`
- `cd api && ./vendor/bin/sail composer install`
- `cd api && ./vendor/bin/sail composer update`
- `cd api && ./vendor/bin/sail logs`

#### Flutter/Mobile Commands
- `cd mobile && flutter run`
- `cd mobile && flutter build ios`
- `cd mobile && flutter build apk`
- `cd mobile && flutter clean`
- `cd mobile && flutter pub get`
- `cd mobile && flutter pub upgrade`
- `cd mobile && flutter analyze`
- `cd mobile && flutter test`
- `cd mobile && flutter doctor`
- `cd mobile && dart analyze`
- `cd mobile && dart fix --apply`
- `cd mobile && dart format .`
- `cd mobile && dart run build_runner build`
- `cd mobile && dart run build_runner watch`
- `cd mobile && dart run build_runner build --delete-conflicting-outputs`

#### iOS Simulator Commands
- All `mcp__ios-simulator__*` commands
- `xcrun simctl list`
- `xcrun simctl boot`
- `xcrun simctl shutdown`
- `open -a Simulator`

#### Git Commands (Read-Only)
- `git status`
- `git diff`
- `git log`
- `git branch`
- `git remote -v`
- `git show`

#### File System Commands (Read-Only)
- `ls`
- `pwd`
- `find`
- `grep`
- `cat`
- `head`
- `tail`
- `tree`

#### Testing & Validation
- `curl http://localhost/api/health`
- `curl http://localhost/api/*` (any API endpoint)

### ⚠️ Commands Requiring Confirmation
- Any `rm` or delete operations
- `git push`
- `git merge`
- `git reset`
- Database drop/truncate operations
- Production deployments
- Environment file modifications
- Any command not in the whitelist above

---

## ⚡ GOD MODE - Continuous Development Workflow

### 🔥 **ACTIVATION**: When user says "Enter God Mode" or "God Mode ON"

In God Mode, the dev agent works continuously without stopping until explicitly interrupted by the user.

### **THE ETERNAL LOOP**:

```
1. PICK TASK → 2. IMPLEMENT → 3. ANALYZE & FIX → 4. BUILD & VALIDATE → 5. COMMIT → BACK TO STEP 1
```

#### **STEP 1: PICK TASK**
- Check existing todos or ask user for task priority
- Select highest priority task from backlog
- Mark task as `in_progress` in TodoWrite
- **NEVER wait for confirmation** - just start working

#### **STEP 2: IMPLEMENT**
- Write/modify code to complete the task
- Follow existing code patterns and conventions
- Implement according to Acceptance Criteria (ACs)
- **No confirmation needed** - implement immediately

#### **STEP 3: ANALYZE & FIX** (MANDATORY)
```bash
cd mobile && flutter analyze
```
- Fix ALL errors (red) - **BLOCKING**
- Fix ALL warnings (yellow) - **BLOCKING** 
- Fix ALL info (blue) - **REQUIRED**
- Re-run `flutter analyze` until **ZERO ISSUES**
- **DO NOT PROCEED** until analysis is clean

#### **STEP 4: BUILD & VALIDATE** (MANDATORY)
```bash
# Build the app
cd mobile && flutter run

# Start validation recording
mcp__ios-simulator__record_video --output_path "godmode_validation_$(date +%Y%m%d_%H%M%S).mp4"

# Validate EVERY Acceptance Criteria
mcp__ios-simulator__ui_view                    # Screenshot current state
mcp__ios-simulator__ui_describe_all           # Understand UI elements
mcp__ios-simulator__ui_tap --x X --y Y        # Navigate/interact
mcp__ios-simulator__ui_type --text "..."      # Input testing
mcp__ios-simulator__ui_swipe --x_start X1 --y_start Y1 --x_end X2 --y_end Y2

# Stop recording when validation complete
mcp__ios-simulator__stop_recording
```

#### **VALIDATION CRITERIA**:
- ✅ All Acceptance Criteria must be met
- ✅ UI renders correctly
- ✅ User interactions work
- ✅ Data flows properly
- ✅ Error handling works
- ✅ Vietnamese localization displays

#### **IF VALIDATION FAILS**:
- **GO BACK TO STEP 2** - Fix implementation
- Repeat Steps 2→3→4 until ALL ACs pass
- **NEVER mark task complete** until validation succeeds

#### **STEP 5: COMMIT** (MANDATORY)
```bash
# Add all changes
git add .

# Create commit with task description
git commit -m "feat: [task description]

🤖 Generated with Claude Code in God Mode

Co-Authored-By: Claude <noreply@anthropic.com>"
```

#### **WHEN VALIDATION PASSES**:
- Mark current task as `completed` in TodoWrite
- **PROCEED TO STEP 5** - Make commit
- After commit, **IMMEDIATELY GO TO STEP 1** - Pick next task
- **NO BREAKS, NO WAITING** - Continue the loop

### **GOD MODE RULES**:

1. **🚫 NEVER STOP** until user says "Exit God Mode" or "Stop"
2. **🚫 NEVER ASK FOR PERMISSION** - just implement
3. **🚫 NEVER SKIP** flutter analyze - must be clean
4. **🚫 NEVER SKIP** iOS simulator validation
5. **🚫 NEVER MARK COMPLETE** until ACs are validated
6. **🚫 NEVER SKIP** git commit after successful validation
7. **✅ ALWAYS USE** video recording for validation
8. **✅ ALWAYS WORK** from TodoWrite task list
9. **✅ ALWAYS FIX** all analyze issues before building
10. **✅ ALWAYS VALIDATE** every AC in iOS simulator
11. **✅ ALWAYS COMMIT** after validation passes

### **EXIT CONDITIONS**:
- User types "Exit God Mode", "Stop", or "Break"
- User interrupts with new instructions
- Critical error that blocks all progress
- **NEVER stop on your own initiative**

### **GOD MODE STATUS MESSAGES**:
```
🔥 GOD MODE ACTIVE - Task X/Y in progress
⚡ IMPLEMENTING: [task description]  
🔍 ANALYZING: flutter analyze running...
🏗️  BUILDING: flutter run executing...
📱 VALIDATING: Testing AC #1 of 3...
💾 COMMITTING: git commit in progress...
✅ TASK COMPLETE: Moving to next task...
🔄 LOOP ITERATION: 47 tasks completed...
```

---

## 🚨 Remember
- **SAIL = Production-like Docker environment**
- **All backend commands must use `./vendor/bin/sail` prefix**
- **API runs on port 80, not 8000**
- **Vietnamese localization is primary language**
- **ALWAYS validate Flutter changes in iOS Simulator with video recording**
- **Use MCP tools for interactive simulator testing**
- **Commands in the whitelist can be run without confirmation**