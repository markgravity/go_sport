<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Update sport_type enum to only supported sports in English
        DB::statement("ALTER TABLE groups MODIFY COLUMN sport_type ENUM('football', 'badminton', 'tennis', 'pickleball')");
        
        // Add Vietnamese-specific fields for group settings
        Schema::table('groups', function (Blueprint $table) {
            $table->integer('min_players')->nullable()->after('max_members'); // Sport-specific minimum players
            $table->integer('notification_hours_before')->default(2)->after('min_players'); // Hours before game to notify
            $table->json('default_locations')->nullable()->after('notification_hours_before'); // Common Vietnamese venues for this sport
            $table->string('vietnamese_name')->nullable()->after('name'); // Vietnamese culturally appropriate name
            $table->boolean('auto_approve_members')->default(true)->after('privacy'); // Auto-approve new members
            $table->json('sport_specific_settings')->nullable()->after('auto_approve_members'); // Settings specific to each sport
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('groups', function (Blueprint $table) {
            $table->dropColumn([
                'min_players',
                'notification_hours_before', 
                'default_locations',
                'vietnamese_name',
                'auto_approve_members',
                'sport_specific_settings'
            ]);
        });
        
        // Revert sport_type enum to original
        DB::statement("ALTER TABLE groups MODIFY COLUMN sport_type ENUM('bong_da', 'bong_ro', 'cau_long', 'tennis', 'bong_chuyen', 'bong_ban', 'chay_bo', 'dap_xe', 'boi_loi', 'yoga', 'gym', 'khac')");
    }
};
