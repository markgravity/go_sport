<?php

namespace App\Services;

use Kreait\Firebase\Factory;
use Kreait\Firebase\Auth as FirebaseAuth;
use Kreait\Firebase\Exception\Auth\FailedToVerifyToken;
use Kreait\Firebase\Exception\FirebaseException;
use Illuminate\Support\Facades\Log;

class FirebaseAuthService
{
    protected ?FirebaseAuth $auth;

    public function __construct()
    {
        $serviceAccountPath = config('firebase.service_account_path');
        
        if (!$this->isConfigured()) {
            Log::warning('Firebase service account not configured', [
                'expected_path' => $serviceAccountPath
            ]);
            $this->auth = null;
            return;
        }
        
        try {
            $factory = (new Factory)
                ->withServiceAccount($serviceAccountPath);
            
            $this->auth = $factory->createAuth();
        } catch (\Exception $e) {
            Log::error('Failed to initialize Firebase Auth', [
                'error' => $e->getMessage(),
                'service_account_path' => $serviceAccountPath
            ]);
            $this->auth = null;
        }
    }

    public function verifyIdToken(string $idToken): ?array
    {
        if (!$this->auth) {
            Log::warning('Firebase Auth not initialized, cannot verify token');
            return null;
        }
        
        try {
            $verifiedIdToken = $this->auth->verifyIdToken($idToken);
            
            return [
                'uid' => $verifiedIdToken->claims()->get('sub'),
                'phone' => $verifiedIdToken->claims()->get('phone_number'),
                'firebase_claims' => $verifiedIdToken->claims()->all(),
            ];
        } catch (FailedToVerifyToken $e) {
            Log::warning('Firebase token verification failed', [
                'error' => $e->getMessage(),
                'token_snippet' => substr($idToken, 0, 20) . '...'
            ]);
            return null;
        } catch (FirebaseException $e) {
            Log::error('Firebase service error', [
                'error' => $e->getMessage()
            ]);
            return null;
        }
    }

    public function getUserByUid(string $uid): ?array
    {
        if (!$this->auth) {
            Log::warning('Firebase Auth not initialized, cannot get user');
            return null;
        }
        
        try {
            $userRecord = $this->auth->getUser($uid);
            
            return [
                'uid' => $userRecord->uid,
                'phone' => $userRecord->phoneNumber,
                'email' => $userRecord->email,
                'display_name' => $userRecord->displayName,
                'photo_url' => $userRecord->photoUrl,
                'disabled' => $userRecord->disabled,
                'email_verified' => $userRecord->emailVerified,
                'phone_verified' => !empty($userRecord->phoneNumber),
                'provider_data' => $userRecord->providerData,
                'custom_claims' => $userRecord->customClaims,
                'created_at' => $userRecord->createdAt,
                'last_sign_in_at' => $userRecord->lastSignInAt,
            ];
        } catch (FirebaseException $e) {
            Log::error('Failed to get Firebase user', [
                'uid' => $uid,
                'error' => $e->getMessage()
            ]);
            return null;
        }
    }

    public function getUserByPhoneNumber(string $phoneNumber): ?array
    {
        if (!$this->auth) {
            Log::warning('Firebase Auth not initialized, cannot get user by phone');
            return null;
        }
        
        try {
            $userRecord = $this->auth->getUserByPhoneNumber($phoneNumber);
            return $this->getUserByUid($userRecord->uid);
        } catch (FirebaseException $e) {
            Log::info('Firebase user not found by phone', [
                'phone' => $phoneNumber,
                'error' => $e->getMessage()
            ]);
            return null;
        }
    }

    public function setCustomClaims(string $uid, array $claims): bool
    {
        if (!$this->auth) {
            Log::warning('Firebase Auth not initialized, cannot set custom claims');
            return false;
        }
        
        try {
            $this->auth->setCustomUserClaims($uid, $claims);
            return true;
        } catch (FirebaseException $e) {
            Log::error('Failed to set Firebase custom claims', [
                'uid' => $uid,
                'claims' => $claims,
                'error' => $e->getMessage()
            ]);
            return false;
        }
    }

    public function createCustomToken(string $uid, array $additionalClaims = []): ?string
    {
        if (!$this->auth) {
            Log::warning('Firebase Auth not initialized, cannot create custom token');
            return null;
        }
        
        try {
            return $this->auth->createCustomToken($uid, $additionalClaims);
        } catch (FirebaseException $e) {
            Log::error('Failed to create Firebase custom token', [
                'uid' => $uid,
                'error' => $e->getMessage()
            ]);
            return null;
        }
    }

    public function deleteUser(string $uid): bool
    {
        if (!$this->auth) {
            Log::warning('Firebase Auth not initialized, cannot delete user');
            return false;
        }
        
        try {
            $this->auth->deleteUser($uid);
            return true;
        } catch (FirebaseException $e) {
            Log::error('Failed to delete Firebase user', [
                'uid' => $uid,
                'error' => $e->getMessage()
            ]);
            return false;
        }
    }

    public function isConfigured(): bool
    {
        try {
            $serviceAccountPath = config('firebase.service_account_path');
            return !empty($serviceAccountPath) && file_exists($serviceAccountPath);
        } catch (\Exception $e) {
            return false;
        }
    }
}