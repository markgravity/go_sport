<?php

namespace App\Services\Payment;

use App\Models\Group;
use App\Models\User;
use App\Models\Payment;
use App\Models\PaymentRequest;

class PaymentService
{
    public function createPaymentRequest(Group $group, User $creator, array $requestData): PaymentRequest
    {
        return PaymentRequest::create([
            ...$requestData,
            'group_id' => $group->id,
            'created_by' => $creator->id,
        ]);
    }

    public function processPayment(User $user, PaymentRequest $request, array $paymentData): Payment
    {
        $payment = Payment::create([
            'user_id' => $user->id,
            'payment_request_id' => $request->id,
            'amount' => $paymentData['amount'],
            'payment_method' => $paymentData['payment_method'],
            'status' => 'pending',
            'transaction_reference' => $this->generateTransactionReference(),
        ]);

        // Process payment based on method (MoMo, VietQR, ZaloPay)
        $this->processPaymentMethod($payment, $paymentData);

        return $payment;
    }

    public function confirmPayment(Payment $payment): Payment
    {
        $payment->update([
            'status' => 'completed',
            'confirmed_at' => now(),
        ]);

        return $payment;
    }

    public function refundPayment(Payment $payment, string $reason = null): Payment
    {
        $payment->update([
            'status' => 'refunded',
            'refunded_at' => now(),
            'refund_reason' => $reason,
        ]);

        return $payment;
    }

    public function getGroupPayments(Group $group): \Illuminate\Database\Eloquent\Collection
    {
        return Payment::whereHas('paymentRequest', function($query) use ($group) {
            $query->where('group_id', $group->id);
        })->with(['user', 'paymentRequest'])->get();
    }

    public function getUserPayments(User $user): \Illuminate\Database\Eloquent\Collection
    {
        return $user->payments()->with('paymentRequest.group')->get();
    }

    public function getPaymentStats(Group $group): array
    {
        $payments = $this->getGroupPayments($group);

        return [
            'total_payments' => $payments->count(),
            'total_amount' => $payments->where('status', 'completed')->sum('amount'),
            'pending_payments' => $payments->where('status', 'pending')->count(),
            'completed_payments' => $payments->where('status', 'completed')->count(),
            'refunded_payments' => $payments->where('status', 'refunded')->count(),
        ];
    }

    private function processPaymentMethod(Payment $payment, array $paymentData): void
    {
        // Process payment based on Vietnamese payment methods
        switch ($payment->payment_method) {
            case 'momo':
                $this->processMoMoPayment($payment, $paymentData);
                break;
            case 'vietqr':
                $this->processVietQRPayment($payment, $paymentData);
                break;
            case 'zalopay':
                $this->processZaloPayPayment($payment, $paymentData);
                break;
            default:
                throw new \InvalidArgumentException('Unsupported payment method');
        }
    }

    private function processMoMoPayment(Payment $payment, array $paymentData): void
    {
        // MoMo API integration logic
        // For now, mark as completed (in production, integrate with MoMo API)
        $payment->update(['status' => 'completed', 'confirmed_at' => now()]);
    }

    private function processVietQRPayment(Payment $payment, array $paymentData): void
    {
        // VietQR API integration logic
        // For now, mark as completed (in production, integrate with VietQR API)
        $payment->update(['status' => 'completed', 'confirmed_at' => now()]);
    }

    private function processZaloPayPayment(Payment $payment, array $paymentData): void
    {
        // ZaloPay API integration logic
        // For now, mark as completed (in production, integrate with ZaloPay API)
        $payment->update(['status' => 'completed', 'confirmed_at' => now()]);
    }

    private function generateTransactionReference(): string
    {
        return 'TXN_' . uniqid() . '_' . time();
    }
}