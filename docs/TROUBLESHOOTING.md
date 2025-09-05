# Go Sport Troubleshooting Guide
## Hướng dẫn khắc phục sự cố Go Sport

*Available in: [English](#english) | [Tiếng Việt](#vietnamese)*

---

## <a name="english"></a>🇺🇸 English

### Common Docker Issues

#### 1. Docker not running

**Problem:** `Cannot connect to the Docker daemon`

**Solution:**
```bash
# Start Docker Desktop application
# Or start Docker service on Linux
sudo systemctl start docker
```

#### 2. Port conflicts

**Problem:** `Port 8000/3306/6379 is already in use`

**Solution:**
```bash
# Find and kill process using the port
sudo lsof -i :8000
sudo kill -9 <PID>

# Or change ports in docker-compose.yml
```

#### 3. Permission issues

**Problem:** `Permission denied` errors

**Solution:**
```bash
# Fix file permissions
sudo chown -R $USER:$USER ./api
chmod +x ./scripts/dev.sh

# On Linux, add user to docker group
sudo usermod -aG docker $USER
```

#### 4. Database connection fails

**Problem:** `SQLSTATE[HY000] [2002] Connection refused`

**Solution:**
```bash
# Wait for MySQL to be ready
./scripts/dev.sh status

# Restart services
./scripts/dev.sh restart

# Check MySQL logs
./scripts/dev.sh logs mysql
```

#### 5. Composer/NPM package issues

**Problem:** Packages not installing or version conflicts

**Solution:**
```bash
# Clear Composer cache
./scripts/dev.sh composer clear-cache
./scripts/dev.sh composer install

# Reset composer.lock
rm api/composer.lock
./scripts/dev.sh composer install
```

### Flutter Issues

#### 1. Flutter doctor issues

**Problem:** Flutter doctor shows issues

**Solution:**
```bash
# Run Flutter doctor
flutter doctor

# Install missing components as suggested
# Accept Android licenses
flutter doctor --android-licenses
```

#### 2. Gradle build failures

**Problem:** Android build fails with Gradle errors

**Solution:**
```bash
# Clean Flutter build
flutter clean
flutter pub get

# Clean Gradle cache
cd android
./gradlew clean
cd ..

# Rebuild
flutter build apk --debug
```

#### 3. iOS build issues (macOS only)

**Problem:** iOS build fails

**Solution:**
```bash
# Clean iOS build
flutter clean
cd ios
rm Podfile.lock
pod deintegrate
pod install
cd ..

# Rebuild
flutter build ios
```

#### 4. Hot reload not working

**Problem:** Hot reload stops responding

**Solution:**
```bash
# Restart the app
# Press 'R' in terminal for full restart
# Press 'r' for hot reload

# If still not working, stop and restart flutter run
```

#### 5. Network connection issues

**Problem:** App cannot connect to API

**Solution:**
- Ensure API is running: `./scripts/dev.sh status`
- Check API health: `curl http://localhost:8000/api/health`
- Verify device/emulator network settings
- For Android emulator, use `10.0.2.2` instead of `localhost`

### API Issues

#### 1. Migration errors

**Problem:** Migration fails or database schema issues

**Solution:**
```bash
# Reset database
./scripts/dev.sh artisan migrate:fresh --seed

# Check migration status
./scripts/dev.sh artisan migrate:status

# Rollback and re-run
./scripts/dev.sh artisan migrate:rollback
./scripts/dev.sh artisan migrate
```

#### 2. Cache issues

**Problem:** Changes not reflected or old data showing

**Solution:**
```bash
# Clear all caches
./scripts/dev.sh artisan cache:clear
./scripts/dev.sh artisan config:clear
./scripts/dev.sh artisan route:clear
./scripts/dev.sh artisan view:clear

# Restart services
./scripts/dev.sh restart
```

#### 3. Queue not processing

**Problem:** Background jobs not running

**Solution:**
```bash
# Check queue worker status
./scripts/dev.sh logs queue

# Restart queue worker
docker-compose restart queue

# Process jobs manually
./scripts/dev.sh artisan queue:work --once
```

### Performance Issues

#### 1. Slow API responses

**Diagnosis:**
```bash
# Check service resources
docker stats

# Check API logs
./scripts/dev.sh logs app

# Check database queries
# Enable query logging in Laravel
```

**Solutions:**
- Increase Docker memory allocation
- Optimize database queries
- Enable Redis caching
- Add database indexes

#### 2. Flutter app performance

**Diagnosis:**
```bash
# Run performance profiling
flutter run --profile

# Check for memory leaks
flutter drive --profile test_driver/perf.dart
```

**Solutions:**
- Optimize widget rebuilds
- Use proper state management
- Implement lazy loading
- Optimize image assets

### Development Environment Reset

If all else fails, reset the entire development environment:

```bash
# Complete reset
./scripts/dev.sh clean

# Remove Flutter build files
cd mobile
flutter clean
rm -rf .dart_tool/
rm -rf build/

# Restart from scratch
cd ..
./scripts/dev.sh start
cd mobile
flutter pub get
flutter run
```

---

## <a name="vietnamese"></a>🇻🇳 Tiếng Việt

### Sự cố Docker thường gặp

#### 1. Docker không chạy

**Vấn đề:** `Cannot connect to the Docker daemon`

**Giải pháp:**
```bash
# Khởi động ứng dụng Docker Desktop
# Hoặc khởi động Docker service trên Linux
sudo systemctl start docker
```

#### 2. Xung đột cổng

**Vấn đề:** `Port 8000/3306/6379 is already in use`

**Giải pháp:**
```bash
# Tìm và dừng tiến trình sử dụng cổng
sudo lsof -i :8000
sudo kill -9 <PID>

# Hoặc thay đổi cổng trong docker-compose.yml
```

#### 3. Vấn đề quyền truy cập

**Vấn đề:** Lỗi `Permission denied`

**Giải pháp:**
```bash
# Sửa quyền file
sudo chown -R $USER:$USER ./api
chmod +x ./scripts/dev.sh

# Trên Linux, thêm user vào docker group
sudo usermod -aG docker $USER
```

#### 4. Kết nối database thất bại

**Vấn đề:** `SQLSTATE[HY000] [2002] Connection refused`

**Giải pháp:**
```bash
# Đợi MySQL sẵn sàng
./scripts/dev.sh status

# Khởi động lại services
./scripts/dev.sh restart

# Kiểm tra logs MySQL
./scripts/dev.sh logs mysql
```

#### 5. Vấn đề Composer/NPM packages

**Vấn đề:** Packages không cài đặt hoặc xung đột version

**Giải pháp:**
```bash
# Xóa cache Composer
./scripts/dev.sh composer clear-cache
./scripts/dev.sh composer install

# Reset composer.lock
rm api/composer.lock
./scripts/dev.sh composer install
```

### Sự cố Flutter

#### 1. Vấn đề Flutter doctor

**Vấn đề:** Flutter doctor hiển thị lỗi

**Giải pháp:**
```bash
# Chạy Flutter doctor
flutter doctor

# Cài đặt components thiếu theo gợi ý
# Chấp nhận Android licenses
flutter doctor --android-licenses
```

#### 2. Gradle build thất bại

**Vấn đề:** Android build lỗi Gradle

**Giải pháp:**
```bash
# Clean Flutter build
flutter clean
flutter pub get

# Clean Gradle cache
cd android
./gradlew clean
cd ..

# Build lại
flutter build apk --debug
```

#### 3. Vấn đề iOS build (chỉ macOS)

**Vấn đề:** iOS build thất bại

**Giải pháp:**
```bash
# Clean iOS build
flutter clean
cd ios
rm Podfile.lock
pod deintegrate
pod install
cd ..

# Build lại
flutter build ios
```

#### 4. Hot reload không hoạt động

**Vấn đề:** Hot reload ngừng phản hồi

**Giải pháp:**
```bash
# Khởi động lại app
# Nhấn 'R' trong terminal để restart hoàn toàn
# Nhấn 'r' để hot reload

# Nếu vẫn không hoạt động, dừng và khởi động lại flutter run
```

#### 5. Vấn đề kết nối mạng

**Vấn đề:** App không thể kết nối API

**Giải pháp:**
- Đảm bảo API đang chạy: `./scripts/dev.sh status`
- Kiểm tra API health: `curl http://localhost:8000/api/health`
- Kiểm tra cài đặt mạng của thiết bị/emulator
- Với Android emulator, dùng `10.0.2.2` thay vì `localhost`

### Sự cố API

#### 1. Lỗi Migration

**Vấn đề:** Migration thất bại hoặc lỗi database schema

**Giải pháp:**
```bash
# Reset database
./scripts/dev.sh artisan migrate:fresh --seed

# Kiểm tra trạng thái migration
./scripts/dev.sh artisan migrate:status

# Rollback và chạy lại
./scripts/dev.sh artisan migrate:rollback
./scripts/dev.sh artisan migrate
```

#### 2. Vấn đề Cache

**Vấn đề:** Thay đổi không được phản ánh hoặc hiển thị dữ liệu cũ

**Giải pháp:**
```bash
# Xóa tất cả cache
./scripts/dev.sh artisan cache:clear
./scripts/dev.sh artisan config:clear
./scripts/dev.sh artisan route:clear
./scripts/dev.sh artisan view:clear

# Khởi động lại services
./scripts/dev.sh restart
```

#### 3. Queue không xử lý

**Vấn đề:** Background jobs không chạy

**Giải pháp:**
```bash
# Kiểm tra trạng thái queue worker
./scripts/dev.sh logs queue

# Khởi động lại queue worker
docker-compose restart queue

# Xử lý jobs thủ công
./scripts/dev.sh artisan queue:work --once
```

### Vấn đề hiệu suất

#### 1. API phản hồi chậm

**Chẩn đoán:**
```bash
# Kiểm tra tài nguyên services
docker stats

# Kiểm tra logs API
./scripts/dev.sh logs app

# Kiểm tra database queries
# Bật query logging trong Laravel
```

**Giải pháp:**
- Tăng memory allocation cho Docker
- Tối ưu database queries
- Bật Redis caching
- Thêm database indexes

#### 2. Hiệu suất ứng dụng Flutter

**Chẩn đoán:**
```bash
# Chạy performance profiling
flutter run --profile

# Kiểm tra memory leaks
flutter drive --profile test_driver/perf.dart
```

**Giải pháp:**
- Tối ưu widget rebuilds
- Sử dụng state management phù hợp
- Implement lazy loading
- Tối ưu image assets

### Reset môi trường phát triển

Nếu tất cả đều thất bại, reset toàn bộ môi trường phát triển:

```bash
# Reset hoàn toàn
./scripts/dev.sh clean

# Xóa Flutter build files
cd mobile
flutter clean
rm -rf .dart_tool/
rm -rf build/

# Khởi động lại từ đầu
cd ..
./scripts/dev.sh start
cd mobile
flutter pub get
flutter run
```