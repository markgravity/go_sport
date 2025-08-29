# Go Sport API Documentation
## Tài liệu API Go Sport

*Available in: [English](#english) | [Tiếng Việt](#vietnamese)*

---

## <a name="english"></a>🇺🇸 English

### Base URL
```
http://localhost:8000/api
```

### Authentication

The API uses Laravel Sanctum for authentication. Include the Bearer token in the Authorization header:

```
Authorization: Bearer {your-token}
```

### Response Format

All API responses follow this standard format:

```json
{
    "success": true,
    "data": {},
    "message": "Operation successful",
    "status": 200
}
```

Error responses:
```json
{
    "success": false,
    "message": "Error description",
    "errors": {},
    "status": 400
}
```

## Endpoints

### Health Check

#### `GET /health`
Check API server health and status.

**Response:**
```json
{
    "status": "OK",
    "timestamp": "2025-08-29T10:00:00Z",
    "services": {
        "database": "connected",
        "redis": "connected"
    },
    "version": "1.0.0",
    "timezone": "Asia/Ho_Chi_Minh"
}
```

### Authentication

#### `POST /auth/register`
Register a new user account.

**Request Body:**
```json
{
    "full_name": "Nguyễn Văn A",
    "phone_number": "0987654321",
    "password": "password123",
    "password_confirmation": "password123",
    "gender": "male",
    "birth_date": "1990-01-15",
    "address": "123 Lê Lợi, Q1, TP.HCM"
}
```

**Response:**
```json
{
    "success": true,
    "data": {
        "user": {
            "id": 1,
            "full_name": "Nguyễn Văn A",
            "phone_number": "0987654321",
            "verification_status": "pending"
        },
        "token": "1|abc123..."
    }
}
```

#### `POST /auth/login`
Login with phone number and password.

**Request Body:**
```json
{
    "phone_number": "0987654321",
    "password": "password123"
}
```

#### `POST /auth/verify-phone`
Verify phone number with OTP code.

**Request Body:**
```json
{
    "phone_number": "0987654321",
    "verification_code": "123456"
}
```

### User Management

#### `GET /user/profile`
Get current user profile. *Requires authentication*

**Response:**
```json
{
    "success": true,
    "data": {
        "id": 1,
        "full_name": "Nguyễn Văn A",
        "phone_number": "0987654321",
        "email": null,
        "gender": "male",
        "birth_date": "1990-01-15",
        "address": "123 Lê Lợi, Q1, TP.HCM",
        "created_at": "2025-08-29T10:00:00Z"
    }
}
```

#### `PUT /user/profile`
Update user profile. *Requires authentication*

#### `POST /user/logout`
Logout current user. *Requires authentication*

### Group Management

#### `GET /groups`
Get list of user's groups. *Requires authentication*

**Response:**
```json
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Câu lạc bộ cầu lông Sài Gòn",
            "description": "CLB cầu lông cho người yêu thích thể thao",
            "sport_type": "badminton",
            "location": "Quận 1, TP.HCM",
            "member_count": 25,
            "user_role": "member"
        }
    ]
}
```

#### `POST /groups`
Create a new group. *Requires authentication*

**Request Body:**
```json
{
    "name": "Câu lạc bộ cầu lông Sài Gòn",
    "description": "CLB cầu lông cho người yêu thích thể thao",
    "sport_type": "badminton",
    "location": "Quận 1, TP.HCM",
    "meeting_schedule": "Thứ 2,4,6 - 19:00-21:00"
}
```

#### `GET /groups/{id}`
Get group details. *Requires authentication*

#### `POST /groups/{id}/join`
Join a group. *Requires authentication*

#### `GET /groups/{id}/members`
Get group members list. *Requires authentication*

### Attendance Management

#### `GET /attendance/sessions`
Get attendance sessions. *Requires authentication*

**Query Parameters:**
- `group_id`: Filter by group
- `date`: Filter by date (YYYY-MM-DD)
- `status`: Filter by status (open, closed)

#### `POST /attendance/sessions`
Create new attendance session. *Requires authentication*

**Request Body:**
```json
{
    "group_id": 1,
    "session_name": "Tập luyện thứ 2",
    "session_date": "2025-08-29",
    "start_time": "19:00:00",
    "end_time": "21:00:00",
    "location": "Sân cầu lông A",
    "description": "Tập luyện kỹ thuật cơ bản"
}
```

#### `POST /attendance/sessions/{id}/checkin`
Check in to attendance session. *Requires authentication*

#### `GET /attendance/history`
Get user's attendance history. *Requires authentication*

### Payment Management

#### `GET /payments/requests`
Get payment requests. *Requires authentication*

#### `POST /payments/requests`
Create payment request. *Requires authentication*

**Request Body:**
```json
{
    "group_id": 1,
    "title": "Phí sân tháng 8",
    "description": "Phí thuê sân cầu lông tháng 8/2025",
    "amount": 200000,
    "due_date": "2025-08-31",
    "payment_method": "bank_transfer"
}
```

#### `POST /payments/requests/{id}/pay`
Process payment for a request. *Requires authentication*

### Notification Management

#### `GET /notifications`
Get user notifications. *Requires authentication*

#### `GET /notifications/unread`
Get unread notifications count. *Requires authentication*

#### `POST /notifications/{id}/read`
Mark notification as read. *Requires authentication*

## Testing Procedures

### Manual Testing

1. **Health Check:**
   ```bash
   curl http://localhost:8000/api/health
   ```

2. **User Registration:**
   ```bash
   curl -X POST http://localhost:8000/api/auth/register \
     -H "Content-Type: application/json" \
     -d '{
       "full_name": "Test User",
       "phone_number": "0123456789",
       "password": "password123",
       "password_confirmation": "password123",
       "gender": "male",
       "birth_date": "1990-01-01"
     }'
   ```

3. **User Login:**
   ```bash
   curl -X POST http://localhost:8000/api/auth/login \
     -H "Content-Type: application/json" \
     -d '{
       "phone_number": "0123456789",
       "password": "password123"
     }'
   ```

### Automated Testing

Run API tests:
```bash
./scripts/dev.sh artisan test
./scripts/dev.sh artisan test --coverage
```

---

## <a name="vietnamese"></a>🇻🇳 Tiếng Việt

### URL Cơ sở
```
http://localhost:8000/api
```

### Xác thực

API sử dụng Laravel Sanctum để xác thực. Bao gồm Bearer token trong header Authorization:

```
Authorization: Bearer {your-token}
```

### Định dạng Response

Tất cả API responses theo định dạng chuẩn này:

```json
{
    "success": true,
    "data": {},
    "message": "Thao tác thành công",
    "status": 200
}
```

Error responses:
```json
{
    "success": false,
    "message": "Mô tả lỗi",
    "errors": {},
    "status": 400
}
```

## Endpoints

### Kiểm tra sức khỏe

#### `GET /health`
Kiểm tra tình trạng và sức khỏe API server.

### Xác thực

#### `POST /auth/register`
Đăng ký tài khoản người dùng mới.

#### `POST /auth/login`
Đăng nhập với số điện thoại và mật khẩu.

#### `POST /auth/verify-phone`
Xác minh số điện thoại với mã OTP.

### Quản lý người dùng

#### `GET /user/profile`
Lấy thông tin profile người dùng hiện tại. *Yêu cầu xác thực*

#### `PUT /user/profile`
Cập nhật profile người dùng. *Yêu cầu xác thực*

### Quản lý nhóm

#### `GET /groups`
Lấy danh sách nhóm của người dùng. *Yêu cầu xác thực*

#### `POST /groups`
Tạo nhóm mới. *Yêu cầu xác thực*

#### `POST /groups/{id}/join`
Tham gia nhóm. *Yêu cầu xác thực*

### Quản lý điểm danh

#### `GET /attendance/sessions`
Lấy danh sách buổi điểm danh. *Yêu cầu xác thực*

#### `POST /attendance/sessions`
Tạo buổi điểm danh mới. *Yêu cầu xác thực*

#### `POST /attendance/sessions/{id}/checkin`
Điểm danh vào buổi. *Yêu cầu xác thực*

### Quản lý thanh toán

#### `GET /payments/requests`
Lấy danh sách yêu cầu thanh toán. *Yêu cầu xác thực*

#### `POST /payments/requests`
Tạo yêu cầu thanh toán. *Yêu cầu xác thực*

### Quản lý thông báo

#### `GET /notifications`
Lấy thông báo của người dùng. *Yêu cầu xác thực*

#### `POST /notifications/{id}/read`
Đánh dấu thông báo đã đọc. *Yêu cầu xác thực*

## Quy trình Testing

### Manual Testing

1. **Kiểm tra Health:**
   ```bash
   curl http://localhost:8000/api/health
   ```

2. **Đăng ký người dùng:**
   ```bash
   curl -X POST http://localhost:8000/api/auth/register \
     -H "Content-Type: application/json" \
     -d '{
       "full_name": "Người dùng test",
       "phone_number": "0123456789",
       "password": "password123",
       "password_confirmation": "password123",
       "gender": "male",
       "birth_date": "1990-01-01"
     }'
   ```

### Automated Testing

Chạy API tests:
```bash
./scripts/dev.sh artisan test
./scripts/dev.sh artisan test --coverage
```