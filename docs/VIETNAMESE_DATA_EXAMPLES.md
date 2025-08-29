# Vietnamese Development Data Examples
## Ví dụ dữ liệu phát triển tiếng Việt

This document contains Vietnamese-specific data examples for testing and development purposes.

## User Data Examples / Ví dụ dữ liệu người dùng

### Sample Users / Người dùng mẫu

```json
[
    {
        "full_name": "Nguyễn Văn An",
        "phone_number": "0987654321",
        "email": "nguyen.van.an@email.com",
        "gender": "male",
        "birth_date": "1990-05-15",
        "address": "123 Lê Lợi, Phường Bến Nghé, Quận 1, TP.HCM"
    },
    {
        "full_name": "Trần Thị Bích",
        "phone_number": "0976543210",
        "email": "tran.thi.bich@email.com",
        "gender": "female",
        "birth_date": "1992-08-22",
        "address": "456 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP.HCM"
    },
    {
        "full_name": "Phạm Minh Cường",
        "phone_number": "0965432109",
        "gender": "male",
        "birth_date": "1988-03-10",
        "address": "789 Điện Biên Phủ, Phường Đa Kao, Quận 1, TP.HCM"
    },
    {
        "full_name": "Lê Thị Diệu",
        "phone_number": "0954321098",
        "gender": "female",
        "birth_date": "1995-11-28",
        "address": "321 Cách Mạng Tháng 8, Phường 10, Quận 3, TP.HCM"
    }
]
```

## Group Data Examples / Ví dụ dữ liệu nhóm

### Sports Groups / Nhóm thể thao

```json
[
    {
        "name": "Câu lạc bộ Cầu lông Sài Gòn",
        "description": "CLB cầu lông dành cho những người yêu thích môn thể thao này. Chúng tôi tập luyện 3 buổi/tuần và thường xuyên tham gia các giải đấu.",
        "sport_type": "badminton",
        "location": "Sân cầu lông Rạch Miễu, Quận 1, TP.HCM",
        "meeting_schedule": "Thứ 2, 4, 6 - 19:00-21:00",
        "member_limit": 30,
        "monthly_fee": 200000
    },
    {
        "name": "Nhóm Bóng đá Thanh niên",
        "description": "Nhóm bóng đá nghiệp dư cho các bạn trẻ yêu thích bóng đá. Chúng tôi chơi bóng cuối tuần và tham gia các giải phong trào.",
        "sport_type": "football",
        "location": "Sân bóng Thống Nhất, Quận 10, TP.HCM",
        "meeting_schedule": "Thứ 7, Chủ nhật - 16:00-18:00",
        "member_limit": 25,
        "monthly_fee": 150000
    },
    {
        "name": "CLB Bóng chuyền Nữ",
        "description": "Câu lạc bộ bóng chuyền dành riêng cho nữ giới. Môi trường thân thiện, giúp nâng cao sức khỏe và kỹ năng.",
        "sport_type": "volleyball",
        "location": "Nhà thi đấu Phan Đình Phùng, Quận Phú Nhuận, TP.HCM",
        "meeting_schedule": "Thứ 3, 5, 7 - 18:30-20:30",
        "member_limit": 20,
        "monthly_fee": 180000
    },
    {
        "name": "Nhóm Chạy bộ Sáng sớm",
        "description": "Nhóm chạy bộ buổi sáng tại công viên. Phù hợp cho mọi lứa tuổi, giúp rèn luyện sức khỏe và tinh thần.",
        "sport_type": "running",
        "location": "Công viên Lê Văn Tám, Quận 1, TP.HCM",
        "meeting_schedule": "Hàng ngày - 05:30-06:30",
        "member_limit": 50,
        "monthly_fee": 50000
    }
]
```

### Vietnamese Locations / Địa điểm Việt Nam

```json
[
    "Sân cầu lông Rạch Miễu, Quận 1, TP.HCM",
    "Sân bóng Thống Nhất, Quận 10, TP.HCM",
    "Nhà thi đấu Phan Đình Phùng, Quận Phú Nhuận, TP.HCM",
    "Công viên Lê Văn Tám, Quận 1, TP.HCM",
    "Sân tennis Lan Anh, Quận 3, TP.HCM",
    "Phòng tập Gym California, Quận Bình Thạnh, TP.HCM",
    "Hồ bơi Thanh Đa, Quận Bình Thạnh, TP.HCM",
    "Sân bóng rổ Gia Định, Quận Gò Vấp, TP.HCM"
]
```

## Payment Data Examples / Ví dụ dữ liệu thanh toán

### Payment Requests / Yêu cầu thanh toán

```json
[
    {
        "title": "Phí sân cầu lông tháng 8/2025",
        "description": "Phí thuê sân cầu lông cho CLB tháng 8. Bao gồm: thuê sân 12 buổi, tiền điện, nước, và phí vệ sinh.",
        "amount": 200000,
        "due_date": "2025-08-31",
        "payment_method": "bank_transfer",
        "bank_info": {
            "bank_name": "Vietcombank",
            "account_number": "0123456789",
            "account_holder": "Nguyen Van An"
        }
    },
    {
        "title": "Tiền mua áo đồng phục nhóm",
        "description": "Tiền đóng góp mua áo thun đồng phục cho nhóm bóng đá. Chất liệu thể thao, có in logo và tên nhóm.",
        "amount": 120000,
        "due_date": "2025-09-15",
        "payment_method": "momo",
        "momo_info": {
            "phone_number": "0987654321",
            "account_name": "TRAN THI BICH"
        }
    },
    {
        "title": "Phí tham gia giải đấu",
        "description": "Lệ phí tham gia giải bóng chuyền phong trào cấp quận. Bao gồm lệ phí đăng ký đội và tiền trọng tài.",
        "amount": 300000,
        "due_date": "2025-09-01",
        "payment_method": "cash",
        "note": "Nộp tiền mặt cho thủ quỹ trong buổi tập thứ 7"
    }
]
```

### Vietnamese Payment Methods / Phương thức thanh toán VN

```json
[
    {
        "method": "bank_transfer",
        "display_name": "Chuyển khoản ngân hàng",
        "popular_banks": [
            "Vietcombank", "VietinBank", "BIDV", "Agribank", 
            "Techcombank", "MB Bank", "ACB", "VPBank"
        ]
    },
    {
        "method": "momo",
        "display_name": "Ví MoMo",
        "description": "Thanh toán qua ví điện tử MoMo"
    },
    {
        "method": "zalopay",
        "display_name": "ZaloPay",
        "description": "Thanh toán qua ví điện tử ZaloPay"
    },
    {
        "method": "cash",
        "display_name": "Tiền mặt",
        "description": "Nộp tiền mặt trực tiếp"
    }
]
```

## Attendance Data Examples / Ví dụ dữ liệu điểm danh

### Attendance Sessions / Buổi điểm danh

```json
[
    {
        "session_name": "Tập luyện cầu lông - Thứ 2",
        "session_date": "2025-08-29",
        "start_time": "19:00:00",
        "end_time": "21:00:00",
        "location": "Sân cầu lông Rạch Miễu",
        "description": "Tập luyện kỹ thuật cơ bản: cầu cao, cầu thấp, và smash. Có huấn luyện viên hướng dẫn.",
        "attendance_required": true,
        "late_checkin_allowed": true,
        "late_checkin_minutes": 15
    },
    {
        "session_name": "Đấu giao hữu bóng đá",
        "session_date": "2025-08-30",
        "start_time": "16:00:00",
        "end_time": "18:00:00",
        "location": "Sân bóng Thống Nhất",
        "description": "Trận đấu giao hữu với nhóm bóng đá Quận 3. Tập trung 15:45 để chuẩn bị.",
        "attendance_required": true,
        "notes": "Mang đầy đủ trang phục và nước uống"
    }
]
```

## Notification Examples / Ví dụ thông báo

### Vietnamese Notifications / Thông báo tiếng Việt

```json
[
    {
        "title": "Thông báo buổi tập mới",
        "message": "CLB Cầu lông Sài Gòn có buổi tập bổ sung vào Chủ nhật 31/8 lúc 14:00. Vui lòng xác nhận tham gia.",
        "type": "attendance",
        "priority": "normal"
    },
    {
        "title": "Nhắc nhở thanh toán",
        "message": "Phí sân tháng 8 sẽ đến hạn vào ngày 31/8. Vui lòng thanh toán để tránh bị gián đoạn hoạt động.",
        "type": "payment",
        "priority": "high"
    },
    {
        "title": "Thành viên mới tham gia",
        "message": "Chào mừng Lê Thị Diệu đã tham gia nhóm! Hãy chào đón thành viên mới trong buổi tập tiếp theo.",
        "type": "group",
        "priority": "low"
    },
    {
        "title": "Cập nhật lịch tập",
        "message": "Do trời mưa, buổi tập chạy bộ sáng mai sẽ chuyển sang phòng gym trong nhà. Địa điểm: Gym California.",
        "type": "schedule",
        "priority": "urgent"
    }
]
```

## Vietnamese Sports Types / Các loại thể thao VN

```json
[
    {
        "code": "badminton",
        "name": "Cầu lông",
        "description": "Môn thể thao sử dụng vợt và cầu lông",
        "equipment": ["Vợt cầu lông", "Cầu lông", "Giày thể thao"]
    },
    {
        "code": "football",
        "name": "Bóng đá",
        "description": "Môn thể thao vua phổ biến nhất thế giới",
        "equipment": ["Bóng đá", "Giày đá bóng", "Tất bóng đá"]
    },
    {
        "code": "volleyball",
        "name": "Bóng chuyền",
        "description": "Môn thể thao đồng đội với lưới cao",
        "equipment": ["Bóng chuyền", "Giày thể thao", "Băng cổ tay"]
    },
    {
        "code": "running",
        "name": "Chạy bộ",
        "description": "Hoạt động thể dục cá nhân tốt cho sức khỏe",
        "equipment": ["Giày chạy bộ", "Đồng hồ thể thao"]
    },
    {
        "code": "tennis",
        "name": "Tennis",
        "description": "Môn thể thao vợt trên sân cứng",
        "equipment": ["Vợt tennis", "Bóng tennis", "Giày tennis"]
    },
    {
        "code": "basketball",
        "name": "Bóng rổ",
        "description": "Môn thể thao với rổ và bóng tròn",
        "equipment": ["Bóng rổ", "Giày bóng rổ"]
    }
]
```

## Test API Commands / Lệnh test API

### Create Vietnamese Test User / Tạo user test tiếng Việt

```bash
curl -X POST http://localhost:8000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "full_name": "Nguyễn Văn Tester",
    "phone_number": "0123456789",
    "password": "password123",
    "password_confirmation": "password123",
    "gender": "male",
    "birth_date": "1990-01-01",
    "address": "123 Đường Test, Phường Test, Quận 1, TP.HCM"
  }'
```

### Create Vietnamese Test Group / Tạo nhóm test tiếng Việt

```bash
curl -X POST http://localhost:8000/api/groups \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "name": "Nhóm Test Cầu lông",
    "description": "Nhóm test cho việc phát triển ứng dụng",
    "sport_type": "badminton",
    "location": "Sân test, TP.HCM",
    "meeting_schedule": "Thứ 2,4,6 - 19:00-21:00"
  }'
```

## Database Seeder Data / Dữ liệu seeder

These examples can be used in Laravel seeders:

```php
// VietnameseTestDataSeeder.php
$users = [
    [
        'full_name' => 'Nguyễn Văn An',
        'phone_number' => '0987654321',
        'password' => Hash::make('password123'),
        'gender' => 'male',
        'birth_date' => '1990-05-15',
        'address' => '123 Lê Lợi, Phường Bến Nghé, Quận 1, TP.HCM',
        'phone_verified_at' => now(),
    ],
    // ... more users
];

$groups = [
    [
        'name' => 'Câu lạc bộ Cầu lông Sài Gòn',
        'description' => 'CLB cầu lông dành cho những người yêu thích môn thể thao này.',
        'sport_type' => 'badminton',
        'location' => 'Sân cầu lông Rạch Miễu, Quận 1, TP.HCM',
        'meeting_schedule' => 'Thứ 2, 4, 6 - 19:00-21:00',
        'creator_id' => 1,
    ],
    // ... more groups
];
```