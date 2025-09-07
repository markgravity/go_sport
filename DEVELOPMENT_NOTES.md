# 🔧 Go Sport - Development Notes

## ⚠️ IMPORTANT: Backend Development Setup

### **Laravel Sail is REQUIRED**
The backend uses **Laravel Sail** (Docker-based development environment), NOT `php artisan serve`.

### ✅ Correct Backend Commands:
```bash
# Start Laravel Sail (from /api directory)
cd /Users/markg/Repositories/Personal/go_sport/api
./vendor/bin/sail up -d

# Stop Laravel Sail
./vendor/bin/sail down

# View logs
./vendor/bin/sail logs

# Run migrations
./vendor/bin/sail artisan migrate

# Clear cache
./vendor/bin/sail artisan cache:clear
```

### ❌ DO NOT USE:
```bash
# These commands will NOT work properly:
php artisan serve  # ❌ Wrong - Don't use this
php artisan migrate  # ❌ Wrong - Use sail instead
```

### 📍 API Base URLs:
- **Laravel Sail**: `http://localhost/api` (Port 80)
- **NOT**: `http://localhost:8000/api` (This is for artisan serve which we DON'T use)

---

## 🚀 Quick Start Guide

### 1. Start Backend (Laravel Sail)
```bash
cd api
./vendor/bin/sail up -d
```

### 2. Start Flutter App
```bash
cd mobile
flutter run
```

### 3. Verify Services
- Backend API: http://localhost/api/health
- Database: MySQL on port 3306 (via Sail)
- Redis: Port 6379 (via Sail)

---

## 🔑 Authentication Flow

### Token Management
- **Storage**: Flutter Secure Storage
- **Header Format**: `Authorization: Bearer {token}`
- **Interceptor**: `AuthInterceptor` automatically adds tokens to requests
- **Token Location**: Stored with key `auth_token`

### Protected vs Public Endpoints
**Public Endpoints** (no auth required):
- `/health`
- `/auth/*` (login, register, etc.)
- `/sports/*` (sports configuration)
- `/images/default-avatars`

**Protected Endpoints** (auth required):
- `/groups/*` ✅
- `/user/*` ✅
- `/payments/*` ✅
- `/attendance/*` ✅
- `/notifications/*` ✅

---

## 🐛 Recent Fixes

### 1. Authentication 401 Error (Fixed)
- **Issue**: Groups API returning 401 Unauthorized
- **Cause**: Missing authentication headers
- **Solution**: Created `AuthInterceptor` to automatically add Bearer tokens

### 2. PHP Syntax Error (Fixed)
- **Issue**: 500 error - Unclosed '{' in Group.php model
- **Cause**: Match statement had `];` instead of `};`
- **Solution**: Fixed syntax on line 153 of Group.php

---

## 📂 Project Structure

### Backend (Laravel + Sail)
```
/api
├── vendor/bin/sail      # Sail executable
├── docker-compose.yml   # Docker configuration
├── .env                 # Environment variables
└── app/
    ├── Models/         # Eloquent models
    ├── Http/Controllers/Api/  # API controllers
    └── Services/       # Business logic
```

### Frontend (Flutter)
```
/mobile
├── lib/
│   ├── core/
│   │   ├── network/
│   │   │   ├── api_client.dart
│   │   │   └── interceptors/
│   │   │       ├── auth_interceptor.dart ✨ NEW
│   │   │       ├── error_interceptor.dart
│   │   │       └── logging_interceptor.dart
│   ├── features/
│   │   ├── auth/
│   │   └── groups/
```

---

## 🌍 Vietnamese Localization

### Language Settings
- **Primary Language**: Vietnamese (vi-VN)
- **Error Messages**: All in Vietnamese
- **UI Text**: Vietnamese with proper diacritics
- **Date/Time Format**: Vietnamese format (dd/MM/yyyy)

### Common Vietnamese Terms Used:
- Nhóm = Group
- Thành viên = Member
- Môn thể thao = Sport type
- Cầu lông = Badminton
- Bóng đá = Football
- Đăng nhập = Login
- Đăng ký = Register
- Tham gia = Join
- Rời khỏi = Leave

---

## 🔐 Environment Variables

### Required .env Variables (Backend)
```env
APP_URL=http://localhost
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=go_sport
DB_USERNAME=sail
DB_PASSWORD=password
```

### Flutter Configuration
- Base URL configured in `api_client.dart`
- Currently set to: `http://localhost/api`

---

## 💡 Development Tips

### 1. Always Use Sail for Backend
```bash
# Good practice - create alias
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
```

### 2. Check Sail Status
```bash
./vendor/bin/sail ps  # Check running containers
```

### 3. Database Access
```bash
./vendor/bin/sail mysql  # Access MySQL CLI
```

### 4. Clear All Caches
```bash
./vendor/bin/sail artisan config:clear
./vendor/bin/sail artisan cache:clear
./vendor/bin/sail artisan route:clear
```

### 5. Flutter Hot Reload
- Press `r` for hot reload
- Press `R` for hot restart
- Press `q` to quit

---

## 📝 TODO & Known Issues

### High Priority
- [ ] Add token refresh mechanism
- [ ] Implement biometric authentication
- [ ] Add offline mode support

### Medium Priority
- [ ] Improve error handling for network issues
- [ ] Add loading states for all API calls
- [ ] Implement pagination for groups list

### Low Priority
- [ ] Add unit tests for auth interceptor
- [ ] Optimize image loading
- [ ] Add app performance monitoring

---

## 🆘 Troubleshooting

### Issue: "Connection refused" on API calls
**Solution**: Make sure Laravel Sail is running:
```bash
cd api && ./vendor/bin/sail up -d
```

### Issue: 401 Unauthorized on protected endpoints
**Solution**: Check if auth token exists and is valid:
```dart
// In Flutter debug console
final token = await FlutterSecureStorage().read(key: 'auth_token');
print('Token: $token');
```

### Issue: PHP syntax errors
**Solution**: Check Laravel logs:
```bash
./vendor/bin/sail logs
```

---

**Last Updated**: 2025-09-07
**Important**: ALWAYS use Laravel Sail for backend development!