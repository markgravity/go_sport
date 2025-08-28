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
        Schema::create('groups', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description')->nullable();
            $table->enum('sport_type', [
                'bong_da', // Football/Soccer
                'bong_ro', // Basketball
                'cau_long', // Badminton
                'tennis',
                'bong_chuyen', // Volleyball
                'bong_ban', // Table Tennis
                'chay_bo', // Running
                'dap_xe', // Cycling
                'boi_loi', // Swimming
                'yoga',
                'gym',
                'khac' // Other
            ]);
            $table->enum('skill_level', ['moi_bat_dau', 'trung_binh', 'gioi', 'chuyen_nghiep']); // Beginner, Intermediate, Advanced, Professional
            $table->text('location');
            $table->string('city');
            $table->string('district')->nullable();
            $table->decimal('latitude', 10, 8)->nullable();
            $table->decimal('longitude', 11, 8)->nullable();
            $table->json('schedule')->nullable(); // Flexible schedule in JSON
            $table->integer('max_members')->default(20);
            $table->integer('current_members')->default(1);
            $table->decimal('membership_fee', 10, 2)->default(0.00); // Monthly fee in VND
            $table->enum('privacy', ['cong_khai', 'rieng_tu'])->default('cong_khai'); // Public, Private
            $table->enum('status', ['hoat_dong', 'tam_dung', 'dong_cua'])->default('hoat_dong'); // Active, Suspended, Closed
            $table->string('avatar')->nullable();
            $table->json('rules')->nullable(); // Group rules in Vietnamese
            $table->foreignId('creator_id')->constrained('users')->onDelete('cascade');
            $table->timestamps();
            $table->softDeletes();

            // Indexes for performance
            $table->index(['sport_type']);
            $table->index(['skill_level']);
            $table->index(['city', 'district']);
            $table->index(['status']);
            $table->index(['privacy']);
            $table->index(['creator_id']);
            $table->index(['latitude', 'longitude']); // For location-based searches
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('groups');
    }
};
