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
        Schema::table('users', function (Blueprint $table) {
            // Add phone_hash for secure indexing (phone column will be encrypted at app level)
            $table->string('phone_hash', 64)->nullable()->after('phone'); // For secure indexing
            
            // Add sports preferences for Vietnamese market
            $table->json('preferred_sports')->nullable()->after('preferences'); // Vietnamese sports preferences
            
            // Add indexes for phone hash lookup
            $table->index(['phone_hash']);
            $table->unique(['phone_hash']); // Make phone_hash unique for lookups
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // Drop indexes and constraints first
            $table->dropUnique(['phone_hash']);
            $table->dropIndex(['phone_hash']);
            
            // Remove columns
            $table->dropColumn(['phone_hash', 'preferred_sports']);
        });
    }
};
