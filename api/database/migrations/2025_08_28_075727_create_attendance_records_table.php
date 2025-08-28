<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('attendance_records', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('attendance_session_id')->constrained('attendance_sessions')->onDelete('cascade');
            $table->enum('status', [
                'co_mat', // Present
                'vang_mat', // Absent
                'tre', // Late
                'som' // Early leave
            ])->default('co_mat');
            $table->timestamp('checked_in_at')->nullable();
            $table->timestamp('checked_out_at')->nullable();
            $table->text('notes')->nullable(); // Ghi chú điểm danh
            $table->enum('check_in_method', [
                'qr_code', // QR code
                'manual', // Thủ công
                'gps' // GPS location
            ])->default('qr_code');
            $table->decimal('check_in_latitude', 10, 8)->nullable();
            $table->decimal('check_in_longitude', 11, 8)->nullable();
            $table->timestamps();

            // Ensure unique attendance per user per session
            $table->unique(['user_id', 'attendance_session_id']);

            // Indexes for performance
            $table->index(['user_id']);
            $table->index(['attendance_session_id']);
            $table->index(['status']);
            $table->index(['checked_in_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendance_records');
    }
};
