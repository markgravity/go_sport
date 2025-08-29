# Go Sport Development Team Onboarding
## Hướng dẫn nhập môn đội phát triển Go Sport

*Available in: [English](#english) | [Tiếng Việt](#vietnamese)*

---

## <a name="english"></a>🇺🇸 English

### Welcome to the Go Sport Development Team! 🏃‍♂️

This guide will help new team members get up to speed with our development environment, coding standards, and workflow.

## Team Structure

### Roles
- **Full Stack Developer**: Works on both Flutter mobile app and Laravel API
- **Mobile Developer**: Focuses on Flutter mobile application
- **Backend Developer**: Focuses on Laravel API and database
- **DevOps**: Manages Docker, deployment, and infrastructure
- **UI/UX Designer**: Designs user interfaces and user experience

### Communication
- **Slack**: Daily communication and quick updates
- **Email**: Formal communications and external contacts
- **Zoom**: Daily standups, sprint planning, and retrospectives
- **GitHub**: Code reviews and issue tracking

## Development Environment Setup

### Day 1: Environment Setup

1. **Get Access:**
   - GitHub repository access
   - Slack workspace invitation
   - Development server credentials

2. **Install Required Tools:**
   - Follow [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) guide
   - Verify installation: `./scripts/dev.sh start`
   - Test Flutter app: `flutter run`

3. **Verify Setup:**
   - API Health Check: `curl http://localhost:8000/api/health`
   - Flutter app connects to API successfully
   - All services running: `./scripts/dev.sh status`

### Day 2-3: Codebase Familiarization

1. **Repository Structure:**
   ```
   go_sport/
   ├── api/                 # Laravel backend
   │   ├── app/            # Application logic
   │   ├── database/       # Migrations and seeders
   │   └── routes/         # API routes
   ├── mobile-app/         # Flutter frontend
   │   ├── lib/            # Dart code
   │   └── assets/         # Images and resources
   └── docs/               # Documentation
   ```

2. **Key Files to Review:**
   - `api/routes/api.php` - API endpoints
   - `mobile-app/lib/main.dart` - App entry point
   - `mobile-app/lib/core/network/` - API client
   - `docker-compose.yml` - Service configuration

3. **Run Tests:**
   ```bash
   # Backend tests
   ./scripts/dev.sh artisan test
   
   # Frontend tests
   cd mobile-app
   flutter test
   ```

## Development Workflow

### Git Workflow

1. **Branch Naming Convention:**
   - `feature/task-description` - New features
   - `bugfix/issue-description` - Bug fixes  
   - `hotfix/critical-issue` - Production hotfixes
   - `docs/documentation-update` - Documentation changes

2. **Commit Messages:**
   ```
   feat: add user profile management API
   fix: resolve payment processing error
   docs: update API documentation
   test: add unit tests for attendance service
   ```

3. **Pull Request Process:**
   - Create feature branch from `main`
   - Make changes and commit
   - Push branch and create PR
   - Request code review
   - Address feedback and merge

### Code Review Guidelines

**What to Look For:**
- Code follows project standards
- Proper error handling
- Vietnamese localization where needed
- Tests are included
- Documentation is updated

**How to Review:**
- Test the changes locally
- Check for potential issues
- Suggest improvements
- Approve when ready

### Development Standards

#### Laravel API Standards

```php
// Use proper typing
public function createGroup(CreateGroupRequest $request): JsonResponse

// Follow PSR-12 coding standard
class GroupController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        // Implementation
    }
}

// Use resource classes for responses
return new GroupResource($group);
```

#### Flutter Standards

```dart
// Use proper naming conventions
class ConnectionStatusIndicator extends ConsumerWidget {
  const ConnectionStatusIndicator({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Implementation
  }
}

// Use Riverpod for state management
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
```

#### Vietnamese Localization

```dart
// Always use localized strings
Text(AppLocalizations.of(context).welcomeMessage)

// Vietnamese error messages in API
'message' => 'Không thể kết nối đến máy chủ'
```

## Project Architecture

### Mobile App (Flutter)

```
lib/
├── main.dart              # App entry point
├── app/                   # App configuration
├── core/                  # Core utilities
│   ├── network/          # API client and networking
│   ├── theme/            # App theming
│   └── navigation/       # App navigation
├── widgets/              # Reusable widgets
└── l10n/                 # Localization files
```

### Backend API (Laravel)

```
app/
├── Http/
│   └── Controllers/Api/  # API controllers
├── Models/               # Database models
├── Services/            # Business logic
└── Providers/           # Service providers
```

## Testing Strategy

### Backend Testing
```bash
# Run all tests
./scripts/dev.sh artisan test

# Run specific test
./scripts/dev.sh artisan test --filter=UserTest

# Generate coverage report
./scripts/dev.sh artisan test --coverage
```

### Frontend Testing
```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter drive --target=test_driver/app.dart
```

## Deployment Process

### Staging Deployment
1. Merge PR to `develop` branch
2. Automatic deployment to staging server
3. Run automated tests
4. Manual QA testing

### Production Deployment
1. Create release branch from `develop`
2. Final testing and bug fixes
3. Merge to `main` branch
4. Tag release version
5. Deploy to production

## Resources and Documentation

### Internal Documentation
- [Development Setup](./DEVELOPMENT_SETUP.md)
- [API Documentation](./API_DOCUMENTATION.md)
- [Troubleshooting Guide](./TROUBLESHOOTING.md)
- [Vietnamese Data Examples](./VIETNAMESE_DATA_EXAMPLES.md)

### External Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Laravel Documentation](https://laravel.com/docs)
- [Docker Documentation](https://docs.docker.com/)

### Learning Resources
- Flutter & Dart course (company Udemy account)
- Laravel advanced concepts
- Vietnamese localization best practices

## First Week Checklist

- [ ] Complete environment setup
- [ ] Access all required tools and accounts
- [ ] Review codebase architecture
- [ ] Run first successful build
- [ ] Create first test PR (documentation fix)
- [ ] Attend daily standup meetings
- [ ] Complete code review training

---

## <a name="vietnamese"></a>🇻🇳 Tiếng Việt

### Chào mừng đến với đội phát triển Go Sport! 🏃‍♂️

Hướng dẫn này sẽ giúp thành viên mới nhanh chóng làm quen với môi trường phát triển, chuẩn coding, và quy trình làm việc.

## Cấu trúc đội

### Vai trò
- **Full Stack Developer**: Làm việc với cả Flutter mobile app và Laravel API
- **Mobile Developer**: Tập trung vào ứng dụng Flutter mobile
- **Backend Developer**: Tập trung vào Laravel API và database
- **DevOps**: Quản lý Docker, deployment và hạ tầng
- **UI/UX Designer**: Thiết kế giao diện và trải nghiệm người dùng

### Giao tiếp
- **Slack**: Giao tiếp hàng ngày và cập nhật nhanh
- **Email**: Giao tiếp chính thức và liên hệ ngoài
- **Zoom**: Daily standup, sprint planning và retrospective
- **GitHub**: Code review và theo dõi issue

## Thiết lập môi trường phát triển

### Ngày 1: Thiết lập môi trường

1. **Lấy quyền truy cập:**
   - Quyền truy cập GitHub repository
   - Lời mời Slack workspace
   - Thông tin đăng nhập server phát triển

2. **Cài đặt công cụ cần thiết:**
   - Làm theo hướng dẫn [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md)
   - Xác minh cài đặt: `./scripts/dev.sh start`
   - Test Flutter app: `flutter run`

3. **Kiểm tra thiết lập:**
   - API Health Check: `curl http://localhost:8000/api/health`
   - Flutter app kết nối thành công với API
   - Tất cả services chạy: `./scripts/dev.sh status`

### Ngày 2-3: Làm quen với codebase

1. **Cấu trúc repository:**
   - Xem lại cấu trúc thư mục
   - Hiểu flow dữ liệu giữa mobile và API
   - Đọc documentation trong `/docs`

2. **Chạy tests:**
   - Backend: `./scripts/dev.sh artisan test`
   - Frontend: `flutter test`

## Quy trình phát triển

### Quy trình Git

1. **Quy ước đặt tên branch:**
   - `feature/mo-ta-task` - Tính năng mới
   - `bugfix/mo-ta-loi` - Sửa lỗi
   - `hotfix/loi-khan-cap` - Hotfix production
   - `docs/cap-nhat-tai-lieu` - Cập nhật tài liệu

2. **Commit Messages:**
   ```
   feat: thêm API quản lý profile người dùng
   fix: sửa lỗi xử lý thanh toán
   docs: cập nhật tài liệu API
   test: thêm unit test cho attendance service
   ```

### Chuẩn phát triển

#### Chuẩn Vietnamese Localization

```dart
// Luôn sử dụng chuỗi đã localized
Text(AppLocalizations.of(context).welcomeMessage)

// Thông báo lỗi tiếng Việt trong API
'message' => 'Không thể kết nối đến máy chủ'
```

#### Quy ước dữ liệu tiếng Việt

- Tên người: "Nguyễn Văn A", "Trần Thị B"
- Địa chỉ: "123 Lê Lợi, Phường Bến Nghé, Quận 1, TP.HCM"
- Số điện thoại: "0987654321"
- Tên nhóm: "Câu lạc bộ Cầu lông Sài Gòn"

## Kiểm thử

### Test Backend
```bash
# Chạy tất cả test
./scripts/dev.sh artisan test

# Test cụ thể
./scripts/dev.sh artisan test --filter=UserTest
```

### Test Frontend
```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart
```

## Quy trình triển khai

### Triển khai Staging
1. Merge PR vào branch `develop`
2. Tự động deploy lên staging server
3. Chạy automated tests
4. Manual QA testing

### Triển khai Production
1. Tạo release branch từ `develop`
2. Test cuối và sửa lỗi
3. Merge vào branch `main`
4. Tag version release
5. Deploy lên production

## Tài liệu và tài nguyên

### Tài liệu nội bộ
- [Hướng dẫn cài đặt](./DEVELOPMENT_SETUP.md)
- [Tài liệu API](./API_DOCUMENTATION.md)
- [Hướng dẫn khắc phục sự cố](./TROUBLESHOOTING.md)
- [Ví dụ dữ liệu tiếng Việt](./VIETNAMESE_DATA_EXAMPLES.md)

### Checklist tuần đầu

- [ ] Hoàn thành thiết lập môi trường
- [ ] Truy cập tất cả công cụ và tài khoản cần thiết
- [ ] Xem lại kiến trúc codebase
- [ ] Build thành công lần đầu
- [ ] Tạo PR test đầu tiên (sửa documentation)
- [ ] Tham gia daily standup meetings
- [ ] Hoàn thành training code review

## Liên hệ và hỗ trợ

### Khi cần hỗ trợ
1. Kiểm tra [Troubleshooting Guide](./TROUBLESHOOTING.md) trước
2. Tìm kiếm trong Slack history
3. Hỏi trong channel #dev-support
4. Escalate lên team lead nếu cần thiết

### Mentor và buddy system
- Mỗi thành viên mới sẽ được gán một mentor
- Mentor sẽ hỗ trợ trong 2 tuần đầu
- 1-1 meeting hàng tuần với mentor
- Open door policy - luôn có thể hỏi bất cứ lúc nào

## Văn hóa làm việc

### Nguyên tắc
- **Chất lượng code**: Luôn ưu tiên chất lượng hơn tốc độ
- **Học hỏi**: Sẵn sàng học và chia sẻ kinh nghiệm
- **Hợp tác**: Giúp đỡ lẫn nhau trong team
- **Sáng tạo**: Đóng góp ý tưởng cải tiến sản phẩm

### Meetings
- **Daily Standup**: 9:00 AM hàng ngày (15 phút)
- **Sprint Planning**: Thứ 2 đầu sprint (1 giờ)
- **Sprint Retrospective**: Thứ 6 cuối sprint (30 phút)
- **Tech Talk**: Thứ 6 hàng tuần (30 phút)