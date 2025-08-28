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
        Schema::create('notifications', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->string('title');
            $table->text('message');
            $table->enum('type', [
                'thong_bao_chung', // General announcement
                'nhac_nho_diem_danh', // Attendance reminder
                'nhac_nho_thanh_toan', // Payment reminder
                'moi_tham_gia_nhom', // Group invitation
                'chao_mung', // Welcome
                'cap_nhat_nhom', // Group update
                'huy_buoi_tap', // Session cancellation
                'khac' // Other
            ])->default('thong_bao_chung');
            $table->json('data')->nullable(); // Additional data in Vietnamese
            $table->enum('priority', [
                'thap', // Low
                'binh_thuong', // Normal
                'cao', // High
                'khan_cap' // Urgent
            ])->default('binh_thuong');
            $table->timestamp('read_at')->nullable();
            $table->timestamp('scheduled_at')->nullable(); // For scheduled notifications
            $table->boolean('push_sent')->default(false);
            $table->timestamps();

            // Indexes for performance
            $table->index(['user_id']);
            $table->index(['type']);
            $table->index(['priority']);
            $table->index(['read_at']);
            $table->index(['scheduled_at']);
            $table->index(['created_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('notifications');
    }
};
