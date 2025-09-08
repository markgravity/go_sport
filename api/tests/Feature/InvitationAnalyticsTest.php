<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\User;
use App\Models\GroupInvitation;
use App\Models\GroupJoinRequest;
use App\Models\InvitationAnalytics;
use App\Enums\GroupRole;
use Carbon\Carbon;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class InvitationAnalyticsTest extends TestCase
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
    public function admin_can_view_group_analytics()
    {
        Sanctum::actingAs($this->admin);

        // Create some test data
        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'created_at' => now()->subDays(5)
        ]);

        InvitationAnalytics::create([
            'invitation_id' => $invitation->id,
            'event_type' => 'clicked',
            'created_at' => now()->subDays(3)
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'period' => [
                             'start',
                             'end'
                         ],
                         'summary' => [
                             'total_invitations',
                             'total_clicks',
                             'total_joins',
                             'total_rejected',
                             'click_rate',
                             'conversion_rate'
                         ],
                         'join_request_stats',
                         'daily_activity',
                         'top_performers',
                         'all_invitations'
                     ]
                 ]);
    }

    /** @test */
    public function moderator_can_view_group_analytics()
    {
        Sanctum::actingAs($this->moderator);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $response->assertStatus(200);
    }

    /** @test */
    public function regular_member_cannot_view_group_analytics()
    {
        Sanctum::actingAs($this->member);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $response->assertStatus(403)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn không có quyền xem phân tích nhóm'
                 ]);
    }

    /** @test */
    public function outsider_cannot_view_group_analytics()
    {
        Sanctum::actingAs($this->outsider);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $response->assertStatus(403);
    }

    /** @test */
    public function can_filter_analytics_by_date_range()
    {
        Sanctum::actingAs($this->admin);

        $startDate = now()->subDays(7)->format('Y-m-d');
        $endDate = now()->format('Y-m-d');

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics?start_date={$startDate}&end_date={$endDate}");

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'data' => [
                         'period' => [
                             'start' => $startDate,
                             'end' => $endDate
                         ]
                     ]
                 ]);
    }

    /** @test */
    public function can_view_member_growth_analytics()
    {
        Sanctum::actingAs($this->admin);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics/growth");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'period',
                         'summary' => [
                             'new_members',
                             'growth_rate',
                             'current_total',
                             'capacity_usage'
                         ],
                         'daily_growth',
                         'member_sources',
                         'invitation_effectiveness'
                     ]
                 ]);
    }

    /** @test */
    public function can_view_specific_invitation_analytics()
    {
        Sanctum::actingAs($this->admin);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        // Add some analytics events
        InvitationAnalytics::create([
            'invitation_id' => $invitation->id,
            'event_type' => 'clicked'
        ]);

        InvitationAnalytics::create([
            'invitation_id' => $invitation->id,
            'event_type' => 'joined'
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/invitations/{$invitation->id}/analytics");

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'success',
                     'data' => [
                         'invitation',
                         'summary' => [
                             'sent',
                             'clicked',
                             'registered',
                             'joined',
                             'rejected',
                             'click_rate',
                             'conversion_rate'
                         ],
                         'recent_events',
                         'join_requests',
                         'performance'
                     ]
                 ]);
    }

    /** @test */
    public function regular_member_cannot_view_invitation_analytics()
    {
        Sanctum::actingAs($this->member);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/invitations/{$invitation->id}/analytics");

        $response->assertStatus(403)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Bạn không có quyền xem phân tích lời mời'
                 ]);
    }

    /** @test */
    public function can_track_invitation_events()
    {
        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        $response = $this->postJson('/api/analytics/track-event', [
            'invitation_token' => $invitation->token,
            'event_type' => 'clicked',
            'metadata' => [
                'referrer' => 'https://example.com',
                'device' => 'mobile'
            ]
        ]);

        $response->assertStatus(200)
                 ->assertJson([
                     'success' => true,
                     'message' => 'Sự kiện đã được ghi nhận'
                 ]);

        $this->assertDatabaseHas('invitation_analytics', [
            'invitation_id' => $invitation->id,
            'event_type' => 'clicked'
        ]);
    }

    /** @test */
    public function cannot_track_event_with_invalid_token()
    {
        $response = $this->postJson('/api/analytics/track-event', [
            'invitation_token' => 'invalid-token',
            'event_type' => 'clicked'
        ]);

        $response->assertStatus(404)
                 ->assertJson([
                     'success' => false,
                     'message' => 'Lời mời không tồn tại'
                 ]);
    }

    /** @test */
    public function event_tracking_validates_event_type()
    {
        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        $response = $this->postJson('/api/analytics/track-event', [
            'invitation_token' => $invitation->token,
            'event_type' => 'invalid_event'
        ]);

        $response->assertStatus(422)
                 ->assertJsonValidationErrors(['event_type']);
    }

    /** @test */
    public function analytics_summary_calculates_rates_correctly()
    {
        Sanctum::actingAs($this->admin);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        // Create analytics events
        InvitationAnalytics::create([
            'invitation_id' => $invitation->id,
            'event_type' => 'sent'
        ]);

        InvitationAnalytics::create([
            'invitation_id' => $invitation->id,
            'event_type' => 'clicked'
        ]);

        InvitationAnalytics::create([
            'invitation_id' => $invitation->id,
            'event_type' => 'joined'
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/invitations/{$invitation->id}/analytics");

        $summary = $response->json('data.summary');
        
        $this->assertEquals(1, $summary['sent']);
        $this->assertEquals(1, $summary['clicked']);
        $this->assertEquals(1, $summary['joined']);
        $this->assertEquals(100.0, $summary['click_rate']);
        $this->assertEquals(100.0, $summary['conversion_rate']);
    }

    /** @test */
    public function analytics_handles_zero_division()
    {
        Sanctum::actingAs($this->admin);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id
        ]);

        // No analytics events created

        $response = $this->getJson("/api/groups/{$this->group->id}/invitations/{$invitation->id}/analytics");

        $summary = $response->json('data.summary');
        
        $this->assertEquals(0, $summary['sent']);
        $this->assertEquals(0, $summary['clicked']);
        $this->assertEquals(0, $summary['joined']);
        $this->assertEquals(0, $summary['click_rate']);
        $this->assertEquals(0, $summary['conversion_rate']);
    }

    /** @test */
    public function group_analytics_aggregates_multiple_invitations()
    {
        Sanctum::actingAs($this->admin);

        // Create multiple invitations with analytics
        $invitation1 = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'created_at' => now()->subDays(5)
        ]);

        $invitation2 = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->moderator->id,
            'created_at' => now()->subDays(3)
        ]);

        // Add analytics for both
        InvitationAnalytics::create([
            'invitation_id' => $invitation1->id,
            'event_type' => 'clicked',
            'created_at' => now()->subDays(4)
        ]);

        InvitationAnalytics::create([
            'invitation_id' => $invitation2->id,
            'event_type' => 'clicked',
            'created_at' => now()->subDays(2)
        ]);

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics");

        $summary = $response->json('data.summary');
        
        $this->assertEquals(2, $summary['total_invitations']);
        $this->assertEquals(2, $summary['total_clicks']);

        $allInvitations = $response->json('data.all_invitations');
        $this->assertCount(2, $allInvitations);
    }

    /** @test */
    public function analytics_respects_date_range_filtering()
    {
        Sanctum::actingAs($this->admin);

        $invitation = GroupInvitation::factory()->create([
            'group_id' => $this->group->id,
            'created_by' => $this->admin->id,
            'created_at' => now()->subDays(10) // Outside our filter range
        ]);

        InvitationAnalytics::create([
            'invitation_id' => $invitation->id,
            'event_type' => 'clicked',
            'created_at' => now()->subDays(8)
        ]);

        // Filter to last 5 days only
        $startDate = now()->subDays(5)->format('Y-m-d');
        $endDate = now()->format('Y-m-d');

        $response = $this->getJson("/api/groups/{$this->group->id}/analytics?start_date={$startDate}&end_date={$endDate}");

        $summary = $response->json('data.summary');
        
        // Should not include the invitation created 10 days ago
        $this->assertEquals(0, $summary['total_invitations']);
        $this->assertEquals(0, $summary['total_clicks']);
    }
}