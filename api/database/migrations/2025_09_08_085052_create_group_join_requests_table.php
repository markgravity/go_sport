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
        Schema::create('group_join_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('group_id')->constrained('groups')->onDelete('cascade');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('invitation_id')->nullable()->constrained('group_invitations')->onDelete('set null');
            $table->enum('status', ['pending', 'approved', 'rejected'])->default('pending');
            $table->text('message')->nullable(); // User's join message
            $table->text('rejection_reason')->nullable(); // Admin's rejection reason
            $table->string('source', 50)->default('direct'); // direct, invitation, search
            $table->foreignId('processed_by')->nullable()->constrained('users')->onDelete('set null');
            $table->timestamp('processed_at')->nullable();
            $table->json('metadata')->nullable(); // Extra info like referrer, etc.
            $table->timestamps();
            
            // Indexes for performance
            $table->index(['group_id', 'status']);
            $table->index(['user_id', 'status']);
            $table->index(['status', 'created_at']);
            
            // Prevent duplicate pending requests
            $table->unique(['group_id', 'user_id', 'status'], 'unique_pending_request');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('group_join_requests');
    }
};
