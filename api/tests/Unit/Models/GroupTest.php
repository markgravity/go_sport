<?php

namespace Tests\Unit\Models;

use App\Models\Group;
use App\Models\User;
use App\Models\GroupLevelRequirement;
use App\Enums\GroupRole;
use App\Enums\GroupPermission;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use PHPUnit\Framework\Attributes\Test;

class GroupTest extends TestCase
{
    use RefreshDatabase;

    private User $user;
    private User $creator;

    protected function setUp(): void
    {
        parent::setUp();
        
        $this->creator = User::factory()->create();
        $this->user = User::factory()->create();
    }

    #[Test]
    public function it_can_create_a_group_with_valid_data()
    {
        $group = Group::create([
            'name' => 'Nhóm Cầu Lông Hà Nội',
            'vietnamese_name' => 'Hà Nội Badminton Club',
            'description' => 'Nhóm cầu lông cho người yêu thích thể thao',
            'sport_type' => 'badminton',
            'location' => 'Sân cầu lông ABC, 123 Đường XYZ',
            'city' => 'Hà Nội',
            'district' => 'Ba Đình',
            'min_players' => 2,
            'monthly_fee' => 200000,
            'privacy' => 'cong_khai',
            'status' => 'hoat_dong',
            'creator_id' => $this->creator->id,
        ]);

        $this->assertInstanceOf(Group::class, $group);
        $this->assertEquals('Nhóm Cầu Lông Hà Nội', $group->name);
        $this->assertEquals('badminton', $group->sport_type);
        $this->assertEquals($this->creator->id, $group->creator_id);
    }

    #[Test]
    public function it_validates_required_fields()
    {
        $this->expectException(\Illuminate\Database\QueryException::class);
        
        Group::create([
            // Missing required fields
        ]);
    }

    #[Test]
    public function it_validates_sport_type()
    {
        $validSportTypes = ['football', 'badminton', 'tennis', 'pickleball'];
        
        foreach ($validSportTypes as $sportType) {
            $group = Group::create([
                'name' => "Test Group {$sportType}",
                'sport_type' => $sportType,
                'location' => 'Test Location',
                'city' => 'Test City',
                'privacy' => 'cong_khai',
                'creator_id' => $this->creator->id,
            ]);
            
            $this->assertEquals($sportType, $group->sport_type);
        }
    }

    #[Test]
    public function it_validates_vietnamese_name_pattern()
    {
        $validNames = [
            'Nhóm Cầu Lông Hà Nội',
            'CLB Tennis Sài Gòn',
            'Đội Bóng Đá 123',
            'Group-Name_Test (2024)',
        ];

        foreach ($validNames as $name) {
            $this->assertTrue(Group::isValidVietnameseName($name));
        }

        $invalidNames = [
            'Group<script>alert("xss")</script>',
            'Group@#$%^&*',
            '',
        ];

        foreach ($invalidNames as $name) {
            $this->assertFalse(Group::isValidVietnameseName($name));
        }
    }

    #[Test]
    public function it_returns_correct_sport_name_attribute()
    {
        $sportNames = [
            'badminton' => 'Cầu lông',
            'football' => 'Bóng đá',
            'tennis' => 'Tennis',
            'pickleball' => 'Pickleball',
        ];

        foreach ($sportNames as $sportType => $expectedName) {
            $group = Group::factory()->create(['sport_type' => $sportType]);
            $this->assertEquals($expectedName, $group->sport_name);
        }
    }

    #[Test]
    public function it_calculates_fee_per_member_correctly()
    {
        $group = Group::factory()->create([
            'monthly_fee' => 300000,
            'current_members' => 10,
        ]);

        $this->assertEquals(30000, $group->fee_per_member);
    }

    #[Test]
    public function it_returns_zero_fee_per_member_when_no_members()
    {
        $group = Group::factory()->create([
            'monthly_fee' => 300000,
            'current_members' => 0,
        ]);

        $this->assertEquals(0.0, $group->fee_per_member);
    }

    #[Test]
    public function it_returns_correct_privacy_name_attribute()
    {
        $privacyNames = [
            'cong_khai' => 'Công khai',
            'rieng_tu' => 'Riêng tư',
        ];

        foreach ($privacyNames as $privacy => $expectedName) {
            $group = Group::factory()->create(['privacy' => $privacy]);
            $this->assertEquals($expectedName, $group->privacy_name);
        }
    }

    #[Test]
    public function it_returns_correct_status_name_attribute()
    {
        $statusNames = [
            'hoat_dong' => 'Hoạt động',
            'tam_dung' => 'Tạm dừng',
            'dong_cua' => 'Đóng cửa',
        ];

        foreach ($statusNames as $status => $expectedName) {
            $group = Group::factory()->create(['status' => $status]);
            $this->assertEquals($expectedName, $group->status_name);
        }
    }

    #[Test]
    public function it_returns_sport_specific_default_settings()
    {
        $sportDefaults = [
            'badminton' => ['min_players' => 2, 'notification_hours' => 24],
            'football' => ['min_players' => 10, 'notification_hours' => 48],
            'pickleball' => ['min_players' => 2, 'notification_hours' => 12],
            'tennis' => ['min_players' => 2, 'notification_hours' => 12],
        ];

        foreach ($sportDefaults as $sport => $expected) {
            $group = Group::factory()->create(['sport_type' => $sport]);
            $defaults = $group->getDefaultSettings();
            
            $this->assertEquals($expected['min_players'], $defaults['min_players']);
            $this->assertEquals($expected['notification_hours'], $defaults['notification_hours']);
            $this->assertIsArray($defaults['typical_locations']);
        }
    }

    #[Test]
    public function it_can_add_and_check_level_requirements()
    {
        $group = Group::factory()->create(['sport_type' => 'badminton']);

        $this->assertFalse($group->hasLevelRequirements());

        $requirement = $group->addLevelRequirement('intermediate', 'Trung bình', 'Người chơi có kinh nghiệm 1-2 năm');

        $this->assertInstanceOf(GroupLevelRequirement::class, $requirement);
        $this->assertTrue($group->fresh()->hasLevelRequirements());
        $this->assertEquals(['Trung bình'], $group->fresh()->level_requirement_names);
    }

    #[Test]
    public function it_can_determine_user_roles()
    {
        $group = Group::factory()->create(['creator_id' => $this->creator->id]);
        
        // Assign creator as admin
        $group->assignCreatorAsAdmin();
        
        // Test admin role
        $this->assertTrue($group->isAdmin($this->creator));
        $this->assertTrue($group->isMember($this->creator));
        $this->assertTrue($group->canManage($this->creator));

        // Add another user as moderator
        $group->memberships()->attach($this->user->id, [
            'role' => GroupRole::MODERATOR->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->assertTrue($group->isModerator($this->user));
        $this->assertTrue($group->isMember($this->user));
        $this->assertTrue($group->canManage($this->user));
    }

    #[Test]
    public function it_can_get_user_role_enum()
    {
        $group = Group::factory()->create(['creator_id' => $this->creator->id]);
        $group->assignCreatorAsAdmin();

        $role = $group->getUserRole($this->creator);
        $this->assertInstanceOf(GroupRole::class, $role);
        $this->assertEquals(GroupRole::ADMIN, $role);
    }

    #[Test]
    public function it_can_check_user_permissions()
    {
        $group = Group::factory()->create(['creator_id' => $this->creator->id]);
        $group->assignCreatorAsAdmin();

        // Admin should have all permissions
        $this->assertTrue($group->userHasPermission($this->creator, GroupPermission::CHANGE_MEMBER_ROLES));
        $this->assertTrue($group->userHasPermission($this->creator, GroupPermission::REMOVE_MEMBERS));
        $this->assertTrue($group->userHasPermission($this->creator, GroupPermission::EDIT_GROUP));

        // Regular member should have limited permissions
        $group->memberships()->attach($this->user->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->assertFalse($group->userHasPermission($this->user, GroupPermission::CHANGE_MEMBER_ROLES));
        $this->assertTrue($group->userHasPermission($this->user, GroupPermission::VIEW_GROUP));
    }

    #[Test]
    public function it_can_change_user_roles()
    {
        $group = Group::factory()->create(['creator_id' => $this->creator->id]);
        $group->assignCreatorAsAdmin();
        
        // Add user as member
        $group->memberships()->attach($this->user->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Change role to moderator
        $result = $group->changeUserRole($this->user, GroupRole::MODERATOR, $this->creator);
        $this->assertTrue($result);
        
        // Verify role change
        $this->assertTrue($group->isModerator($this->user));
        $this->assertEquals(GroupRole::MODERATOR, $group->getUserRole($this->user));
    }

    #[Test]
    public function it_validates_role_assignment_permissions()
    {
        $group = Group::factory()->create(['creator_id' => $this->creator->id]);
        $group->assignCreatorAsAdmin();
        
        $regularUser = User::factory()->create();
        $group->memberships()->attach($regularUser->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Regular member cannot assign admin roles
        $this->assertFalse($group->userCanAssignRole($regularUser, GroupRole::ADMIN));
        
        // Admin can assign lower roles
        $this->assertTrue($group->userCanAssignRole($this->creator, GroupRole::MODERATOR));
        $this->assertTrue($group->userCanAssignRole($this->creator, GroupRole::MEMBER));
    }

    #[Test]
    public function it_gets_correct_sport_specific_validation_rules()
    {
        $footballRules = Group::getSportSpecificValidationRules('football');
        $this->assertEquals('nullable|integer|min:6|max:11', $footballRules['min_players']);

        $badmintonRules = Group::getSportSpecificValidationRules('badminton');
        $this->assertEquals('nullable|integer|min:2|max:2', $badmintonRules['min_players']);

        $tennisRules = Group::getSportSpecificValidationRules('tennis');
        $this->assertEquals('nullable|integer|min:2|max:2', $tennisRules['min_players']);

        $pickleballRules = Group::getSportSpecificValidationRules('pickleball');
        $this->assertEquals('nullable|integer|min:2|max:2', $pickleballRules['min_players']);
    }

    #[Test]
    public function it_assigns_creator_as_admin_automatically()
    {
        $group = Group::factory()->create([
            'creator_id' => $this->creator->id,
            'current_members' => 0
        ]);
        
        $this->assertFalse($group->isMember($this->creator));
        
        $group->assignCreatorAsAdmin();
        
        $this->assertTrue($group->isAdmin($this->creator));
        $this->assertTrue($group->isMember($this->creator));
        $this->assertEquals(1, $group->fresh()->current_members);
    }

    #[Test]
    public function it_handles_existing_membership_when_assigning_creator()
    {
        $group = Group::factory()->create(['creator_id' => $this->creator->id]);
        
        // First add creator as regular member
        $group->memberships()->attach($this->creator->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->assertTrue($group->isMember($this->creator));
        $this->assertFalse($group->isAdmin($this->creator));

        // Now assign as admin
        $group->assignCreatorAsAdmin();

        $this->assertTrue($group->isAdmin($this->creator));
        $this->assertEquals(GroupRole::ADMIN, $group->getUserRole($this->creator));
    }

    #[Test]
    public function it_logs_role_changes_in_member_notes()
    {
        $group = Group::factory()->create(['creator_id' => $this->creator->id]);
        $group->assignCreatorAsAdmin();
        
        // Add user as member
        $group->memberships()->attach($this->user->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Change role and verify logging
        $group->changeUserRole($this->user, GroupRole::MODERATOR, $this->creator);
        
        $membership = $group->memberships()->where('user_id', $this->user->id)->first();
        $memberNotes = $membership->pivot->member_notes;
        
        // Handle both string and array cases since Laravel might return JSON as string
        if (is_string($memberNotes)) {
            $memberNotes = json_decode($memberNotes, true);
        }
        
        $this->assertIsArray($memberNotes);
        $this->assertNotEmpty($memberNotes);
        
        $lastEntry = end($memberNotes);
        $this->assertEquals('role_change', $lastEntry['action']);
        $this->assertEquals('moderator', $lastEntry['new_role']);
        $this->assertEquals('Phó nhóm', $lastEntry['new_role_name']);
        $this->assertEquals($this->creator->name, $lastEntry['changed_by']);
    }
}