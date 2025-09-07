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
        // Check if phone column is indexed and drop it first
        Schema::table('users', function (Blueprint $table) {
            // Try to drop unique constraint first if it exists
            try {
                $table->dropUnique(['phone']);
            } catch (\Exception $e) {
                // Ignore if unique constraint doesn't exist
            }
            
            // Try to drop index if it exists
            try {
                $table->dropIndex(['phone']);
            } catch (\Exception $e) {
                // Ignore if index doesn't exist
            }
        });
        
        // Step 2: Modify phone column to TEXT and add new fields
        Schema::table('users', function (Blueprint $table) {
            // Change phone column to TEXT to support encrypted data
            $table->text('phone')->change();
            
            // Add phone_hash for secure indexing
            $table->string('phone_hash', 64)->nullable()->after('phone');
            
            // Add sports preferences for Vietnamese market
            $table->json('preferred_sports')->nullable()->after('preferences');
        });
        
        // Step 3: Add new indexes
        Schema::table('users', function (Blueprint $table) {
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
