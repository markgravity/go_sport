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
            $table->enum('event_type', ['sent', 'clicked', 'registered', 'joined', 'rejected']);
            $table->string('user_agent')->nullable(); // Browser/device info
            $table->string('ip_address', 45)->nullable(); // IPv4/IPv6 support
            $table->string('referrer')->nullable(); // Where the click came from
            $table->json('metadata')->nullable(); // Additional tracking data
            $table->timestamps();
            
            // Indexes for analytics queries
            $table->index(['invitation_id', 'event_type']);
            $table->index(['event_type', 'created_at']);
            $table->index(['created_at']); // For time-based queries
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
