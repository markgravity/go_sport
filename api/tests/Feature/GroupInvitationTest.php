<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\User;
use App\Models\GroupInvitation;
use App\Models\GroupJoinRequest;
use App\Enums\GroupRole;
use Carbon\Carbon;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class GroupInvitationTest extends TestCase
{
    use RefreshDatabase;

    private User $admin;
    private User $moderator;
    private User $member;
    private User $outsider;
    private Group $group;

    protected function setUp(): void
    {
        parent::setUp();
        
        $this->admin = User::factory()->create();
        $this->moderator = User::factory()->create();
        $this->member = User::factory()->create();
        $this->outsider = User::factory()->create();
        
        $this->group = Group::factory()->create(['creator_id' => $this->admin->id]);
        
        // Set up group membership
        $this->group->memberships()->create([
            'user_id' => $this->admin->id,
            'role' => GroupRole::ADMIN,
            'joined_at' => now(),
        ]);
        
        $this->group->memberships()->create([
            'user_id' => $this->moderator->id,
            'role' => GroupRole::MODERATOR,
            'joined_at' => now(),
        ]);
        
        $this->group->memberships()->create([
            'user_id' => $this->member->id,
            'role' => GroupRole::MEMBER,
            'joined_at' => now(),
        ]);
    }

    /** @test */
    public function admin_can_create_invitation()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->postJson("/api/groups/{$this->group->id}/invitations", [
            'type' => 'link',
            'expires_in_days' => 7
        ]);

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'id',
                         'token',
                         'type',
                         'status',
                         'expires_at',
                         'created_at'
                     ]
                 ]);

        $this->assertDatabaseHas('group_invitations', [
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'type' => 'link',
            'status' => 'active'
        ]);
    }

    /** @test */
    public function moderator_can_create_invitation()
    {
        Sanctum::actingAs($this->moderator);

        $response = $this->postJson("/api/groups/{$this->group->id}/invitations", [
            'type' => 'link',
            'expires_in_days' => 30
        ]);

        $response->assertStatus(200);
        
        $this->assertDatabaseHas('group_invitations', [
            'group_id' => $this->group->id,
            'created_by' => $this->moderator->id,
            'type' => 'link',
            'status' => 'active'
        ]);
    }

    /** @test */
    public function regular_member_cannot_create_invitation()
    {
        Sanctum::actingAs($this->member);

        $response = $this->postJson("/api/groups/{$this->group->id}/invitations", [
            'type' => 'link',
            'expires_in_days' => 7
        ]);

        $response->assertStatus(403)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn không có quyền tạo lời mời'
                 ]);
    }

    /** @test */
    public function outsider_cannot_create_invitation()
    {
        Sanctum::actingAs($this->outsider);

        $response = $this->postJson("/api/groups/{$this->group->id}/invitations", [
            'type' => 'link'
        ]);

        $response->assertStatus(403);
    }

    /** @test */
    public function can_list_group_invitations()
    {
        Sanctum::actingAs($this->admin);

        // Create some invitations
        GroupInvitation::factory()->count(3)->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/invitations");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'data' => [
                             '*' => [
                                 'id',
                                 'token',
                                 'type',
                                 'status',
                                 'expires_at',
                                 'created_at'
                             ]
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function can_get_specific_invitation()
    {
        Sanctum::actingAs($this->admin);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/invitations/{$invitation->id}");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'id' => $invitation->id,
                         'token' => $invitation->token
                     ]
                 ]);
    }

    /** @test */
    public function can_delete_own_invitation()
    {
        Sanctum::actingAs($this->admin);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        $response = $this->deleteJson("/api/groups/{$this->group->id}/invitations/{$invitation->id}");

        $response->assertStatus(200);
        
        $this->assertDatabaseHas('group_invitations', [
            'id' => $invitation->id,
            'status' => 'revoked'
        ]);
    }

    /** @test */
    public function cannot_delete_invitation_from_other_group()
    {
        Sanctum::actingAs($this->admin);

        $otherGroup = Group::factory()->create();
        $invitation = GroupInvitation::factory()->create([
            'group_id' => $otherGroup->id,
            'created_by' => $this->admin->id
        ]);

        $response = $this->deleteJson("/api/groups/{$this->group->id}/invitations/{$invitation->id}");

        $response->assertStatus(404);
    }

    /** @test */
    public function can_validate_invitation_token()
    {
        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'status' => 'active',
            'expires_at' => now()->addDays(7)
        ]);

        $response = $this->getJson("/api/invitations/validate/{$invitation->token}");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'valid' => true,
                         'invitation' => [
                             'id' => $invitation->id,
                             'type' => $invitation->type
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function expired_invitation_is_invalid()
    {
        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'status' => 'active',
            'expires_at' => now()->subDay()
        ]);

        $response = $this->getJson("/api/invitations/validate/{$invitation->token}");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'valid' => false,
                         'reason' => 'expired'
                     ]
                 ]);
    }

    /** @test */
    public function revoked_invitation_is_invalid()
    {
        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'status' => 'revoked',
            'expires_at' => now()->addDays(7)
        ]);

        $response = $this->getJson("/api/invitations/validate/{$invitation->token}");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'valid' => false,
                         'reason' => 'revoked'
                     ]
                 ]);
    }

    /** @test */
    public function can_get_group_preview_from_invitation()
    {
        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'status' => 'active',
            'expires_at' => now()->addDays(7)
        ]);

        $response = $this->getJson("/api/invitations/preview/{$invitation->token}");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'group' => [
                             'id',
                             'name',
                             'sport_type',
                             'location',
                             'current_members',
                             'max_members'
                         ],
                         'invitation' => [
                             'id',
                             'type',
                             'expires_at'
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function invitation_expires_correctly()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->postJson("/api/groups/{$this->group->id}/invitations", [
            'type' => 'link',
            'expires_in_days' => 7
        ]);

        $invitation = GroupInvitation::where('group_id', $this->group->id)->latest()->first();
        
        $expectedExpiry = now()->addDays(7)->startOfDay();
        $actualExpiry = Carbon::parse($invitation->expires_at)->startOfDay();
        
        $this->assertEquals($expectedExpiry->toDateString(), $actualExpiry->toDateString());
    }

    /** @test */
    public function permanent_invitation_has_no_expiry()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->postJson("/api/groups/{$this->group->id}/invitations", [
            'type' => 'link',
            'expires_in_days' => null
        ]);

        $invitation = GroupInvitation::where('group_id', $this->group->id)->latest()->first();
        
        $this->assertNull($invitation->expires_at);
    }

    /** @test */
    public function invitation_token_is_unique()
    {
        Sanctum::actingAs($this->admin);

        // Create multiple invitations
        $this->postJson("/api/groups/{$this->group->id}/invitations", ['type' => 'link']);
        $this->postJson("/api/groups/{$this->group->id}/invitations", ['type' => 'link']);
        $this->postJson("/api/groups/{$this->group->id}/invitations", ['type' => 'link']);

        $tokens = GroupInvitation::where('group_id', $this->group->id)
                                 ->pluck('token')
                                 ->toArray();

        $this->assertEquals(count($tokens), count(array_unique($tokens)));
    }

    /** @test */
    public function invitation_url_is_properly_formatted()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->postJson("/api/groups/{$this->group->id}/invitations", [
            'type' => 'link'
        ]);

        $invitation = $response->json('data');
        
        $this->assertArrayHasKey('invitation_url', $invitation);
        $this->assertStringContains($invitation['token'], $invitation['invitation_url']);
    }

    /** @test */
    public function can_create_join_request_with_valid_invitation()
    {
        Sanctum::actingAs($this->outsider);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'status' => 'active',
            'expires_at' => now()->addDays(7)
        ]);

        $response = $this->postJson('/api/join-requests', [
            'group_id' => $this->group->id,
            'invitation_id' => $invitation->id,
            'message' => 'I would like to join this group',
            'source' => 'invitation_link'
        ]);

        $response->assertStatus(200);
        
        $this->assertDatabaseHas('group_join_requests', [
            'user_id' => $this->outsider->id,
            'group_id' => $this->group->id,
            'invitation_id' => $invitation->id,
            'status' => 'pending'
        ]);
    }
}