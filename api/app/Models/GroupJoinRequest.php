<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class GroupJoinRequest extends Model
{
    protected $fillable = [
        'group_id',
        'user_id',
        'invitation_id',
        'status',
        'message',
        'rejection_reason',
        'source',
        'processed_by',
        'processed_at',
        'metadata',
    ];

    protected $casts = [
        'processed_at' => 'datetime',
        'metadata' => 'array',
    ];

    /**
     * Get the group that owns the join request
     */
    public function group(): BelongsTo
    {
        return $this->belongsTo(Group::class);
    }

    /**
     * Get the user who made the join request
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the invitation that led to this join request (if any)
     */
    public function invitation(): BelongsTo
    {
        return $this->belongsTo(GroupInvitation::class, 'invitation_id');
    }

    /**
     * Get the user who processed the request (approved/rejected)
     */
    public function processedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'processed_by');
    }

    /**
     * Approve the join request
     */
    public function approve(User $approver, string $role = 'member'): bool
    {
        if ($this->status !== 'pending') {
            return false;
        }

        try {
            \DB::beginTransaction();

            // Add user to group
            $this->group->memberships()->attach($this->user_id, [
                'role' => $role,
                'status' => 'hoat_dong',
                'joined_at' => now(),
                'join_reason' => 'Được duyệt từ yêu cầu tham gia',
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Increment member count
            $this->group->increment('current_members');

            // Mark request as approved
            $this->update([
                'status' => 'approved',
                'processed_by' => $approver->id,
                'processed_at' => now(),
            ]);

            // Mark invitation as used if it exists
            if ($this->invitation) {
                $this->invitation->markAsUsed($this->user_id);
                InvitationAnalytics::track($this->invitation_id, 'joined');
            }

            \DB::commit();
            return true;
        } catch (\Exception $e) {
            \DB::rollback();
            return false;
        }
    }

    /**
     * Reject the join request
     */
    public function reject(User $rejector, ?string $reason = null): bool
    {
        if ($this->status !== 'pending') {
            return false;
        }

        $this->update([
            'status' => 'rejected',
            'rejection_reason' => $reason,
            'processed_by' => $rejector->id,
            'processed_at' => now(),
        ]);

        // Track analytics if from invitation
        if ($this->invitation) {
            InvitationAnalytics::track($this->invitation_id, 'rejected');
        }

        return true;
    }

    /**
     * Check if request can be processed
     */
    public function canBeProcessed(): bool
    {
        return $this->status === 'pending';
    }

    /**
     * Scope to get pending requests
     */
    public function scopePending($query)
    {
        return $query->where('status', 'pending');
    }

    /**
     * Scope to get approved requests
     */
    public function scopeApproved($query)
    {
        return $query->where('status', 'approved');
    }

    /**
     * Scope to get rejected requests
     */
    public function scopeRejected($query)
    {
        return $query->where('status', 'rejected');
    }

    /**
     * Vietnamese status name
     */
    public function getStatusNameAttribute(): string
    {
        return match($this->status) {
            'pending' => 'Đang chờ duyệt',
            'approved' => 'Đã duyệt',
            'rejected' => 'Đã từ chối',
            default => $this->status,
        };
    }

    /**
     * Vietnamese source name
     */
    public function getSourceNameAttribute(): string
    {
        return match($this->source) {
            'direct' => 'Yêu cầu trực tiếp',
            'invitation' => 'Từ lời mời',
            'search' => 'Từ tìm kiếm',
            default => $this->source,
        };
    }
}
