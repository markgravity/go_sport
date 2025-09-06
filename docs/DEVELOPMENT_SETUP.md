# Go Sport Development Setup Guide
## Hướng dẫn cài đặt phát triển Go Sport

*Available in: [English](#english) | [Tiếng Việt](#vietnamese)*

---

## <a name="english"></a>🇺🇸 English

### Prerequisites

Before starting development, ensure you have the following installed:

- **Docker Desktop** (v20.0+) - [Download](https://www.docker.com/products/docker-desktop/)
- **Flutter SDK** (v3.19+) - [Installation Guide](https://docs.flutter.dev/get-started/install)
- **Git** - [Download](https://git-scm.com/downloads)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** (for mobile development)
- **Xcode** (macOS only, for iOS development)

### Project Structure

```
go_sport/
├── api/                    # Laravel API backend
├── mobile/            # Flutter mobile application
├── docker/                # Docker configuration files
├── scripts/               # Development utility scripts
├── docs/                  # Project documentation
├── docker-compose.yml     # Docker services configuration
└── README.md
```

### Quick Start

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd go_sport
   ```

2. **Start the development environment:**
   ```bash
   ./scripts/dev.sh start
   ```

3. **Setup Flutter dependencies:**
   ```bash
   cd mobile
   flutter pub get
   ```

4. **Run the Flutter app:**
   ```bash
   flutter run
   ```

### API Development

The Laravel API runs in Docker containers with the following services:

- **API Server**: `http://localhost:8000`
- **MySQL Database**: `localhost:3306`
- **Redis Cache**: `localhost:6379`

#### Available Commands

```bash
# Start all services
./scripts/dev.sh start

# Check service status
./scripts/dev.sh status

# View logs
./scripts/dev.sh logs
./scripts/dev.sh logs app  # specific service

# Run Laravel commands
./scripts/dev.sh artisan migrate
./scripts/dev.sh artisan db:seed
./scripts/dev.sh composer install

# Stop services
./scripts/dev.sh stop

# Clean up (removes all data)
./scripts/dev.sh clean
```

### Mobile Development

The Flutter app connects to the local API server running on Docker.

#### Running the app

```bash
cd mobile

# Install dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Build APK (Android)
flutter build apk

# Build iOS (macOS only)
flutter build ios
```

#### Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Analyze code
flutter analyze
```

### Environment Variables

The project uses Docker environment variables for configuration:

| Variable | Description | Default |
|----------|-------------|---------|
| `DB_HOST` | Database host | `mysql` |
| `DB_DATABASE` | Database name | `go_sport` |
| `DB_USERNAME` | Database user | `go_sport_user` |
| `DB_PASSWORD` | Database password | `go_sport_password` |
| `REDIS_HOST` | Redis host | `redis` |
| `REDIS_PASSWORD` | Redis password | `go_sport_redis_password` |

### Development Workflow

1. **Backend Changes:**
   - Edit files in `api/` directory
   - Changes are automatically reflected (volume mounted)
   - Run migrations: `./scripts/dev.sh artisan migrate`

2. **Frontend Changes:**
   - Edit files in `mobile-app/lib/`
   - Hot reload is enabled in Flutter
   - Restart app if needed: `r` in terminal

3. **Database Changes:**
   - Create migrations: `./scripts/dev.sh artisan make:migration`
   - Run migrations: `./scripts/dev.sh artisan migrate`
   - Seed data: `./scripts/dev.sh artisan db:seed`

---

## <a name="vietnamese"></a>🇻🇳 Tiếng Việt

### Yêu cầu hệ thống

Trước khi bắt đầu phát triển, hãy đảm bảo bạn đã cài đặt:

- **Docker Desktop** (v20.0+) - [Tải về](https://www.docker.com/products/docker-desktop/)
- **Flutter SDK** (v3.19+) - [Hướng dẫn cài đặt](https://docs.flutter.dev/get-started/install)
- **Git** - [Tải về](https://git-scm.com/downloads)
- **Android Studio** hoặc **VS Code** với extensions Flutter
- **Android SDK** (để phát triển mobile)
- **Xcode** (chỉ macOS, để phát triển iOS)

### Cấu trúc dự án

```
go_sport/
├── api/                    # Laravel API backend
├── mobile-app/            # Ứng dụng mobile Flutter
├── docker/                # File cấu hình Docker
├── scripts/               # Scripts hỗ trợ phát triển
├── docs/                  # Tài liệu dự án
├── docker-compose.yml     # Cấu hình Docker services
└── README.md
```

### Bắt đầu nhanh

1. **Sao chép repository:**
   ```bash
   git clone <repository-url>
   cd go_sport
   ```

2. **Khởi động môi trường phát triển:**
   ```bash
   ./scripts/dev.sh start
   ```

3. **Cài đặt dependencies cho Flutter:**
   ```bash
   cd mobile
   flutter pub get
   ```

4. **Chạy ứng dụng Flutter:**
   ```bash
   flutter run
   ```

### Phát triển API

Laravel API chạy trong Docker containers với các services:

- **API Server**: `http://localhost:8000`
- **MySQL Database**: `localhost:3306`
- **Redis Cache**: `localhost:6379`

#### Lệnh có sẵn

```bash
# Khởi động tất cả services
./scripts/dev.sh start

# Kiểm tra trạng thái services
./scripts/dev.sh status

# Xem logs
./scripts/dev.sh logs
./scripts/dev.sh logs app  # service cụ thể

# Chạy lệnh Laravel
./scripts/dev.sh artisan migrate
./scripts/dev.sh artisan db:seed
./scripts/dev.sh composer install

# Dừng services
./scripts/dev.sh stop

# Dọn dẹp (xóa tất cả dữ liệu)
./scripts/dev.sh clean
```

### Phát triển Mobile

Ứng dụng Flutter kết nối với API server chạy trên Docker.

#### Chạy ứng dụng

```bash
cd mobile

# Cài đặt dependencies
flutter pub get

# Chạy trên thiết bị/emulator
flutter run

# Build APK (Android)
flutter build apk

# Build iOS (chỉ macOS)
flutter build ios
```

#### Testing

```bash
# Chạy tất cả tests
flutter test

# Chạy với coverage
flutter test --coverage

# Phân tích code
flutter analyze
```

### Biến môi trường

Dự án sử dụng Docker environment variables:

| Biến | Mô tả | Mặc định |
|------|-------|----------|
| `DB_HOST` | Host database | `mysql` |
| `DB_DATABASE` | Tên database | `go_sport` |
| `DB_USERNAME` | User database | `go_sport_user` |
| `DB_PASSWORD` | Mật khẩu database | `go_sport_password` |
| `REDIS_HOST` | Host Redis | `redis` |
| `REDIS_PASSWORD` | Mật khẩu Redis | `go_sport_redis_password` |

### Quy trình phát triển

1. **Thay đổi Backend:**
   - Chỉnh sửa file trong thư mục `api/`
   - Thay đổi được phản ánh tự động (volume mounted)
   - Chạy migration: `./scripts/dev.sh artisan migrate`

2. **Thay đổi Frontend:**
   - Chỉnh sửa file trong `mobile-app/lib/`
   - Hot reload được bật trong Flutter
   - Khởi động lại nếu cần: `r` trong terminal

3. **Thay đổi Database:**
   - Tạo migration: `./scripts/dev.sh artisan make:migration`
   - Chạy migration: `./scripts/dev.sh artisan migrate`
   - Seed dữ liệu: `./scripts/dev.sh artisan db:seed`