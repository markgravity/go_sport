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
        Schema::create('payment_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('group_id')->constrained('groups')->onDelete('cascade');
            $table->foreignId('created_by')->constrained('users')->onDelete('cascade');
            $table->string('title');
            $table->text('description')->nullable();
            $table->decimal('amount', 12, 2); // Amount in VND
            $table->enum('type', [
                'phi_thanh_vien', // Membership fee
                'phi_trang_phuc', // Equipment/Uniform fee
                'phi_san_banh', // Court/Field fee
                'phi_huan_luyen_vien', // Coach fee
                'phi_giai_dau', // Tournament fee
                'khac' // Other
            ]);
            $table->date('due_date');
            $table->enum('status', [
                'cho_thanh_toan', // Pending payment
                'da_thanh_toan', // Paid
                'qua_han', // Overdue
                'da_huy' // Cancelled
            ])->default('cho_thanh_toan');
            $table->json('payment_methods')->nullable(); // Supported methods: momo, vietqr, zalopay
            $table->text('payment_instructions')->nullable(); // Vietnamese payment instructions
            $table->timestamps();

            // Indexes for performance
            $table->index(['group_id']);
            $table->index(['created_by']);
            $table->index(['status']);
            $table->index(['type']);
            $table->index(['due_date']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment_requests');
    }
};
