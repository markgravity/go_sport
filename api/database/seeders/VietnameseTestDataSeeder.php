<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class VietnameseTestDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Create test users with Vietnamese data
        $users = [
            [
                'name' => 'Nguyễn Văn An',
                'email' => 'nguyen.van.an@example.com',
                'phone' => '+84901234567',
                'password' => Hash::make('password123'),
                'date_of_birth' => '1995-05-15',
                'gender' => 'male',
                'address' => '123 Trần Hưng Đạo, Quận 1',
                'city' => 'Hồ Chí Minh',
                'province' => 'Thành phố Hồ Chí Minh',
                'status' => 'active',
                'phone_verified_at' => now(),
                'email_verified_at' => now(),
                'preferences' => json_encode([
                    'language' => 'vi',
                    'notifications' => true,
                    'theme' => 'light'
                ])
            ],
            [
                'name' => 'Trần Thị Bình',
                'email' => 'tran.thi.binh@example.com',
                'phone' => '+84912345678',
                'password' => Hash::make('password123'),
                'date_of_birth' => '1992-08-20',
                'gender' => 'female',
                'address' => '456 Lê Lợi, Quận Hai Bà Trưng',
                'city' => 'Hà Nội',
                'province' => 'Thành phố Hà Nội',
                'status' => 'active',
                'phone_verified_at' => now(),
                'email_verified_at' => now()
            ],
            [
                'name' => 'Lê Minh Cường',
                'email' => 'le.minh.cuong@example.com',
                'phone' => '+84923456789',
                'password' => Hash::make('password123'),
                'date_of_birth' => '1988-12-10',
                'gender' => 'male',
                'address' => '789 Nguyễn Huệ, Quận 1',
                'city' => 'Hồ Chí Minh',
                'province' => 'Thành phố Hồ Chí Minh',
                'status' => 'active',
                'phone_verified_at' => now(),
                'email_verified_at' => now()
            ]
        ];

        foreach ($users as $user) {
            DB::table('users')->insert(array_merge($user, [
                'created_at' => now(),
                'updated_at' => now()
            ]));
        }

        // Create Vietnamese sports groups
        $groups = [
            [
                'name' => 'CLB Bóng Đá Sài Gòn FC',
                'description' => 'Câu lạc bộ bóng đá nghiệp dư tại Sài Gòn. Chúng tôi tập luyện mỗi cuối tuần và tham gia các giải đấu địa phương.',
                'sport_type' => 'bong_da',
                'skill_level' => 'trung_binh',
                'location' => 'Sân bóng Tao Đàn, Quận 1, TP.HCM',
                'city' => 'Hồ Chí Minh',
                'district' => 'Quận 1',
                'latitude' => 10.7769,
                'longitude' => 106.6951,
                'schedule' => json_encode([
                    'days' => ['saturday', 'sunday'],
                    'time' => '07:00-09:00',
                    'note' => 'Tập mỗi sáng cuối tuần'
                ]),
                'max_members' => 25,
                'current_members' => 1,
                'membership_fee' => 200000.00,
                'privacy' => 'cong_khai',
                'status' => 'hoat_dong',
                'rules' => json_encode([
                    'Đến đúng giờ',
                    'Mang đầy đủ dụng cụ tập luyện',
                    'Tôn trọng đồng đội và huấn luyện viên',
                    'Đóng phí đầy đủ và đúng hạn'
                ]),
                'creator_id' => 1
            ],
            [
                'name' => 'Nhóm Cầu Lông Hà Nội',
                'description' => 'Nhóm chơi cầu lông giải trí tại Hà Nội. Phù hợp cho người mới bắt đầu và trung bình.',
                'sport_type' => 'cau_long',
                'skill_level' => 'moi_bat_dau',
                'location' => 'Cung thể thao Quần Ngựa, Quận Ba Đình, Hà Nội',
                'city' => 'Hà Nội',
                'district' => 'Quận Ba Đình',
                'latitude' => 21.0285,
                'longitude' => 105.8542,
                'schedule' => json_encode([
                    'days' => ['tuesday', 'thursday'],
                    'time' => '19:00-21:00',
                    'note' => 'Tập tối thứ 3 và thứ 5'
                ]),
                'max_members' => 15,
                'current_members' => 1,
                'membership_fee' => 150000.00,
                'privacy' => 'cong_khai',
                'status' => 'hoat_dong',
                'rules' => json_encode([
                    'Mang giày thể thao chuyên dụng',
                    'Không hút thuốc trong sân',
                    'Chia sẻ chi phí thuê sân'
                ]),
                'creator_id' => 2
            ],
            [
                'name' => 'CLB Chạy Bộ Sài Gòn Runners',
                'description' => 'Cộng đồng yêu thích chạy bộ tại TP.HCM. Tập luyện cùng nhau và tham gia các cuộc đua marathon.',
                'sport_type' => 'chay_bo',
                'skill_level' => 'gioi',
                'location' => 'Công viên Tao Đàn và các tuyến đường quanh Sài Gòn',
                'city' => 'Hồ Chí Minh',
                'district' => 'Quận 1',
                'latitude' => 10.7769,
                'longitude' => 106.6951,
                'schedule' => json_encode([
                    'days' => ['monday', 'wednesday', 'friday'],
                    'time' => '05:30-07:00',
                    'note' => 'Chạy sáng sớm 3 ngày/tuần'
                ]),
                'max_members' => 30,
                'current_members' => 1,
                'membership_fee' => 100000.00,
                'privacy' => 'cong_khai',
                'status' => 'hoat_dong',
                'rules' => json_encode([
                    'Đến đúng giờ tập trung',
                    'Mang trang phục chạy bộ phù hợp',
                    'Tôn trọng tốc độ của từng thành viên',
                    'An toàn giao thông là ưu tiên hàng đầu'
                ]),
                'creator_id' => 3
            ]
        ];

        foreach ($groups as $group) {
            DB::table('groups')->insert(array_merge($group, [
                'created_at' => now(),
                'updated_at' => now()
            ]));
        }

        // Create group memberships (creators are automatically members)
        $memberships = [
            [
                'user_id' => 1,
                'group_id' => 1,
                'role' => 'admin',
                'status' => 'hoat_dong',
                'joined_at' => now(),
                'join_reason' => 'Người tạo nhóm'
            ],
            [
                'user_id' => 2,
                'group_id' => 2,
                'role' => 'admin',
                'status' => 'hoat_dong',
                'joined_at' => now(),
                'join_reason' => 'Người tạo nhóm'
            ],
            [
                'user_id' => 3,
                'group_id' => 3,
                'role' => 'admin',
                'status' => 'hoat_dong',
                'joined_at' => now(),
                'join_reason' => 'Người tạo nhóm'
            ],
            // Cross-membership for testing
            [
                'user_id' => 2,
                'group_id' => 1,
                'role' => 'member',
                'status' => 'hoat_dong',
                'joined_at' => now(),
                'join_reason' => 'Muốn chơi bóng đá thêm'
            ]
        ];

        foreach ($memberships as $membership) {
            DB::table('group_memberships')->insert(array_merge($membership, [
                'created_at' => now(),
                'updated_at' => now()
            ]));
        }

        // Create some sample attendance sessions
        $sessions = [
            [
                'group_id' => 1,
                'title' => 'Tập luyện cuối tuần',
                'description' => 'Tập kỹ thuật cơ bản và đá phân nửa sân',
                'session_date' => now()->addDays(2)->toDateString(),
                'start_time' => '07:00:00',
                'end_time' => '09:00:00',
                'location' => 'Sân bóng Tao Đàn, Quận 1, TP.HCM',
                'latitude' => 10.7769,
                'longitude' => 106.6951,
                'qr_code' => 'QR_BONGDA_' . uniqid(),
                'status' => 'sap_dien_ra',
                'expected_attendees' => 18
            ],
            [
                'group_id' => 2,
                'title' => 'Buổi tập cầu lông',
                'description' => 'Luyện tập kỹ thuật cơ bản và đánh đôi',
                'session_date' => now()->addDays(1)->toDateString(),
                'start_time' => '19:00:00',
                'end_time' => '21:00:00',
                'location' => 'Cung thể thao Quần Ngựa, Quận Ba Đình, Hà Nội',
                'latitude' => 21.0285,
                'longitude' => 105.8542,
                'qr_code' => 'QR_CAULONG_' . uniqid(),
                'status' => 'sap_dien_ra',
                'expected_attendees' => 8
            ]
        ];

        foreach ($sessions as $session) {
            DB::table('attendance_sessions')->insert(array_merge($session, [
                'created_at' => now(),
                'updated_at' => now()
            ]));
        }

        $this->command->info('Vietnamese test data seeded successfully!');
        $this->command->info('Users created: 3');
        $this->command->info('Groups created: 3');
        $this->command->info('Memberships created: 4');
        $this->command->info('Sessions created: 2');
    }
}
