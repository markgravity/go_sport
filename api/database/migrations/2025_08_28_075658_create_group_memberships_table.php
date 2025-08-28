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
        Schema::create('group_memberships', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('group_id')->constrained('groups')->onDelete('cascade');
            $table->enum('role', [
                'admin', // Quản trị viên
                'moderator', // Điều hành viên
                'member', // Thành viên
                'pending' // Chờ duyệt
            ])->default('member');
            $table->enum('status', [
                'hoat_dong', // Active
                'tam_dung', // Suspended
                'roi_nhom' // Left group
            ])->default('hoat_dong');
            $table->timestamp('joined_at')->nullable();
            $table->timestamp('left_at')->nullable();
            $table->text('join_reason')->nullable(); // Lý do tham gia
            $table->text('leave_reason')->nullable(); // Lý do rời nhóm
            $table->decimal('total_paid', 10, 2)->default(0.00); // Tổng tiền đã đóng
            $table->integer('attendance_count')->default(0); // Số buổi tham gia
            $table->json('member_notes')->nullable(); // Ghi chú về thành viên
            $table->timestamps();

            // Ensure unique membership per user per group
            $table->unique(['user_id', 'group_id']);

            // Indexes for performance
            $table->index(['user_id']);
            $table->index(['group_id']);
            $table->index(['role']);
            $table->index(['status']);
            $table->index(['joined_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('group_memberships');
    }
};
