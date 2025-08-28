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
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('payment_request_id')->constrained('payment_requests')->onDelete('cascade');
            $table->decimal('amount', 12, 2); // Amount in VND
            $table->enum('payment_method', [
                'momo',
                'vietqr',
                'zalopay',
                'bank_transfer', // Chuyển khoản ngân hàng
                'cash', // Tiền mặt
                'other'
            ]);
            $table->string('transaction_reference')->unique()->nullable();
            $table->enum('status', [
                'cho_xu_ly', // Pending
                'thanh_cong', // Completed
                'that_bai', // Failed
                'hoan_tien' // Refunded
            ])->default('cho_xu_ly');
            $table->timestamp('confirmed_at')->nullable();
            $table->timestamp('refunded_at')->nullable();
            $table->text('refund_reason')->nullable();
            $table->json('payment_details')->nullable(); // Vietnamese payment gateway response
            $table->text('admin_notes')->nullable(); // Admin notes in Vietnamese
            $table->timestamps();

            // Indexes for performance
            $table->index(['user_id']);
            $table->index(['payment_request_id']);
            $table->index(['status']);
            $table->index(['payment_method']);
            $table->index(['transaction_reference']);
            $table->index(['confirmed_at']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
