<?php

namespace App\Services\Attendance;

use App\Models\Group;
use App\Models\User;
use App\Models\AttendanceSession;
use App\Models\AttendanceRecord;
use Carbon\Carbon;

class AttendanceService
{
    public function createAttendanceSession(Group $group, array $sessionData): AttendanceSession
    {
        return AttendanceSession::create([
            ...$sessionData,
            'group_id' => $group->id,
            'qr_code' => $this->generateQRCode(),
        ]);
    }

    public function checkIn(User $user, AttendanceSession $session): AttendanceRecord
    {
        return AttendanceRecord::create([
            'user_id' => $user->id,
            'attendance_session_id' => $session->id,
            'checked_in_at' => now(),
            'status' => 'present',
        ]);
    }

    public function checkOut(AttendanceRecord $record): AttendanceRecord
    {
        $record->update([
            'checked_out_at' => now(),
        ]);

        return $record;
    }

    public function markAbsent(User $user, AttendanceSession $session): AttendanceRecord
    {
        return AttendanceRecord::create([
            'user_id' => $user->id,
            'attendance_session_id' => $session->id,
            'status' => 'absent',
        ]);
    }

    public function getSessionAttendance(AttendanceSession $session): \Illuminate\Database\Eloquent\Collection
    {
        return $session->attendanceRecords()->with('user')->get();
    }

    public function getUserAttendanceHistory(User $user, int $groupId = null): \Illuminate\Database\Eloquent\Collection
    {
        $query = AttendanceRecord::where('user_id', $user->id)
            ->with(['attendanceSession.group']);

        if ($groupId) {
            $query->whereHas('attendanceSession', function($q) use ($groupId) {
                $q->where('group_id', $groupId);
            });
        }

        return $query->orderBy('created_at', 'desc')->get();
    }

    public function getGroupAttendanceStats(Group $group, Carbon $startDate = null, Carbon $endDate = null): array
    {
        $query = AttendanceSession::where('group_id', $group->id);

        if ($startDate) {
            $query->where('session_date', '>=', $startDate);
        }

        if ($endDate) {
            $query->where('session_date', '<=', $endDate);
        }

        $sessions = $query->with('attendanceRecords')->get();

        return [
            'total_sessions' => $sessions->count(),
            'total_attendees' => $sessions->sum(fn($session) => $session->attendanceRecords->where('status', 'present')->count()),
            'average_attendance' => $sessions->avg(fn($session) => $session->attendanceRecords->where('status', 'present')->count()),
        ];
    }

    private function generateQRCode(): string
    {
        return 'QR_' . uniqid() . '_' . time();
    }
}