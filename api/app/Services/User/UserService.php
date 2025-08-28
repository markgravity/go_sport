<?php

namespace App\Services\User;

use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserService
{
    public function createUser(array $userData): User
    {
        $userData['password'] = Hash::make($userData['password']);
        return User::create($userData);
    }

    public function findUserByPhone(string $phone): ?User
    {
        return User::where('phone', $phone)->first();
    }

    public function findUserById(int $id): ?User
    {
        return User::find($id);
    }

    public function updateUser(User $user, array $data): User
    {
        $user->update($data);
        return $user;
    }

    public function verifyPhone(User $user): User
    {
        $user->update(['phone_verified_at' => now()]);
        return $user;
    }

    public function getUsersByGroup(int $groupId): \Illuminate\Database\Eloquent\Collection
    {
        return User::whereHas('groups', function($query) use ($groupId) {
            $query->where('group_id', $groupId);
        })->get();
    }
}