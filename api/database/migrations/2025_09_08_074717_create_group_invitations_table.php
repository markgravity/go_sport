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
        Schema::create('group_invitations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('group_id')->constrained('groups')->onDelete('cascade');
            $table->foreignId('creator_id')->constrained('users')->onDelete('cascade');
            $table->string('token', 64)->unique(); // Secure invitation token
            $table->enum('type', ['link', 'sms'])->default('link'); // Link or SMS type
            $table->string('recipient_phone', 20)->nullable(); // For SMS invitations
            $table->enum('status', ['pending', 'used', 'expired', 'revoked'])->default('pending');
            $table->timestamp('expires_at')->nullable(); // null = permanent
            $table->timestamp('used_at')->nullable();
            $table->foreignId('used_by')->nullable()->constrained('users')->onDelete('set null');
            $table->json('metadata')->nullable(); // For analytics and extra info
            $table->timestamps();
            
            // Indexes for performance
            $table->index(['token']);
            $table->index(['group_id', 'status']);
            $table->index(['creator_id']);
            $table->index(['expires_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('group_invitations');
    }
};
