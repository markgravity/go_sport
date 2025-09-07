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
        Schema::create('group_level_requirements', function (Blueprint $table) {
            $table->id();
            $table->foreignId('group_id')->constrained('groups')->onDelete('cascade');
            $table->string('sport_type'); // badminton, tennis, football, pickleball
            $table->string('level_key'); // moi_bat_dau, so_cap, trung_cap, cao_cap, chuyen_nghiep
            $table->string('level_name'); // Vietnamese display name
            $table->text('level_description')->nullable(); // Optional description
            $table->timestamps();
            
            // Indexes for performance
            $table->index(['group_id', 'sport_type']);
            $table->index(['sport_type', 'level_key']);
            
            // Prevent duplicate level requirements per group
            $table->unique(['group_id', 'level_key']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('group_level_requirements');
    }
};
