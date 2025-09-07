<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\User;
use App\Enums\GroupRole;
use App\Enums\GroupPermission;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class GroupRolePermissionTest extends TestCase
{
    use RefreshDatabase;

    private User $admin;
    private User $moderator; 
    private User $member;
    private User $guest;
    private User $outsider;
    private Group $group;

    protected function setUp(): void
    {
        parent::setUp();
        
        // Create users with different roles
        $this->admin = User::factory()->create(['name' => 'Admin User']);
        $this->moderator = User::factory()->create(['name' => 'Moderator User']);
        $this->member = User::factory()->create(['name' => 'Member User']);
        $this->guest = User::factory()->create(['name' => 'Guest User']);
        $this->outsider = User::factory()->create(['name' => 'Outsider User']);

        // Create a group
        $this->group = Group::factory()->createdBy($this->admin)->create();
        $this->group->assignCreatorAsAdmin();

        // Assign roles
        $this->group->memberships()->attach($this->moderator->id, [
            'role' => GroupRole::MODERATOR->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->group->memberships()->attach($this->member->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->group->memberships()->attach($this->guest->id, [
            'role' => GroupRole::GUEST->value,
            'status' => 'hoat_dong',
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    /** @test */
    public function admin_can_change_member_roles()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$this->member->id}/role", [
            'role' => 'moderator'
        ]);

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'message' => 'Vai trò thành viên đã được cập nhật'
                 ]);

        $this->assertTrue($this->group->isModerator($this->member));
    }

    /** @test */
    public function moderator_cannot_assign_admin_roles()
    {
        Sanctum::actingAs($this->moderator);

        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$this->member->id}/role", [
            'role' => 'admin'
        ]);

        $response->assertStatus(403)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn không có quyền gán vai trò này'
                 ]);
    }

    /** @test */
    public function moderator_can_assign_member_and_guest_roles()
    {
        Sanctum::actingAs($this->moderator);

        // Change member to guest
        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$this->member->id}/role", [
            'role' => 'guest'
        ]);

        $response->assertStatus(200);
        $this->assertEquals(GroupRole::GUEST, $this->group->getUserRole($this->member));

        // Change guest to member
        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$this->guest->id}/role", [
            'role' => 'member'
        ]);

        $response->assertStatus(200);
        $this->assertEquals(GroupRole::MEMBER, $this->group->getUserRole($this->guest));
    }

    /** @test */
    public function regular_member_cannot_change_roles()
    {
        Sanctum::actingAs($this->member);

        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$this->guest->id}/role", [
            'role' => 'member'
        ]);

        $response->assertStatus(403);
    }

    /** @test */
    public function admin_can_remove_members()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->deleteJson("/api/groups/{$this->group->id}/members/{$this->member->id}");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'message' => 'Thành viên đã bị loại bỏ khỏi nhóm'
                 ]);

        $this->assertFalse($this->group->isMember($this->member));
        $this->assertEquals(3, $this->group->fresh()->current_members); // Should decrease by 1
    }

    /** @test */
    public function moderator_can_remove_members_and_guests()
    {
        Sanctum::actingAs($this->moderator);

        // Can remove member
        $response = $this->deleteJson("/api/groups/{$this->group->id}/members/{$this->member->id}");
        $response->assertStatus(200);

        // Can remove guest
        $response = $this->deleteJson("/api/groups/{$this->group->id}/members/{$this->guest->id}");
        $response->assertStatus(200);
    }

    /** @test */
    public function moderator_cannot_remove_admin()
    {
        Sanctum::actingAs($this->moderator);

        $response = $this->deleteJson("/api/groups/{$this->group->id}/members/{$this->admin->id}");

        $response->assertStatus(403);
    }

    /** @test */
    public function admin_can_edit_group_settings()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->putJson("/api/groups/{$this->group->id}", [
            'name' => 'Updated Group Name',
            'description' => 'Updated description',
            'monthly_fee' => 250000,
        ]);

        $response->assertStatus(200);

        $this->assertDatabaseHas('groups', [
            'id' => $this->group->id,
            'name' => 'Updated Group Name',
            'description' => 'Updated description',
            'monthly_fee' => 250000,
        ]);
    }

    /** @test */
    public function moderator_can_edit_limited_group_settings()
    {
        Sanctum::actingAs($this->moderator);

        $response = $this->putJson("/api/groups/{$this->group->id}", [
            'description' => 'Updated by moderator',
            'rules' => ['New rule 1', 'New rule 2'],
        ]);

        $response->assertStatus(200);

        $this->assertDatabaseHas('groups', [
            'id' => $this->group->id,
            'description' => 'Updated by moderator',
        ]);
    }

    /** @test */
    public function member_cannot_edit_group_settings()
    {
        Sanctum::actingAs($this->member);

        $response = $this->putJson("/api/groups/{$this->group->id}", [
            'name' => 'Hacked name',
        ]);

        $response->assertStatus(403);
    }

    /** @test */
    public function admin_can_manage_group_events()
    {
        Sanctum::actingAs($this->admin);

        $eventData = [
            'title' => 'Weekly Training',
            'description' => 'Regular training session',
            'scheduled_at' => now()->addDays(3)->toISOString(),
            'location' => 'Main Court',
        ];

        $response = $this->postJson("/api/groups/{$this->group->id}/events", $eventData);

        $response->assertStatus(201);
    }

    /** @test */
    public function moderator_can_manage_group_events()
    {
        Sanctum::actingAs($this->moderator);

        $eventData = [
            'title' => 'Training Session',
            'description' => 'Practice match',
            'scheduled_at' => now()->addDays(2)->toISOString(),
            'location' => 'Court A',
        ];

        $response = $this->postJson("/api/groups/{$this->group->id}/events", $eventData);

        $response->assertStatus(201);
    }

    /** @test */
    public function member_cannot_create_events()
    {
        Sanctum::actingAs($this->member);

        $eventData = [
            'title' => 'Unauthorized Event',
            'description' => 'Should not be allowed',
            'scheduled_at' => now()->addDays(1)->toISOString(),
            'location' => 'Nowhere',
        ];

        $response = $this->postJson("/api/groups/{$this->group->id}/events", $eventData);

        $response->assertStatus(403);
    }

    /** @test */
    public function all_members_can_view_group_content()
    {
        $roles = [$this->admin, $this->moderator, $this->member, $this->guest];

        foreach ($roles as $user) {
            Sanctum::actingAs($user);

            $response = $this->getJson("/api/groups/{$this->group->id}");
            $response->assertStatus(200);

            $response = $this->getJson("/api/groups/{$this->group->id}/members");
            $response->assertStatus(200);
        }
    }

    /** @test */
    public function outsider_cannot_view_private_group_content()
    {
        // Make group private
        $this->group->update(['privacy' => 'rieng_tu']);

        Sanctum::actingAs($this->outsider);

        $response = $this->getJson("/api/groups/{$this->group->id}");
        $response->assertStatus(403);

        $response = $this->getJson("/api/groups/{$this->group->id}/members");
        $response->assertStatus(403);
    }

    /** @test */
    public function admin_can_approve_pending_members()
    {
        $pendingUser = User::factory()->create();
        
        // Add user with pending status
        $this->group->memberships()->attach($pendingUser->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'pending',
            'joined_at' => null,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        Sanctum::actingAs($this->admin);

        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$pendingUser->id}/approve");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'message' => 'Thành viên đã được phê duyệt'
                 ]);

        $membership = $this->group->memberships()->where('user_id', $pendingUser->id)->first();
        $this->assertEquals('hoat_dong', $membership->pivot->status);
        $this->assertNotNull($membership->pivot->joined_at);
    }

    /** @test */
    public function moderator_can_approve_pending_members()
    {
        $pendingUser = User::factory()->create();
        
        $this->group->memberships()->attach($pendingUser->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'pending',
            'joined_at' => null,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        Sanctum::actingAs($this->moderator);

        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$pendingUser->id}/approve");

        $response->assertStatus(200);
    }

    /** @test */
    public function admin_can_reject_pending_members()
    {
        $pendingUser = User::factory()->create();
        
        $this->group->memberships()->attach($pendingUser->id, [
            'role' => GroupRole::MEMBER->value,
            'status' => 'pending',
            'joined_at' => null,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        Sanctum::actingAs($this->admin);

        $response = $this->deleteJson("/api/groups/{$this->group->id}/members/{$pendingUser->id}/reject");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'message' => 'Yêu cầu tham gia đã bị từ chối'
                 ]);

        $this->assertFalse($this->group->memberships()->where('user_id', $pendingUser->id)->exists());
    }

    /** @test */
    public function permission_middleware_blocks_unauthorized_actions()
    {
        Sanctum::actingAs($this->member);

        // Test various endpoints that should be blocked for members
        $blockedEndpoints = [
            ['method' => 'put', 'url' => "/api/groups/{$this->group->id}/members/{$this->guest->id}/role"],
            ['method' => 'delete', 'url' => "/api/groups/{$this->group->id}/members/{$this->guest->id}"],
            ['method' => 'put', 'url' => "/api/groups/{$this->group->id}/settings"],
            ['method' => 'post', 'url' => "/api/groups/{$this->group->id}/events"],
            ['method' => 'delete', 'url' => "/api/groups/{$this->group->id}"],
        ];

        foreach ($blockedEndpoints as $endpoint) {
            $response = $this->json($endpoint['method'], $endpoint['url'], []);
            $response->assertStatus(403);
        }
    }

    /** @test */
    public function role_changes_are_logged_with_audit_trail()
    {
        Sanctum::actingAs($this->admin);

        // Change member to moderator
        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$this->member->id}/role", [
            'role' => 'moderator'
        ]);

        $response->assertStatus(200);

        // Check that the role change is logged in member_notes
        $membership = $this->group->memberships()->where('user_id', $this->member->id)->first();
        $memberNotes = $membership->pivot->member_notes;

        $this->assertStringContains('Vai trò được thay đổi thành', $memberNotes);
        $this->assertStringContains('Phó nhóm', $memberNotes);
        $this->assertStringContains($this->admin->name, $memberNotes);
        $this->assertStringContains(now()->format('Y-m-d'), $memberNotes);
    }

    /** @test */
    public function group_permissions_are_correctly_enforced_by_middleware()
    {
        $testCases = [
            // Admin permissions
            ['user' => $this->admin, 'permission' => GroupPermission::CHANGE_MEMBER_ROLES, 'should_allow' => true],
            ['user' => $this->admin, 'permission' => GroupPermission::REMOVE_MEMBERS, 'should_allow' => true],
            ['user' => $this->admin, 'permission' => GroupPermission::EDIT_GROUP, 'should_allow' => true],
            ['user' => $this->admin, 'permission' => GroupPermission::DELETE_GROUP, 'should_allow' => true],
            
            // Moderator permissions
            ['user' => $this->moderator, 'permission' => GroupPermission::CHANGE_MEMBER_ROLES, 'should_allow' => true],
            ['user' => $this->moderator, 'permission' => GroupPermission::REMOVE_MEMBERS, 'should_allow' => true],
            ['user' => $this->moderator, 'permission' => GroupPermission::EDIT_GROUP, 'should_allow' => false],
            ['user' => $this->moderator, 'permission' => GroupPermission::DELETE_GROUP, 'should_allow' => false],
            
            // Member permissions
            ['user' => $this->member, 'permission' => GroupPermission::VIEW_GROUP, 'should_allow' => true],
            ['user' => $this->member, 'permission' => GroupPermission::VIEW_MEMBERS, 'should_allow' => true],
            ['user' => $this->member, 'permission' => GroupPermission::CHANGE_MEMBER_ROLES, 'should_allow' => false],
            ['user' => $this->member, 'permission' => GroupPermission::REMOVE_MEMBERS, 'should_allow' => false],
            
            // Guest permissions
            ['user' => $this->guest, 'permission' => GroupPermission::VIEW_GROUP, 'should_allow' => true],
            ['user' => $this->guest, 'permission' => GroupPermission::VIEW_MEMBERS, 'should_allow' => false],
            ['user' => $this->guest, 'permission' => GroupPermission::PARTICIPATE_EVENTS, 'should_allow' => false],
        ];

        foreach ($testCases as $testCase) {
            $hasPermission = $this->group->userHasPermission($testCase['user'], $testCase['permission']);
            
            if ($testCase['should_allow']) {
                $this->assertTrue($hasPermission, 
                    "{$testCase['user']->name} should have permission {$testCase['permission']->value}");
            } else {
                $this->assertFalse($hasPermission, 
                    "{$testCase['user']->name} should NOT have permission {$testCase['permission']->value}");
            }
        }
    }

    /** @test */
    public function admin_cannot_remove_themselves_from_group()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->deleteJson("/api/groups/{$this->group->id}/members/{$this->admin->id}");

        $response->assertStatus(422)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Không thể loại bỏ người tạo nhóm'
                 ]);

        $this->assertTrue($this->group->isAdmin($this->admin));
    }

    /** @test */
    public function admin_cannot_change_their_own_role()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->putJson("/api/groups/{$this->group->id}/members/{$this->admin->id}/role", [
            'role' => 'member'
        ]);

        $response->assertStatus(422)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Không thể thay đổi vai trò của người tạo nhóm'
                 ]);

        $this->assertTrue($this->group->isAdmin($this->admin));
    }
}