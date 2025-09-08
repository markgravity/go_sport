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
        Schema::create('invitation_analytics', function (Blueprint $table) {
            $table->id();
            $table->foreignId('invitation_id')->constrained('group_invitations')->onDelete('cascade');
            $table->enum('event', ['created', 'sent', 'clicked', 'used', 'expired', 'revoked']);
            $table->string('source', 50)->nullable(); // app, web, share
            $table->string('user_agent')->nullable(); // Browser/device info
            $table->string('ip_address', 45)->nullable(); // IPv4/IPv6 support
            $table->json('metadata')->nullable(); // Additional event data
            $table->timestamp('occurred_at');
            $table->timestamps();
            
            // Indexes for analytics queries
            $table->index(['invitation_id', 'event']);
            $table->index(['event', 'occurred_at']);
            $table->index(['occurred_at']); // For time-based queries
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('invitation_analytics');
    }
};
