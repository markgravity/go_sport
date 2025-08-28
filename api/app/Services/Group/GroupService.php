<?php

namespace App\Services\Group;

use App\Models\Group;
use App\Models\User;

class GroupService
{
    public function createGroup(User $user, array $groupData): Group
    {
        $group = Group::create([
            ...$groupData,
            'creator_id' => $user->id,
        ]);

        // Add creator as admin member
        $group->members()->attach($user->id, [
            'role' => 'admin',
            'joined_at' => now(),
        ]);

        return $group;
    }

    public function findGroupById(int $id): ?Group
    {
        return Group::with(['members', 'creator'])->find($id);
    }

    public function getUserGroups(User $user): \Illuminate\Database\Eloquent\Collection
    {
        return $user->groups()->with(['creator', 'members'])->get();
    }

    public function addMemberToGroup(Group $group, User $user, string $role = 'member'): void
    {
        if (!$group->members->contains($user->id)) {
            $group->members()->attach($user->id, [
                'role' => $role,
                'joined_at' => now(),
            ]);
        }
    }

    public function removeMemberFromGroup(Group $group, User $user): void
    {
        $group->members()->detach($user->id);
    }

    public function updateGroup(Group $group, array $data): Group
    {
        $group->update($data);
        return $group;
    }

    public function getGroupsByLocation(string $location): \Illuminate\Database\Eloquent\Collection
    {
        return Group::where('location', 'LIKE', "%{$location}%")->get();
    }

    public function getGroupsBySport(string $sportType): \Illuminate\Database\Eloquent\Collection
    {
        return Group::where('sport_type', $sportType)->get();
    }
}