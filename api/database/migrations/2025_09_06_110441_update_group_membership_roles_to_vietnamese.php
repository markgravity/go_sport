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
        // Add 'guest' role to existing English roles  
        DB::statement("ALTER TABLE group_memberships MODIFY COLUMN role ENUM('admin', 'moderator', 'member', 'guest', 'pending') DEFAULT 'member'");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Revert role enum to original without guest
        DB::statement("ALTER TABLE group_memberships MODIFY COLUMN role ENUM('admin', 'moderator', 'member', 'pending') DEFAULT 'member'");
    }
};
