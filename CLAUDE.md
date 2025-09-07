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

## 🚨 Remember
- **SAIL = Production-like Docker environment**
- **All backend commands must use `./vendor/bin/sail` prefix**
- **API runs on port 80, not 8000**
- **Vietnamese localization is primary language**