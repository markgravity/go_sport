<?php

namespace Database\Factories;

use App\Models\Group;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Group>
 */
class GroupFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $sportTypes = ['football', 'badminton', 'tennis', 'pickleball'];
        $sportType = $this->faker->randomElement($sportTypes);
        
        $sportNames = [
            'football' => ['Nhóm Bóng Đá', 'CLB Bóng Đá', 'Đội Bóng'],
            'badminton' => ['Nhóm Cầu Lông', 'CLB Cầu Lông', 'Câu lạc bộ Cầu Lông'],
            'tennis' => ['Nhóm Tennis', 'CLB Tennis', 'Tennis Club'],
            'pickleball' => ['Nhóm Pickleball', 'CLB Pickleball', 'Pickleball Club'],
        ];

        $cities = ['Hà Nội', 'Hồ Chí Minh', 'Đà Nẵng', 'Cần Thơ', 'Hải Phòng'];
        $city = $this->faker->randomElement($cities);
        
        $districts = [
            'Hà Nội' => ['Ba Đình', 'Hoàn Kiếm', 'Hai Bà Trưng', 'Đống Đa', 'Cầu Giấy'],
            'Hồ Chí Minh' => ['Quận 1', 'Quận 3', 'Quận 7', 'Bình Thạnh', 'Thủ Đức'],
            'Đà Nẵng' => ['Hải Châu', 'Thanh Khê', 'Sơn Trà', 'Ngũ Hành Sơn'],
            'Cần Thơ' => ['Ninh Kiều', 'Bình Thủy', 'Cái Răng', 'Ô Môn'],
            'Hải Phòng' => ['Hồng Bàng', 'Ngô Quyền', 'Lê Chân', 'Hải An'],
        ];

        $minPlayers = match($sportType) {
            'football' => $this->faker->numberBetween(6, 11),
            'badminton', 'tennis', 'pickleball' => 2,
            default => 2
        };

        $groupNamePrefix = $this->faker->randomElement($sportNames[$sportType]);
        
        return [
            'name' => $groupNamePrefix . ' ' . $city,
            'vietnamese_name' => $this->faker->optional()->sentence(3),
            'description' => $this->faker->optional()->paragraph(),
            'sport_type' => $sportType,
            'location' => $this->faker->address(),
            'city' => $city,
            'district' => $this->faker->randomElement($districts[$city] ?? ['Trung tâm']),
            'latitude' => $this->faker->optional()->latitude(10, 24), // Vietnam latitude range
            'longitude' => $this->faker->optional()->longitude(102, 110), // Vietnam longitude range
            'schedule' => $this->faker->optional()->randomElement([
                ['monday' => '18:00-20:00', 'wednesday' => '18:00-20:00', 'friday' => '18:00-20:00'],
                ['tuesday' => '19:00-21:00', 'thursday' => '19:00-21:00'],
                ['saturday' => '14:00-16:00', 'sunday' => '14:00-16:00'],
            ]),
            'min_players' => $minPlayers,
            'current_members' => $this->faker->numberBetween(0, $minPlayers * 2),
            'monthly_fee' => $this->faker->randomElement([0, 100000, 200000, 300000, 500000]),
            'privacy' => $this->faker->randomElement(['cong_khai', 'rieng_tu']),
            'auto_approve_members' => $this->faker->boolean(),
            'status' => $this->faker->randomElement(['hoat_dong', 'tam_dung', 'dong_cua']),
            'avatar' => $this->faker->optional()->imageUrl(200, 200, 'sports'),
            'rules' => $this->faker->optional()->randomElement([
                ['Đến đúng giờ', 'Tôn trọng đối thủ', 'Tuân thủ luật chơi'],
                ['Không hút thuốc', 'Mặc trang phục thể thao', 'Đóng phí đúng hạn'],
            ]),
            'notification_hours_before' => $this->faker->randomElement([12, 24, 48]),
            'default_locations' => $this->faker->optional()->randomElement([
                ['Sân A', 'Sân B', 'Sân C'],
                ['Địa điểm 1', 'Địa điểm 2'],
            ]),
            'sport_specific_settings' => $this->faker->optional()->randomElement([
                ['court_type' => 'indoor', 'equipment_provided' => true],
                ['field_size' => 'standard', 'grass_type' => 'natural'],
            ]),
            'creator_id' => User::factory(),
        ];
    }

    /**
     * Configure the factory for a specific sport type.
     */
    public function forSport(string $sportType): static
    {
        return $this->state(function (array $attributes) use ($sportType) {
            $minPlayers = match($sportType) {
                'football' => fake()->numberBetween(6, 11),
                'badminton', 'tennis', 'pickleball' => 2,
                default => 2
            };

            return [
                'sport_type' => $sportType,
                'min_players' => $minPlayers,
            ];
        });
    }

    /**
     * Configure the factory for active groups.
     */
    public function active(): static
    {
        return $this->state([
            'status' => 'hoat_dong',
        ]);
    }

    /**
     * Configure the factory for public groups.
     */
    public function public(): static
    {
        return $this->state([
            'privacy' => 'cong_khai',
        ]);
    }

    /**
     * Configure the factory for private groups.
     */
    public function private(): static
    {
        return $this->state([
            'privacy' => 'rieng_tu',
        ]);
    }

    /**
     * Configure the factory with a specific creator.
     */
    public function createdBy(User $user): static
    {
        return $this->state([
            'creator_id' => $user->id,
        ]);
    }

    /**
     * Configure the factory for free groups (no monthly fee).
     */
    public function free(): static
    {
        return $this->state([
            'monthly_fee' => 0,
        ]);
    }

    /**
     * Configure the factory for paid groups.
     */
    public function paid(int $fee = null): static
    {
        return $this->state([
            'monthly_fee' => $fee ?? fake()->numberBetween(100000, 500000),
        ]);
    }
}