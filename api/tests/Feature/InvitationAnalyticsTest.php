<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\GroupInvitation;
use App\Models\GroupJoinRequest;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class InvitationAnalyticsTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    protected User $creator;
    protected User $member;
    protected User $outsider;
    protected Group $group;

    protected function setUp(): void
    {
        parent::setUp();

        // Create test users
        $this->creator = User::factory()->create([
            'name' => 'Group Creator',
            'phone' => '0901234567'
        ]);

        $this->member = User::factory()->create([
            'name' => 'Group Member',
            'phone' => '0901234568'
        ]);

        $this->outsider = User::factory()->create([
            'name' => 'Outsider',
            'phone' => '0901234569'
        ]);

        // Create test group
        $this->group = Group::create([
            'name' => 'Test Analytics Group',
            'vietnamese_name' => 'Nhóm Test Analytics',
            'creator_id' => $this->creator->id,
            'sport_type' => 'badminton',
            'privacy' => 'cong_khai',
            'location' => 'Test Location',
            'city' => 'Hà Nội',
            'district' => 'Ba Đình',
            'min_players' => 2,
            'current_members' => 1,
            'monthly_fee' => 0,
            'status' => 'hoat_dong',
            'auto_approve_members' => true,
            'notification_hours_before' => 24
        ]);

        // Add member to group (skip for now - focusing on analytics API)

        // Create test invitations with various statuses
        $this->createTestInvitations();
    }

    protected function createTestInvitations(): void
    {
        // Create pending link invitation (created yesterday)
        GroupInvitation::create([
            'group_id' => $this->group->id,
            'creator_id' => $this->creator->id,
            'token' => 'test-link-token-1',
            'type' => 'link',
            'status' => 'pending',
            'created_at' => Carbon::yesterday(),
            'expires_at' => Carbon::tomorrow(),
            'metadata' => [
                'click_count' => 15,
                'last_clicked_at' => Carbon::now()->subHours(2)->toISOString()
            ]
        ]);

        // Create used SMS invitation (created 3 days ago, used yesterday)
        GroupInvitation::create([
            'group_id' => $this->group->id,
            'creator_id' => $this->creator->id,
            'token' => 'test-sms-token-1',
            'type' => 'sms',
            'status' => 'used',
            'recipient_phone' => '0987654321',
            'used_by' => $this->member->id,
            'used_at' => Carbon::yesterday(),
            'created_at' => Carbon::now()->subDays(3),
            'metadata' => [
                'click_count' => 3,
                'sms_sent_at' => Carbon::now()->subDays(3)->toISOString(),
                'last_clicked_at' => Carbon::yesterday()->toISOString()
            ]
        ]);

        // Create expired invitation (created 5 days ago)
        GroupInvitation::create([
            'group_id' => $this->group->id,
            'creator_id' => $this->creator->id,
            'token' => 'test-link-token-2',
            'type' => 'link',
            'status' => 'expired',
            'expires_at' => Carbon::now()->subDays(2),
            'created_at' => Carbon::now()->subDays(5),
            'metadata' => [
                'click_count' => 8,
                'last_clicked_at' => Carbon::now()->subDays(3)->toISOString()
            ]
        ]);

        // Create revoked invitation (created 4 days ago, revoked 2 days ago)
        GroupInvitation::create([
            'group_id' => $this->group->id,
            'creator_id' => $this->creator->id,
            'token' => 'test-sms-token-2',
            'type' => 'sms',
            'status' => 'revoked',
            'recipient_phone' => '0912345678',
            'created_at' => Carbon::now()->subDays(4),
            'updated_at' => Carbon::now()->subDays(2),
            'metadata' => [
                'click_count' => 1,
                'sms_sent_at' => Carbon::now()->subDays(4)->toISOString(),
                'last_clicked_at' => Carbon::now()->subDays(4)->toISOString()
            ]
        ]);
    }

    /** @test */
    public function creator_can_access_group_analytics()
    {
        Sanctum::actingAs($this->creator);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

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
                         'rates' => [
                             'click_rate_by_type',
                             'conversion_rate_by_type'
                         ],
                         'sources',
                         'daily_stats'
                     ]
                 ])
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'overview' => [
                             'total_invitations' => 4,
                             'pending_invitations' => 1,
                             'used_invitations' => 1,
                             'expired_invitations' => 1,
                             'revoked_invitations' => 1
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function member_cannot_access_group_analytics()
    {
        Sanctum::actingAs($this->member);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $response->assertStatus(403)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn không có quyền xem thống kê nhóm này'
                 ]);
    }

    /** @test */
    public function outsider_cannot_access_group_analytics()
    {
        Sanctum::actingAs($this->outsider);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $response->assertStatus(403)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn không có quyền xem thống kê nhóm này'
                 ]);
    }

    /** @test */
    public function unauthenticated_user_cannot_access_analytics()
    {
        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $response->assertStatus(401);
    }

    /** @test */
    public function creator_can_access_member_growth_analytics()
    {
        Sanctum::actingAs($this->creator);

        // Test with default parameters
        $response = $this->getJson("/api/groups/{$this->group->id}/analytics/growth");

        $response->assertOk()
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'period',
                         'total_members',
                         'growth_data' => ['*'],
                         'summary' => [
                             'total_growth',
                             'average_daily_growth',
                             'peak_growth_day'
                         ]
                     ]
                 ]);

        // Test with custom parameters
        $response = $this->getJson("/api/groups/{$this->group->id}/analytics/growth?period=7&type=invitations");

        $response->assertOk()
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'period' => 7
                     ]
                 ]);
    }

    /** @test */
    public function creator_can_access_invitation_comparison()
    {
        Sanctum::actingAs($this->creator);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics/comparison");

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
                 ])
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'link' => [
                             'count' => 2  // pending + expired
                         ],
                         'sms' => [
                             'count' => 2  // used + revoked
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function creator_can_access_individual_invitation_analytics()
    {
        Sanctum::actingAs($this->creator);

        // Get a specific invitation
        $invitation = GroupInvitation::where('group_id', $this->group->id)
                                   ->where('status', 'used')
                                   ->first();

        $response = $this->getJson("/api/groups/{$this->group->id}/invitations/{$invitation->id}/analytics");

        $response->assertOk()
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'invitation' => [
                             'id',
                             'type',
                             'status',
                             'created_at',
                             'used_at'
                         ],
                         'performance' => [
                             'total_clicks',
                             'conversion_rate',
                             'time_to_use',
                             'click_timeline'
                         ],
                         'timeline'
                     ]
                 ])
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'invitation' => [
                             'id' => $invitation->id,
                             'type' => 'sms',
                             'status' => 'used'
                         ],
                         'performance' => [
                             'total_clicks' => 3,
                             'conversion_rate' => 100.0  // Used invitation = 100% conversion
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function analytics_handles_invalid_group_id()
    {
        Sanctum::actingAs($this->creator);

        $response = $this->getJson("/api/groups/99999/analytics");

        $response->assertStatus(404)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Nhóm không tồn tại'
                 ]);
    }

    /** @test */
    public function analytics_handles_invalid_invitation_id()
    {
        Sanctum::actingAs($this->creator);

        $response = $this->getJson("/api/groups/{$this->group->id}/invitations/99999/analytics");

        $response->assertStatus(404)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Lời mời không tồn tại hoặc không thuộc nhóm này'
                 ]);
    }

    /** @test */
    public function analytics_calculates_click_rates_correctly()
    {
        Sanctum::actingAs($this->creator);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $data = $response->json('data');

        // Calculate expected click rate: (15 + 3 + 8 + 1) total clicks / 4 invitations = 27/4 = 6.75
        $this->assertEquals(6.75, $data['overview']['overall_click_rate']);

        // Calculate expected conversion rate: 1 used / 4 total = 25%
        $this->assertEquals(25.0, $data['overview']['overall_conversion_rate']);
    }

    /** @test */
    public function growth_analytics_validates_parameters()
    {
        Sanctum::actingAs($this->creator);

        // Test invalid period
        $response = $this->getJson("/api/groups/{$this->group->id}/analytics/growth?period=abc");
        $response->assertStatus(422);

        // Test invalid type
        $response = $this->getJson("/api/groups/{$this->group->id}/analytics/growth?type=invalid");
        $response->assertStatus(422);

        // Test period too large
        $response = $this->getJson("/api/groups/{$this->group->id}/analytics/growth?period=1000");
        $response->assertStatus(422);
    }

    /** @test */
    public function analytics_includes_vietnamese_event_names()
    {
        Sanctum::actingAs($this->creator);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $data = $response->json('data');
        $events = collect($data['events']);

        // Check that events have Vietnamese names
        $this->assertTrue($events->contains(function ($event) {
            return str_contains($event['event_name'], 'Lời mời được tạo') ||
                   str_contains($event['event_name'], 'Lời mời được sử dụng') ||
                   str_contains($event['event_name'], 'Lời mời hết hạn') ||
                   str_contains($event['event_name'], 'Lời mời bị thu hồi');
        }));
    }

    /** @test */
    public function comparison_provides_recommendation()
    {
        Sanctum::actingAs($this->creator);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics/comparison");

        $data = $response->json('data');

        $this->assertArrayHasKey('recommendation', $data);
        $this->assertIsString($data['recommendation']);
        $this->assertNotEmpty($data['recommendation']);

        // Should recommend SMS since it has better conversion in our test data
        $this->assertStringContainsString('SMS', $data['recommendation']);
    }

    /** @test */
    public function analytics_handles_no_invitations_gracefully()
    {
        // Create a new group with no invitations
        $emptyGroup = Group::create([
            'name' => 'Empty Group',
            'vietnamese_name' => 'Nhóm Rỗng',
            'creator_id' => $this->creator->id,
            'sport_type' => 'badminton',
            'privacy' => 'cong_khai',
            'location' => 'Empty Location',
            'city' => 'Hà Nội',
            'district' => 'Ba Đình',
            'min_players' => 2,
            'current_members' => 1,
            'monthly_fee' => 0,
            'status' => 'hoat_dong',
            'auto_approve_members' => true,
            'notification_hours_before' => 24
        ]);

        Sanctum::actingAs($this->creator);

        $response = $this->getJson("/api/groups/{$emptyGroup->id}/analytics");

        $response->assertOk()
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'overview' => [
                             'total_invitations' => 0,
                             'pending_invitations' => 0,
                             'used_invitations' => 0,
                             'expired_invitations' => 0,
                             'revoked_invitations' => 0,
                             'overall_click_rate' => 0.0,
                             'overall_conversion_rate' => 0.0
                         ]
                     ]
                 ]);
    }
}