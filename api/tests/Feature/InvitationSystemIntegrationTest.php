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

class InvitationSystemIntegrationTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    protected User $groupCreator;
    protected User $regularUser;
    protected User $outsider;
    protected Group $publicGroup;
    protected Group $privateGroup;

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

        $this->outsider = User::create([
            'name' => 'Outsider',
            'phone' => '0901234569',
            'email' => 'outsider@test.com',
            'password' => bcrypt('password'),
            'email_verified_at' => now()
        ]);

        // Create test groups
        $this->publicGroup = Group::create([
            'name' => 'Public Test Group',
            'vietnamese_name' => 'Nhóm Test Công Khai',
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

        $this->privateGroup = Group::create([
            'name' => 'Private Test Group',
            'vietnamese_name' => 'Nhóm Test Riêng Tư',
            'creator_id' => $this->groupCreator->id,
            'sport_type' => 'tennis',
            'privacy' => 'rieng_tu',
            'location' => 'Private Location',
            'city' => 'Hồ Chí Minh',
            'district' => 'Quận 1',
            'min_players' => 4,
            'current_members' => 1,
            'monthly_fee' => 200000,
            'status' => 'hoat_dong',
            'auto_approve_members' => false,
            'notification_hours_before' => 48
        ]);

        // Add creator as admin member to both groups
        $this->publicGroup->memberships()->attach($this->groupCreator->id, [
            'role' => 'admin',
            'status' => 'hoat_dong',
            'joined_at' => now()
        ]);

        $this->privateGroup->memberships()->attach($this->groupCreator->id, [
            'role' => 'admin', 
            'status' => 'hoat_dong',
            'joined_at' => now()
        ]);
    }

    /** @test */
    public function complete_invitation_workflow_with_link_invitation()
    {
        Sanctum::actingAs($this->groupCreator);

        // Step 1: Creator creates a link invitation
        $response = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations", [
            'type' => 'link',
            'expires_in' => '1w'
        ]);

        $response->assertCreated();
        $invitationData = $response->json('invitation');
        $invitationToken = $invitationData['token'];

        $this->assertNotEmpty($invitationToken);
        $this->assertEquals('link', $invitationData['type']);
        $this->assertEquals('pending', $invitationData['status']);

        // Step 2: Outsider validates the invitation (public endpoint)
        $response = $this->getJson("/api/invitations/{$invitationToken}/validate");
        
        $response->assertOk();
        $this->assertTrue($response->json('data.is_valid'));
        $this->assertEquals('pending', $response->json('data.status'));

        // Step 3: Outsider gets group preview (public endpoint)
        $response = $this->getJson("/api/invitations/{$invitationToken}/preview");
        
        $response->assertOk();
        $previewData = $response->json('data');
        $this->assertEquals($this->publicGroup->name, $previewData['group']['name']);
        $this->assertEquals($this->publicGroup->sport_type, $previewData['group']['sport_type']);

        // Step 4: Outsider creates join request using invitation
        Sanctum::actingAs($this->outsider);
        
        $response = $this->postJson("/api/join-requests", [
            'group_id' => $this->publicGroup->id,
            'invitation_token' => $invitationToken,
            'message' => 'I would like to join this group through invitation'
        ]);

        $response->assertCreated();
        $joinRequestData = $response->json('data');
        $this->assertEquals('pending', $joinRequestData['status']);
        $this->assertEquals('invitation', $joinRequestData['source']);

        // Step 5: Creator views join requests
        Sanctum::actingAs($this->groupCreator);
        
        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/join-requests");
        
        $response->assertOk();
        $joinRequests = $response->json('data');
        $this->assertCount(1, $joinRequests);
        $this->assertEquals($this->outsider->id, $joinRequests[0]['user_id']);

        // Step 6: Creator approves join request
        $joinRequestId = $joinRequestData['id'];
        
        $response = $this->postJson("/api/groups/{$this->publicGroup->id}/join-requests/{$joinRequestId}/approve", [
            'admin_message' => 'Welcome to the group!'
        ]);

        $response->assertOk();

        // Step 7: Verify invitation is marked as used
        $invitation = GroupInvitation::where('token', $invitationToken)->first();
        $this->assertEquals('used', $invitation->status);
        $this->assertEquals($this->outsider->id, $invitation->used_by);
        $this->assertNotNull($invitation->used_at);

        // Step 8: Verify join request is approved
        $joinRequest = GroupJoinRequest::find($joinRequestId);
        $this->assertEquals('approved', $joinRequest->status);
        $this->assertEquals($this->groupCreator->id, $joinRequest->processed_by);
        $this->assertNotNull($joinRequest->processed_at);
    }

    /** @test */
    public function complete_sms_invitation_workflow()
    {
        Sanctum::actingAs($this->groupCreator);

        // Step 1: Creator creates SMS invitation
        $response = $this->postJson("/api/groups/{$this->privateGroup->id}/invitations", [
            'type' => 'sms',
            'recipient_phone' => '0987654321',
            'expires_in' => '1w'
        ]);

        $response->assertCreated();
        $invitationData = $response->json('invitation');
        $invitationToken = $invitationData['token'];

        $this->assertEquals('sms', $invitationData['type']);
        $this->assertEquals('0987654321', $invitationData['recipient_phone']);

        // Step 2: Recipient uses invitation token to join
        Sanctum::actingAs($this->regularUser);
        
        $response = $this->postJson("/api/join-requests", [
            'group_id' => $this->privateGroup->id,
            'invitation_token' => $invitationToken,
            'message' => 'Joining via SMS invitation'
        ]);

        $response->assertCreated();

        // Step 3: Since private group has auto_approve_members = false, request should be pending
        $joinRequestData = $response->json('data');
        $this->assertEquals('pending', $joinRequestData['status']);

        // Step 4: Creator approves the request
        Sanctum::actingAs($this->groupCreator);
        
        $response = $this->postJson("/api/groups/{$this->privateGroup->id}/join-requests/{$joinRequestData['id']}/approve");

        $response->assertOk();

        // Step 5: Verify invitation is used
        $invitation = GroupInvitation::where('token', $invitationToken)->first();
        $this->assertEquals('used', $invitation->status);
        $this->assertEquals($this->regularUser->id, $invitation->used_by);
    }

    /** @test */
    public function invitation_expiry_prevents_usage()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create invitation that expires immediately
        $invitation = GroupInvitation::create([
            'group_id' => $this->publicGroup->id,
            'creator_id' => $this->groupCreator->id,
            'token' => 'expired-test-token',
            'type' => 'link',
            'status' => 'pending',
            'expires_at' => Carbon::now()->subDay(), // Expired yesterday
            'metadata' => ['click_count' => 0]
        ]);

        // Try to validate expired invitation
        $response = $this->getJson("/api/invitations/expired-test-token/validate");
        
        $response->assertOk();
        $this->assertFalse($response->json('data.is_valid'));
        $this->assertEquals('expired', $response->json('data.reason'));

        // Try to use expired invitation for join request
        Sanctum::actingAs($this->outsider);
        
        $response = $this->postJson("/api/join-requests", [
            'group_id' => $this->publicGroup->id,
            'invitation_token' => 'expired-test-token'
        ]);

        $response->assertStatus(422);
        $this->assertStringContainsString('hết hạn', $response->json('message'));
    }

    /** @test */
    public function revoked_invitation_cannot_be_used()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create and immediately revoke invitation
        $response = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations", [
            'type' => 'link'
        ]);

        $invitationToken = $response->json('data.token');

        // Revoke the invitation
        $response = $this->deleteJson("/api/invitations/{$invitationToken}");
        $response->assertOk();

        // Try to validate revoked invitation
        $response = $this->getJson("/api/invitations/{$invitationToken}/validate");
        
        $response->assertOk();
        $this->assertFalse($response->json('data.is_valid'));
        $this->assertEquals('revoked', $response->json('data.reason'));

        // Try to use revoked invitation
        Sanctum::actingAs($this->outsider);
        
        $response = $this->postJson("/api/join-requests", [
            'group_id' => $this->publicGroup->id,
            'invitation_token' => $invitationToken
        ]);

        $response->assertStatus(422);
    }

    /** @test */
    public function invitation_analytics_track_usage_correctly()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create multiple invitations with different outcomes
        $linkInvitation = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations", [
            'type' => 'link'
        ]);
        $linkToken = $linkInvitation->json('data.token');

        $smsInvitation = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations", [
            'type' => 'sms',
            'recipient_phone' => '0999888777'
        ]);
        $smsToken = $smsInvitation->json('data.token');

        // Use the link invitation successfully
        Sanctum::actingAs($this->outsider);
        
        $joinRequest = $this->postJson("/api/join-requests", [
            'group_id' => $this->publicGroup->id,
            'invitation_token' => $linkToken
        ]);

        Sanctum::actingAs($this->groupCreator);
        $this->postJson("/api/groups/{$this->publicGroup->id}/join-requests/{$joinRequest->json('data.id')}/approve");

        // Leave SMS invitation unused (pending)

        // Check group analytics
        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/analytics");
        
        $response->assertOk();
        $analyticsData = $response->json('data');
        
        $this->assertEquals(2, $analyticsData['overview']['total_invitations']);
        $this->assertEquals(1, $analyticsData['overview']['used_invitations']);
        $this->assertEquals(1, $analyticsData['overview']['pending_invitations']);
        $this->assertEquals(50.0, $analyticsData['overview']['overall_conversion_rate']); // 1 used out of 2 = 50%

        // Check invitation comparison
        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/analytics/comparison");
        
        $response->assertOk();
        $comparisonData = $response->json('data');
        
        $this->assertEquals(1, $comparisonData['link']['count']);
        $this->assertEquals(1, $comparisonData['sms']['count']);
        $this->assertEquals(100.0, $comparisonData['link']['conversion_rate']); // Link was used
        $this->assertEquals(0.0, $comparisonData['sms']['conversion_rate']); // SMS not used
        $this->assertStringContainsString('link', strtolower($comparisonData['recommendation']));
    }

    /** @test */
    public function permission_controls_work_correctly()
    {
        // Regular member cannot create invitations
        Sanctum::actingAs($this->regularUser);
        
        $response = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations", [
            'type' => 'link'
        ]);

        $response->assertStatus(403);

        // Outsider cannot view group invitations
        Sanctum::actingAs($this->outsider);
        
        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/invitations");
        $response->assertStatus(403);

        // Outsider cannot view analytics
        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/analytics");
        $response->assertStatus(403);

        // Only creator can manage invitations
        Sanctum::actingAs($this->groupCreator);
        
        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/invitations");
        $response->assertOk();

        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/analytics");
        $response->assertOk();
    }

    /** @test */
    public function rate_limiting_prevents_spam()
    {
        Sanctum::actingAs($this->groupCreator);

        // Try to create many invitations rapidly (should hit rate limit)
        $successCount = 0;
        $rateLimitedCount = 0;

        for ($i = 0; $i < 15; $i++) { // Trying 15 invitations (limit is usually 10/hour)
            $response = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations", [
                'type' => 'link'
            ]);

            if ($response->status() === 200) {
                $successCount++;
            } elseif ($response->status() === 429) { // Rate limited
                $rateLimitedCount++;
            }
        }

        $this->assertGreaterThan(0, $successCount);
        $this->assertGreaterThan(0, $rateLimitedCount); // Should hit rate limit
    }

    /** @test */
    public function invitation_resend_functionality_works()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create SMS invitation
        $response = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations", [
            'type' => 'sms',
            'recipient_phone' => '0911222333'
        ]);

        $invitationId = $response->json('data.id');

        // Resend SMS invitation
        $response = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations/{$invitationId}/resend-sms");
        
        $response->assertOk();
        $this->assertStringContainsString('SMS', $response->json('message'));
    }

    /** @test */
    public function join_request_rejection_workflow()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create invitation
        $response = $this->postJson("/api/groups/{$this->privateGroup->id}/invitations", [
            'type' => 'link'
        ]);
        $invitationToken = $response->json('data.token');

        // User creates join request
        Sanctum::actingAs($this->regularUser);
        
        $response = $this->postJson("/api/join-requests", [
            'group_id' => $this->privateGroup->id,
            'invitation_token' => $invitationToken,
            'message' => 'Please let me join'
        ]);

        $joinRequestId = $response->json('data.id');

        // Creator rejects the request
        Sanctum::actingAs($this->groupCreator);
        
        $response = $this->postJson("/api/groups/{$this->privateGroup->id}/join-requests/{$joinRequestId}/reject", [
            'rejection_reason' => 'Group is currently full'
        ]);

        $response->assertOk();

        // Verify join request is rejected but invitation remains pending
        $joinRequest = GroupJoinRequest::find($joinRequestId);
        $this->assertEquals('rejected', $joinRequest->status);
        $this->assertEquals('Group is currently full', $joinRequest->rejection_reason);

        $invitation = GroupInvitation::where('token', $invitationToken)->first();
        $this->assertEquals('pending', $invitation->status); // Invitation can still be used by others
    }

    /** @test */
    public function vietnamese_localization_is_consistent()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create invitation
        $response = $this->postJson("/api/groups/{$this->publicGroup->id}/invitations", [
            'type' => 'link'
        ]);

        $invitationData = $response->json('data');
        $this->assertEquals('Đang chờ', $invitationData['status_name']);
        $this->assertEquals('Liên kết', $invitationData['type_name']);

        // Check analytics have Vietnamese event names
        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/analytics");
        
        $analyticsData = $response->json('data');
        $events = $analyticsData['events'];
        
        $this->assertGreaterThan(0, count($events));
        $this->assertStringContainsString('Lời mời', $events[0]['event_name']);
    }

    /** @test */
    public function invitation_metadata_tracks_clicks()
    {
        Sanctum::actingAs($this->groupCreator);

        // Create invitation with initial click count
        $invitation = GroupInvitation::create([
            'group_id' => $this->publicGroup->id,
            'creator_id' => $this->groupCreator->id,
            'token' => 'click-test-token',
            'type' => 'link',
            'status' => 'pending',
            'metadata' => ['click_count' => 5]
        ]);

        // Check individual invitation analytics
        $response = $this->getJson("/api/groups/{$this->publicGroup->id}/invitations/{$invitation->id}/analytics");
        
        $response->assertOk();
        $analyticsData = $response->json('data');
        
        $this->assertEquals(5, $analyticsData['performance']['total_clicks']);
        $this->assertEquals(0.0, $analyticsData['performance']['conversion_rate']); // Not used yet
    }
}