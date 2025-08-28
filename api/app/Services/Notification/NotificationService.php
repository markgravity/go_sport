<?php

namespace App\Services\Notification;

use App\Models\User;
use App\Models\Group;
use App\Models\Notification;
use Illuminate\Support\Facades\Log;

class NotificationService
{
    public function sendNotification(User $user, string $title, string $message, array $data = []): Notification
    {
        $notification = Notification::create([
            'user_id' => $user->id,
            'title' => $title,
            'message' => $message,
            'data' => json_encode($data),
            'type' => $data['type'] ?? 'general',
        ]);

        // Send push notification
        $this->sendPushNotification($user, $title, $message, $data);

        return $notification;
    }

    public function sendGroupNotification(Group $group, string $title, string $message, array $data = []): void
    {
        $members = $group->members;

        foreach ($members as $member) {
            $this->sendNotification($member, $title, $message, $data);
        }
    }

    public function sendAttendanceReminder(Group $group, \DateTime $sessionDate): void
    {
        $title = "Nhắc nhở tham gia: {$group->name}";
        $message = "Bạn có buổi tập vào {$sessionDate->format('d/m/Y H:i')}. Đừng quên tham gia!";

        $data = [
            'type' => 'attendance_reminder',
            'group_id' => $group->id,
            'session_date' => $sessionDate->format('Y-m-d H:i:s'),
        ];

        $this->sendGroupNotification($group, $title, $message, $data);
    }

    public function sendPaymentReminder(User $user, $paymentRequest): void
    {
        $title = "Nhắc nhở thanh toán: {$paymentRequest->title}";
        $message = "Bạn có khoản thanh toán {$paymentRequest->amount} VND đang chờ xử lý.";

        $data = [
            'type' => 'payment_reminder',
            'payment_request_id' => $paymentRequest->id,
            'amount' => $paymentRequest->amount,
        ];

        $this->sendNotification($user, $title, $message, $data);
    }

    public function sendWelcomeMessage(User $user, Group $group): void
    {
        $title = "Chào mừng đến với {$group->name}!";
        $message = "Bạn đã tham gia thành công nhóm thể thao. Hãy chuẩn bị cho các hoạt động sắp tới!";

        $data = [
            'type' => 'welcome',
            'group_id' => $group->id,
        ];

        $this->sendNotification($user, $title, $message, $data);
    }

    public function markAsRead(Notification $notification): void
    {
        $notification->update(['read_at' => now()]);
    }

    public function markAllAsRead(User $user): void
    {
        $user->notifications()->whereNull('read_at')->update(['read_at' => now()]);
    }

    public function getUserNotifications(User $user, bool $unreadOnly = false): \Illuminate\Database\Eloquent\Collection
    {
        $query = $user->notifications()->orderBy('created_at', 'desc');

        if ($unreadOnly) {
            $query->whereNull('read_at');
        }

        return $query->get();
    }

    private function sendPushNotification(User $user, string $title, string $message, array $data = []): void
    {
        if (!$user->fcm_token) {
            return;
        }

        try {
            // Firebase Cloud Messaging push notification
            // This would integrate with Firebase in production
            Log::info("Push notification sent to user {$user->id}: {$title} - {$message}");
        } catch (\Exception $e) {
            Log::error("Failed to send push notification to user {$user->id}: " . $e->getMessage());
        }
    }
}