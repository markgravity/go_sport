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
        Schema::table('groups', function (Blueprint $table) {
            // Remove max_members field - we no longer limit group size
            $table->dropColumn('max_members');
            
            // Remove single skill_level field - will be replaced by level requirements
            $table->dropColumn('skill_level');
            
            // Rename membership_fee to monthly_fee for clarity
            $table->renameColumn('membership_fee', 'monthly_fee');
            
            // Add comment for monthly_fee calculation
            $table->decimal('monthly_fee', 10, 2)->default(0.00)->change()->comment('Monthly fee in VND - divide by current_members for per-member fee');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('groups', function (Blueprint $table) {
            // Restore max_members field
            $table->integer('max_members')->default(20);
            
            // Restore skill_level field
            $table->enum('skill_level', ['moi_bat_dau', 'trung_binh', 'gioi', 'chuyen_nghiep']);
            
            // Rename back to membership_fee
            $table->renameColumn('monthly_fee', 'membership_fee');
            
            // Remove comment
            $table->decimal('membership_fee', 10, 2)->default(0.00)->change()->comment(null);
        });
    }
};
