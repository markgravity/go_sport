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
            $table->string('phone', 15)->unique()->after('email'); // Vietnamese phone format: +84xxxxxxxxx
            $table->timestamp('phone_verified_at')->nullable()->after('phone');
            $table->date('date_of_birth')->nullable()->after('password');
            $table->enum('gender', ['male', 'female', 'other'])->nullable()->after('date_of_birth');
            $table->text('address')->nullable()->after('gender');
            $table->string('city')->nullable()->after('address');
            $table->string('province')->nullable()->after('city');
            $table->string('avatar')->nullable()->after('province');
            $table->enum('status', ['active', 'inactive', 'banned'])->default('active')->after('avatar');
            $table->string('fcm_token')->nullable()->after('status'); // For push notifications
            $table->json('preferences')->nullable()->after('fcm_token'); // Vietnamese preferences
            $table->softDeletes();

            // Indexes for performance
            $table->index(['phone']);
            $table->index(['status']);
            $table->index(['city', 'province']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropIndex(['phone']);
            $table->dropIndex(['status']);
            $table->dropIndex(['city', 'province']);
            
            $table->dropColumn([
                'phone',
                'phone_verified_at',
                'date_of_birth',
                'gender',
                'address',
                'city',
                'province',
                'avatar',
                'status',
                'fcm_token',
                'preferences',
                'deleted_at'
            ]);
        });
    }
};
