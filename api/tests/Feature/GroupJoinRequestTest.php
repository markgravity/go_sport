<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\User;
use App\Models\GroupInvitation;
use App\Models\GroupJoinRequest;
use App\Enums\GroupRole;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class GroupJoinRequestTest extends TestCase
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
    public function user_can_create_join_request()
    {
        Sanctum::actingAs($this->outsider);

        $response = $this->postJson('/api/join-requests', [
            'group_id' => $this->group->id,
            'message' => 'I would like to join your group',
            'source' => 'direct'
        ]);

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'id',
                         'user_id',
                         'group_id',
                         'status',
                         'message',
                         'source',
                         'created_at'
                     ]
                 ]);

        $this->assertDatabaseHas('group_join_requests', [
            'user_id' => $this->outsider->id,
            'group_id' => $this->group->id,
            'status' => 'pending',
            'message' => 'I would like to join your group'
        ]);
    }

    /** @test */
    public function user_can_create_join_request_with_invitation()
    {
        Sanctum::actingAs($this->outsider);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        $response = $this->postJson('/api/join-requests', [
            'group_id' => $this->group->id,
            'invitation_id' => $invitation->id,
            'message' => 'Joining via invitation',
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

    /** @test */
    public function user_cannot_create_duplicate_pending_join_request()
    {
        Sanctum::actingAs($this->outsider);

        // Create first join request
        GroupJoinRequest::create([
            'user_id' => $this->outsider->id,
            'group_id' => $this->group->id,
            'status' => 'pending',
            'source' => 'direct',
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Try to create another
        $response = $this->postJson('/api/join-requests', [
            'group_id' => $this->group->id,
            'message' => 'Another request',
            'source' => 'direct'
        ]);

        $response->assertStatus(422)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn đã có yêu cầu tham gia đang chờ xử lý cho nhóm này'
                 ]);
    }

    /** @test */
    public function existing_member_cannot_create_join_request()
    {
        Sanctum::actingAs($this->member);

        $response = $this->postJson('/api/join-requests', [
            'group_id' => $this->group->id,
            'message' => 'I want to join again',
            'source' => 'direct'
        ]);

        $response->assertStatus(422)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn đã là thành viên của nhóm này'
                 ]);
    }

    /** @test */
    public function admin_can_view_group_join_requests()
    {
        Sanctum::actingAs($this->admin);

        // Create some join requests
        GroupJoinRequest::factory()->count(3)->create([
            'group_id' => $this->group->id,
            'status' => 'pending'
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/join-requests");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'data' => [
                             '*' => [
                                 'id',
                                 'user_id',
                                 'group_id',
                                 'status',
                                 'message',
                                 'created_at',
                                 'user' => [
                                     'id',
                                     'name',
                                     'email'
                                 ]
                             ]
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function moderator_can_view_group_join_requests()
    {
        Sanctum::actingAs($this->moderator);

        GroupJoinRequest::factory()->create([
            'group_id' => $this->group->id,
            'status' => 'pending'
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/join-requests");

        $response->assertStatus(200);
    }

    /** @test */
    public function regular_member_cannot_view_group_join_requests()
    {
        Sanctum::actingAs($this->member);

        $response = $this->getJson("/api/groups/{$this->group->id}/join-requests");

        $response->assertStatus(403)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn không có quyền xem yêu cầu tham gia'
                 ]);
    }

    /** @test */
    public function admin_can_approve_join_request()
    {
        Sanctum::actingAs($this->admin);

        $joinRequest = GroupJoinRequest::factory()->create([
            'group_id' => $this->group->id,
            'user_id' => $this->outsider->id,
            'status' => 'pending'
        ]);

        $response = $this->postJson("/api/groups/{$this->group->id}/join-requests/{$joinRequest->id}/approve", [
            'role' => 'member'
        ]);

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'status' => 'approved'
                     ]
                 ]);

        // Check join request status
        $this->assertDatabaseHas('group_join_requests', [
            'id' => $joinRequest->id,
            'status' => 'approved'
        ]);

        // Check user was added to group
        $this->assertDatabaseHas('group_memberships', [
            'group_id' => $this->group->id,
            'user_id' => $this->outsider->id,
            'role' => GroupRole::MEMBER->value
        ]);
    }

    /** @test */
    public function moderator_can_approve_join_request()
    {
        Sanctum::actingAs($this->moderator);

        $joinRequest = GroupJoinRequest::factory()->create([
            'group_id' => $this->group->id,
            'user_id' => $this->outsider->id,
            'status' => 'pending'
        ]);

        $response = $this->postJson("/api/groups/{$this->group->id}/join-requests/{$joinRequest->id}/approve");

        $response->assertStatus(200);
        
        $this->assertDatabaseHas('group_join_requests', [
            'id' => $joinRequest->id,
            'status' => 'approved'
        ]);
    }

    /** @test */
    public function admin_can_reject_join_request()
    {
        Sanctum::actingAs($this->admin);

        $joinRequest = GroupJoinRequest::factory()->create([
            'group_id' => $this->group->id,
            'user_id' => $this->outsider->id,
            'status' => 'pending'
        ]);

        $response = $this->postJson("/api/groups/{$this->group->id}/join-requests/{$joinRequest->id}/reject", [
            'reason' => 'Not suitable for the group'
        ]);

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'status' => 'rejected'
                     ]
                 ]);

        $this->assertDatabaseHas('group_join_requests', [
            'id' => $joinRequest->id,
            'status' => 'rejected',
            'admin_message' => 'Not suitable for the group'
        ]);

        // User should not be added to group
        $this->assertDatabaseMissing('group_memberships', [
            'group_id' => $this->group->id,
            'user_id' => $this->outsider->id
        ]);
    }

    /** @test */
    public function regular_member_cannot_approve_join_request()
    {
        Sanctum::actingAs($this->member);

        $joinRequest = GroupJoinRequest::factory()->create([
            'group_id' => $this->group->id,
            'status' => 'pending'
        ]);

        $response = $this->postJson("/api/groups/{$this->group->id}/join-requests/{$joinRequest->id}/approve");

        $response->assertStatus(403);
    }

    /** @test */
    public function user_can_view_their_own_join_requests()
    {
        Sanctum::actingAs($this->outsider);

        $joinRequest = GroupJoinRequest::factory()->create([
            'user_id' => $this->outsider->id,
            'group_id' => $this->group->id,
            'status' => 'pending'
        ]);

        $response = $this->getJson('/api/join-requests/my-requests');

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'data' => [
                             '*' => [
                                 'id',
                                 'group_id',
                                 'status',
                                 'message',
                                 'created_at',
                                 'group' => [
                                     'id',
                                     'name',
                                     'sport_type'
                                 ]
                             ]
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function user_can_cancel_their_pending_join_request()
    {
        Sanctum::actingAs($this->outsider);

        $joinRequest = GroupJoinRequest::factory()->create([
            'user_id' => $this->outsider->id,
            'group_id' => $this->group->id,
            'status' => 'pending'
        ]);

        $response = $this->deleteJson("/api/join-requests/{$joinRequest->id}");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'message' => 'Đã hủy yêu cầu tham gia'
                 ]);

        $this->assertDatabaseMissing('group_join_requests', [
            'id' => $joinRequest->id
        ]);
    }

    /** @test */
    public function user_cannot_cancel_processed_join_request()
    {
        Sanctum::actingAs($this->outsider);

        $joinRequest = GroupJoinRequest::factory()->create([
            'user_id' => $this->outsider->id,
            'group_id' => $this->group->id,
            'status' => 'approved'
        ]);

        $response = $this->deleteJson("/api/join-requests/{$joinRequest->id}");

        $response->assertStatus(422)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Không thể hủy yêu cầu đã được xử lý'
                 ]);
    }

    /** @test */
    public function user_cannot_cancel_others_join_request()
    {
        Sanctum::actingAs($this->member);

        $joinRequest = GroupJoinRequest::factory()->create([
            'user_id' => $this->outsider->id,
            'group_id' => $this->group->id,
            'status' => 'pending'
        ]);

        $response = $this->deleteJson("/api/join-requests/{$joinRequest->id}");

        $response->assertStatus(403);
    }

    /** @test */
    public function cannot_approve_already_processed_join_request()
    {
        Sanctum::actingAs($this->admin);

        $joinRequest = GroupJoinRequest::factory()->create([
            'group_id' => $this->group->id,
            'status' => 'approved'
        ]);

        $response = $this->postJson("/api/groups/{$this->group->id}/join-requests/{$joinRequest->id}/approve");

        $response->assertStatus(422)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Yêu cầu này đã được xử lý'
                 ]);
    }

    /** @test */
    public function join_request_can_filter_by_status()
    {
        Sanctum::actingAs($this->admin);

        GroupJoinRequest::factory()->create([
            'group_id' => $this->group->id,
            'status' => 'pending'
        ]);

        GroupJoinRequest::factory()->create([
            'group_id' => $this->group->id,
            'status' => 'approved'
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/join-requests?status=pending");

        $response->assertStatus(200);
        
        $requests = $response->json('data.data');
        
        $this->assertCount(1, $requests);
        $this->assertEquals('pending', $requests[0]['status']);
    }
}