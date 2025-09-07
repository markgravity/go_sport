<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\User;
use App\Enums\GroupRole;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class GroupCreationTest extends TestCase
{
    use RefreshDatabase;

    private User $user;

    protected function setUp(): void
    {
        parent::setUp();
        
        $this->user = User::factory()->create();
    }

    /** @test */
    public function authenticated_user_can_create_a_group_with_valid_data()
    {
        Sanctum::actingAs($this->user);

        $groupData = [
            'name' => 'Nhóm Cầu Lông Hà Nội',
            'vietnamese_name' => 'Hanoi Badminton Club',
            'description' => 'Nhóm cầu lông cho người yêu thích thể thao',
            'sport_type' => 'badminton',
            'location' => 'Sân cầu lông ABC, 123 Đường XYZ',
            'city' => 'Hà Nội',
            'district' => 'Ba Đình',
            'min_players' => 2,
            'monthly_fee' => 200000,
            'privacy' => 'cong_khai',
            'auto_approve_members' => true,
        ];

        $response = $this->postJson('/api/groups', $groupData);

        $response->assertStatus(201)
                 ->assertJsonStructure([
                     'success',
                     'message',
                     'data' => [
                         'id',
                         'name',
                         'sport_type',
                         'location',
                         'city',
                         'creator_id',
                         'privacy',
                         'status',
                         'created_at',
                         'updated_at',
                     ]
                 ]);

        $this->assertDatabaseHas('groups', [
            'name' => 'Nhóm Cầu Lông Hà Nội',
            'sport_type' => 'badminton',
            'creator_id' => $this->user->id,
        ]);
    }

    /** @test */
    public function creator_is_automatically_assigned_as_admin_after_group_creation()
    {
        Sanctum::actingAs($this->user);

        $groupData = [
            'name' => 'Test Group',
            'sport_type' => 'badminton',
            'location' => 'Test Location',
            'city' => 'Test City',
            'privacy' => 'cong_khai',
        ];

        $response = $this->postJson('/api/groups', $groupData);
        $response->assertStatus(201);

        $group = Group::where('name', 'Test Group')->first();
        $this->assertNotNull($group);
        $this->assertTrue($group->isAdmin($this->user));
        $this->assertEquals(1, $group->current_members);
    }

    /** @test */
    public function unauthenticated_user_cannot_create_group()
    {
        $groupData = [
            'name' => 'Test Group',
            'sport_type' => 'badminton',
            'location' => 'Test Location',
            'city' => 'Test City',
            'privacy' => 'cong_khai',
        ];

        $response = $this->postJson('/api/groups', $groupData);

        $response->assertStatus(401);
    }

    /** @test */
    public function group_creation_validates_required_fields()
    {
        Sanctum::actingAs($this->user);

        $response = $this->postJson('/api/groups', []);

        $response->assertStatus(422)
                 ->assertJsonValidationErrors(['name', 'sport_type', 'location', 'city', 'privacy']);
    }

    /** @test */
    public function group_creation_validates_sport_type()
    {
        Sanctum::actingAs($this->user);

        $invalidSportTypes = ['invalid_sport', 'soccer', 'basketball'];

        foreach ($invalidSportTypes as $sportType) {
            $response = $this->postJson('/api/groups', [
                'name' => 'Test Group',
                'sport_type' => $sportType,
                'location' => 'Test Location',
                'city' => 'Test City',
                'privacy' => 'cong_khai',
            ]);

            $response->assertStatus(422)
                     ->assertJsonValidationErrors(['sport_type']);
        }
    }

    /** @test */
    public function group_creation_validates_vietnamese_name_pattern()
    {
        Sanctum::actingAs($this->user);

        $invalidNames = [
            'Group<script>alert("xss")</script>',
            'Group@#$%^&*',
            str_repeat('a', 256), // Too long
        ];

        foreach ($invalidNames as $name) {
            $response = $this->postJson('/api/groups', [
                'name' => $name,
                'sport_type' => 'badminton',
                'location' => 'Test Location',
                'city' => 'Test City',
                'privacy' => 'cong_khai',
            ]);

            $response->assertStatus(422);
        }
    }

    /** @test */
    public function group_creation_validates_sport_specific_min_players()
    {
        Sanctum::actingAs($this->user);

        $testCases = [
            ['sport_type' => 'football', 'min_players' => 5, 'should_fail' => true], // Too few for football
            ['sport_type' => 'football', 'min_players' => 8, 'should_fail' => false], // Valid for football
            ['sport_type' => 'badminton', 'min_players' => 3, 'should_fail' => true], // Too many for badminton
            ['sport_type' => 'badminton', 'min_players' => 2, 'should_fail' => false], // Valid for badminton
        ];

        foreach ($testCases as $testCase) {
            $response = $this->postJson('/api/groups', [
                'name' => 'Test Group ' . $testCase['sport_type'],
                'sport_type' => $testCase['sport_type'],
                'location' => 'Test Location',
                'city' => 'Test City',
                'privacy' => 'cong_khai',
                'min_players' => $testCase['min_players'],
            ]);

            if ($testCase['should_fail']) {
                $response->assertStatus(422)
                         ->assertJsonValidationErrors(['min_players']);
            } else {
                $response->assertStatus(201);
            }
        }
    }

    /** @test */
    public function group_creation_validates_privacy_setting()
    {
        Sanctum::actingAs($this->user);

        $invalidPrivacySettings = ['public', 'private', 'invalid'];

        foreach ($invalidPrivacySettings as $privacy) {
            $response = $this->postJson('/api/groups', [
                'name' => 'Test Group',
                'sport_type' => 'badminton',
                'location' => 'Test Location',
                'city' => 'Test City',
                'privacy' => $privacy,
            ]);

            $response->assertStatus(422)
                     ->assertJsonValidationErrors(['privacy']);
        }

        // Valid privacy settings
        $validPrivacySettings = ['cong_khai', 'rieng_tu'];
        
        foreach ($validPrivacySettings as $privacy) {
            $response = $this->postJson('/api/groups', [
                'name' => 'Test Group ' . $privacy,
                'sport_type' => 'badminton',
                'location' => 'Test Location',
                'city' => 'Test City',
                'privacy' => $privacy,
            ]);

            $response->assertStatus(201);
        }
    }

    /** @test */
    public function group_creation_handles_optional_fields()
    {
        Sanctum::actingAs($this->user);

        $groupData = [
            'name' => 'Complete Group',
            'vietnamese_name' => 'Vietnamese Name',
            'description' => 'Group description',
            'sport_type' => 'badminton',
            'location' => 'Test Location',
            'city' => 'Test City',
            'district' => 'Test District',
            'privacy' => 'cong_khai',
            'latitude' => 21.0285,
            'longitude' => 105.8542,
            'min_players' => 2,
            'monthly_fee' => 150000,
            'auto_approve_members' => false,
            'notification_hours_before' => 48,
            'rules' => ['Rule 1', 'Rule 2'],
            'default_locations' => ['Location A', 'Location B'],
            'sport_specific_settings' => ['court_type' => 'indoor'],
        ];

        $response = $this->postJson('/api/groups', $groupData);

        $response->assertStatus(201);

        $this->assertDatabaseHas('groups', [
            'name' => 'Complete Group',
            'vietnamese_name' => 'Vietnamese Name',
            'description' => 'Group description',
            'district' => 'Test District',
            'latitude' => 21.0285,
            'longitude' => 105.8542,
            'monthly_fee' => 150000,
            'auto_approve_members' => false,
            'notification_hours_before' => 48,
        ]);
    }

    /** @test */
    public function user_can_get_list_of_their_groups()
    {
        Sanctum::actingAs($this->user);

        // Create some groups for the user
        $group1 = Group::factory()->createdBy($this->user)->create(['name' => 'User Group 1']);
        $group2 = Group::factory()->createdBy($this->user)->create(['name' => 'User Group 2']);
        
        // Create a group by another user
        $otherUser = User::factory()->create();
        $otherGroup = Group::factory()->createdBy($otherUser)->create(['name' => 'Other Group']);

        // Both groups should automatically have creator as admin
        $group1->assignCreatorAsAdmin();
        $group2->assignCreatorAsAdmin();

        $response = $this->getJson('/api/groups');

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         '*' => [
                             'id',
                             'name',
                             'sport_type',
                             'location',
                             'city',
                             'privacy',
                             'current_members',
                             'creator_id'
                         ]
                     ]
                 ]);

        // Should contain user's groups but not the other user's group
        $responseData = $response->json('data');
        $groupNames = array_column($responseData, 'name');
        
        $this->assertContains('User Group 1', $groupNames);
        $this->assertContains('User Group 2', $groupNames);
        $this->assertNotContains('Other Group', $groupNames);
    }

    /** @test */
    public function user_can_get_specific_group_details()
    {
        Sanctum::actingAs($this->user);

        $group = Group::factory()->createdBy($this->user)->create();
        $group->assignCreatorAsAdmin();

        $response = $this->getJson("/api/groups/{$group->id}");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'id',
                         'name',
                         'sport_type',
                         'sport_name',
                         'location',
                         'city',
                         'privacy',
                         'privacy_name',
                         'status',
                         'status_name',
                         'creator_id',
                         'current_members',
                         'fee_per_member',
                         'created_at',
                         'updated_at',
                     ]
                 ]);

        $this->assertEquals($group->id, $response->json('data.id'));
    }

    /** @test */
    public function user_cannot_access_private_group_they_are_not_member_of()
    {
        Sanctum::actingAs($this->user);

        $otherUser = User::factory()->create();
        $privateGroup = Group::factory()
            ->createdBy($otherUser)
            ->private()
            ->create();

        $response = $this->getJson("/api/groups/{$privateGroup->id}");

        $response->assertStatus(403);
    }

    /** @test */
    public function user_can_access_public_group_they_are_not_member_of()
    {
        Sanctum::actingAs($this->user);

        $otherUser = User::factory()->create();
        $publicGroup = Group::factory()
            ->createdBy($otherUser)
            ->public()
            ->create();

        $response = $this->getJson("/api/groups/{$publicGroup->id}");

        $response->assertStatus(200);
    }

    /** @test */
    public function user_can_update_their_group()
    {
        Sanctum::actingAs($this->user);

        $group = Group::factory()->createdBy($this->user)->create();
        $group->assignCreatorAsAdmin();

        $updateData = [
            'name' => 'Updated Group Name',
            'description' => 'Updated description',
            'monthly_fee' => 300000,
        ];

        $response = $this->putJson("/api/groups/{$group->id}", $updateData);

        $response->assertStatus(200);

        $this->assertDatabaseHas('groups', [
            'id' => $group->id,
            'name' => 'Updated Group Name',
            'description' => 'Updated description',
            'monthly_fee' => 300000,
        ]);
    }

    /** @test */
    public function user_cannot_update_group_they_do_not_have_permission_for()
    {
        Sanctum::actingAs($this->user);

        $otherUser = User::factory()->create();
        $group = Group::factory()->createdBy($otherUser)->create();

        $updateData = [
            'name' => 'Hacked Group Name',
        ];

        $response = $this->putJson("/api/groups/{$group->id}", $updateData);

        $response->assertStatus(403);
    }

    /** @test */
    public function user_can_delete_their_group()
    {
        Sanctum::actingAs($this->user);

        $group = Group::factory()->createdBy($this->user)->create();
        $group->assignCreatorAsAdmin();

        $response = $this->deleteJson("/api/groups/{$group->id}");

        $response->assertStatus(200);

        $this->assertSoftDeleted('groups', ['id' => $group->id]);
    }

    /** @test */
    public function user_cannot_delete_group_they_do_not_have_permission_for()
    {
        Sanctum::actingAs($this->user);

        $otherUser = User::factory()->create();
        $group = Group::factory()->createdBy($otherUser)->create();

        $response = $this->deleteJson("/api/groups/{$group->id}");

        $response->assertStatus(403);
    }

    /** @test */
    public function group_creation_applies_sport_specific_defaults()
    {
        Sanctum::actingAs($this->user);

        $sportDefaults = [
            'football' => ['min_players' => 10, 'notification_hours_before' => 48],
            'badminton' => ['min_players' => 2, 'notification_hours_before' => 24],
            'pickleball' => ['min_players' => 2, 'notification_hours_before' => 12],
        ];

        foreach ($sportDefaults as $sport => $expected) {
            $response = $this->postJson('/api/groups', [
                'name' => "Test {$sport} Group",
                'sport_type' => $sport,
                'location' => 'Test Location',
                'city' => 'Test City',
                'privacy' => 'cong_khai',
                // Don't specify min_players or notification_hours_before to test defaults
            ]);

            $response->assertStatus(201);

            $group = Group::where('name', "Test {$sport} Group")->first();
            $this->assertEquals($expected['min_players'], $group->min_players);
            $this->assertEquals($expected['notification_hours_before'], $group->notification_hours_before);
        }
    }

    /** @test */
    public function group_creation_respects_rate_limiting()
    {
        Sanctum::actingAs($this->user);

        $groupData = [
            'name' => 'Rate Limited Group',
            'sport_type' => 'badminton',
            'location' => 'Test Location',
            'city' => 'Test City',
            'privacy' => 'cong_khai',
        ];

        // Create multiple groups quickly to test rate limiting
        // This assumes rate limiting is set to 5 groups per hour
        for ($i = 1; $i <= 6; $i++) {
            $groupData['name'] = "Rate Limited Group {$i}";
            $response = $this->postJson('/api/groups', $groupData);

            if ($i <= 5) {
                $response->assertStatus(201);
            } else {
                $response->assertStatus(429); // Too Many Requests
            }
        }
    }

    /** @test */
    public function group_creation_handles_image_upload()
    {
        Storage::fake('public');
        Sanctum::actingAs($this->user);

        $file = UploadedFile::fake()->image('group-avatar.jpg', 200, 200);

        $groupData = [
            'name' => 'Group with Avatar',
            'sport_type' => 'badminton',
            'location' => 'Test Location',
            'city' => 'Test City',
            'privacy' => 'cong_khai',
            'avatar' => $file,
        ];

        $response = $this->postJson('/api/groups', $groupData);

        $response->assertStatus(201);

        $group = Group::where('name', 'Group with Avatar')->first();
        $this->assertNotNull($group->avatar);
        
        Storage::disk('public')->assertExists($group->avatar);
    }
}