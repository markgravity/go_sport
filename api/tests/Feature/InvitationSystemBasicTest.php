<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\GroupInvitation;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class InvitationSystemBasicTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    protected User $groupCreator;
    protected User $regularUser;
    protected Group $testGroup;

    protected function setUp(): void
    {
        parent::setUp();

        // Create test users
        $this->groupCreator = User::create([
            'name' => 'Group Creator',
            'phone' => '0901234567',
            'email' => 'creator@test.com',
            'password' => bcrypt('password'),
            'email_verified_at' => now()
        ]);

        $this->regularUser = User::create([
            'name' => 'Regular User',
            'phone' => '0901234568',
            'email' => 'user@test.com',
            'password' => bcrypt('password'),
            'email_verified_at' => now()
        ]);

        // Create test group with creator membership
        $this->testGroup = Group::create([
            'name' => 'Test Group',
            'vietnamese_name' => 'Nhóm Test',
            'creator_id' => $this->groupCreator->id,
            'sport_type' => 'badminton',
            'privacy' => 'cong_khai',
            'location' => 'Test Location',
            'city' => 'Hà Nội',
            'district' => 'Ba Đình',
            'min_players' => 2,
            'current_members' => 1,
            'monthly_fee' => 100000,
            'status' => 'hoat_dong',
            'auto_approve_members' => true,
            'notification_hours_before' => 24
        ]);

        // Add creator as admin member
        $this->testGroup->memberships()->attach($this->groupCreator->id, [
            'role' => 'admin',
            'status' => 'hoat_dong',
            'joined_at' => now()
        ]);
    }

    /** @test */
    public function group_creator_can_create_link_invitation()
    {
        Sanctum::actingAs($this->groupCreator);

        $response = $this->postJson("/api/groups/{$this->testGroup->id}/invitations", [
            'type' => 'link',
            'expires_in' => '1w'
        ]);

        $response->assertCreated()
                 ->assertJsonStructure([
                     'message',
                     'invitation' => [
                         'id',
                         'token',
                         'type',
                         'type_name',
                         'status',
                         'status_name',
                         'expires_at',
                         'invitation_url',
                         'created_at'
                     ]
                 ])
                 ->assertJson([
                     'invitation' => [
                         'type' => 'link',
                         'status' => 'pending'
                     ]
                 ]);

        // Verify invitation was created in database
        $this->assertDatabaseHas('group_invitations', [
            'group_id' => $this->testGroup->id,
            'creator_id' => $this->groupCreator->id,
            'type' => 'link',
            'status' => 'pending'
        ]);
    }

    /** @test */
    public function group_creator_can_create_sms_invitation()
    {
        Sanctum::actingAs($this->groupCreator);

        $response = $this->postJson("/api/groups/{$this->testGroup->id}/invitations", [
            'type' => 'sms',
            'recipient_phone' => '84987654321',
            'expires_in' => '1w'
        ]);

        $response->assertCreated()
                 ->assertJsonStructure([
                     'message',
                     'invitation' => [
                         'id',
                         'token',
                         'type',
                         'recipient_phone',
                         'status'
                     ],
                     'sms_status'
                 ])
                 ->assertJson([
                     'invitation' => [
                         'type' => 'sms',
                         'recipient_phone' => '84987654321',
                         'status' => 'pending'
                     ]
                 ]);

        // Verify invitation was created in database
        $this->assertDatabaseHas('group_invitations', [
            'group_id' => $this->testGroup->id,
            'creator_id' => $this->groupCreator->id,
            'type' => 'sms',
            'recipient_phone' => '84987654321',
            'status' => 'pending'
        ]);
    }

    /** @test */
    public function group_creator_can_list_invitations()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create a few invitations
        GroupInvitation::create([
            'group_id' => $this->testGroup->id,
            'creator_id' => $this->groupCreator->id,
            'token' => 'test-token-1',
            'type' => 'link',
            'status' => 'pending',
            'metadata' => ['click_count' => 5]
        ]);

        GroupInvitation::create([
            'group_id' => $this->testGroup->id,
            'creator_id' => $this->groupCreator->id,
            'token' => 'test-token-2',
            'type' => 'sms',
            'status' => 'used',
            'recipient_phone' => '84987654321',
            'used_by' => $this->regularUser->id,
            'used_at' => now(),
            'metadata' => ['click_count' => 3]
        ]);

        $response = $this->getJson("/api/groups/{$this->testGroup->id}/invitations");

        $response->assertOk()
                 ->assertJsonStructure([
                     'data' => [
                         '*' => [
                             'id',
                             'token',
                             'type',
                             'status',
                             'created_at'
                         ]
                     ]
                 ]);

        $invitations = $response->json('data');
        $this->assertCount(2, $invitations);
        $this->assertEquals('pending', $invitations[0]['status']);
        $this->assertEquals('used', $invitations[1]['status']);
    }

    /** @test */
    public function regular_user_cannot_create_invitations()
    {
        Sanctum::actingAs($this->regularUser);

        $response = $this->postJson("/api/groups/{$this->testGroup->id}/invitations", [
            'type' => 'link'
        ]);

        $response->assertStatus(403)
                 ->assertJson([
                     'message' => 'Bạn không có quyền tạo lời mời cho nhóm này'
                 ]);
    }

    /** @test */
    public function invitation_analytics_endpoint_works()
    {
        Sanctum::actingAs($this->groupCreator);

        $response = $this->getJson("/api/groups/{$this->testGroup->id}/analytics");

        $response->assertOk()
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'overview' => [
                             'total_invitations',
                             'pending_invitations',
                             'used_invitations',
                             'expired_invitations',
                             'revoked_invitations',
                             'overall_click_rate',
                             'overall_conversion_rate'
                         ],
                         'events',
                         'rates',
                         'sources',
                         'daily_stats'
                     ]
                 ]);

        // Should return zero data for new group
        $overview = $response->json('data.overview');
        $this->assertEquals(0, $overview['total_invitations']);
        $this->assertEquals(0.0, $overview['overall_click_rate']);
        $this->assertEquals(0.0, $overview['overall_conversion_rate']);
    }

    /** @test */
    public function invitation_comparison_analytics_works()
    {
        Sanctum::actingAs($this->groupCreator);

        $response = $this->getJson("/api/groups/{$this->testGroup->id}/analytics/comparison");

        $response->assertOk()
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'link' => [
                             'count',
                             'click_rate',
                             'conversion_rate',
                             'avg_time_to_use'
                         ],
                         'sms' => [
                             'count',
                             'click_rate',
                             'conversion_rate',
                             'avg_time_to_use'
                         ],
                         'recommendation'
                     ]
                 ]);

        $data = $response->json('data');
        $this->assertEquals(0, $data['link']['count']);
        $this->assertEquals(0, $data['sms']['count']);
        $this->assertIsString($data['recommendation']);
    }

    /** @test */
    public function invitation_growth_analytics_works()
    {
        Sanctum::actingAs($this->groupCreator);

        $response = $this->getJson("/api/groups/{$this->testGroup->id}/analytics/growth?period=7");

        $response->assertOk()
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'period',
                         'total_members',
                         'growth_data',
                         'summary' => [
                             'total_growth',
                             'average_daily_growth',
                             'peak_growth_day'
                         ]
                     ]
                 ]);

        $data = $response->json('data');
        $this->assertEquals(7, $data['period']);
        $this->assertIsArray($data['growth_data']);
    }

    /** @test */
    public function invitation_model_vietnamese_attributes_work()
    {
        $invitation = GroupInvitation::create([
            'group_id' => $this->testGroup->id,
            'creator_id' => $this->groupCreator->id,
            'token' => 'test-token',
            'type' => 'link',
            'status' => 'pending',
        ]);

        $this->assertEquals('Đang chờ', $invitation->status_name);
        $this->assertEquals('Liên kết', $invitation->type_name);
        $this->assertTrue($invitation->isValid());
        $this->assertFalse($invitation->isExpired());
    }

    /** @test */
    public function invitation_expiry_logic_works()
    {
        // Create expired invitation
        $expiredInvitation = GroupInvitation::create([
            'group_id' => $this->testGroup->id,
            'creator_id' => $this->groupCreator->id,
            'token' => 'expired-token',
            'type' => 'link',
            'status' => 'pending',
            'expires_at' => Carbon::yesterday()
        ]);

        // Create valid invitation
        $validInvitation = GroupInvitation::create([
            'group_id' => $this->testGroup->id,
            'creator_id' => $this->groupCreator->id,
            'token' => 'valid-token',
            'type' => 'link',
            'status' => 'pending',
            'expires_at' => Carbon::tomorrow()
        ]);

        $this->assertFalse($expiredInvitation->isValid());
        $this->assertTrue($expiredInvitation->isExpired());
        
        $this->assertTrue($validInvitation->isValid());
        $this->assertFalse($validInvitation->isExpired());
    }

    /** @test */
    public function invitation_can_be_marked_as_used()
    {
        $invitation = GroupInvitation::create([
            'group_id' => $this->testGroup->id,
            'creator_id' => $this->groupCreator->id,
            'token' => 'test-token',
            'type' => 'link',
            'status' => 'pending',
        ]);

        $invitation->markAsUsed($this->regularUser->id);

        $this->assertEquals('used', $invitation->status);
        $this->assertEquals($this->regularUser->id, $invitation->used_by);
        $this->assertNotNull($invitation->used_at);
    }

    /** @test */
    public function invitation_can_be_revoked()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create invitation
        $response = $this->postJson("/api/groups/{$this->testGroup->id}/invitations", [
            'type' => 'link'
        ]);

        $token = $response->json('invitation.token');

        // Revoke invitation
        $response = $this->deleteJson("/api/invitations/{$token}");

        $response->assertOk();

        // Verify in database
        $this->assertDatabaseHas('group_invitations', [
            'token' => $token,
            'status' => 'revoked'
        ]);
    }

    /** @test */
    public function vietnamese_localization_is_consistent_across_system()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create invitation
        $response = $this->postJson("/api/groups/{$this->testGroup->id}/invitations", [
            'type' => 'sms',
            'recipient_phone' => '0987654321'
        ]);

        $invitation = $response->json('invitation');
        $this->assertEquals('Tin nhắn', $invitation['type_name']);
        $this->assertEquals('Đang chờ', $invitation['status_name']);

        // Check analytics have Vietnamese content
        $response = $this->getJson("/api/groups/{$this->testGroup->id}/analytics");
        
        $events = $response->json('data.events');
        if (count($events) > 0) {
            $this->assertStringContainsString('Lời mời', $events[0]['event_name']);
        }
    }
}