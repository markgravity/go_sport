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

## 🚨 Remember
- **SAIL = Production-like Docker environment**
- **All backend commands must use `./vendor/bin/sail` prefix**
- **API runs on port 80, not 8000**
- **Vietnamese localization is primary language**
- **ALWAYS validate Flutter changes in iOS Simulator with video recording**
- **Use MCP tools for interactive simulator testing**
- **Commands in the whitelist can be run without confirmation**