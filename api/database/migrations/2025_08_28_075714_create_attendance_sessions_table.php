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
        Schema::create('attendance_sessions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('group_id')->constrained('groups')->onDelete('cascade');
            $table->string('title');
            $table->text('description')->nullable();
            $table->date('session_date');
            $table->time('start_time');
            $table->time('end_time');
            $table->text('location');
            $table->decimal('latitude', 10, 8)->nullable();
            $table->decimal('longitude', 11, 8)->nullable();
            $table->string('qr_code')->unique()->nullable(); // QR code for attendance
            $table->enum('status', [
                'sap_dien_ra', // Upcoming
                'dang_dien_ra', // Ongoing
                'da_ket_thuc', // Finished
                'bi_huy' // Cancelled
            ])->default('sap_dien_ra');
            $table->integer('expected_attendees')->default(0);
            $table->integer('actual_attendees')->default(0);
            $table->text('notes')->nullable(); // Ghi chú buổi tập
            $table->timestamps();

            // Indexes for performance
            $table->index(['group_id']);
            $table->index(['session_date']);
            $table->index(['status']);
            $table->index(['qr_code']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendance_sessions');
    }
};
