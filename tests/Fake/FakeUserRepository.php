<?php

declare(strict_types=1);

namespace App\Tests\Fake;

use App\Security\Domain\Entity\User;
use App\Security\Domain\UserNotFound;
use App\Security\Domain\UserRepository;

final class FakeUserRepository implements UserRepository
{
    private array $users;

    public function reset()
    {
        $this->users = [];
    }

    public function count(): int
    {
        return \count($this->users);
    }

    public function add(User $user)
    {
        $this->users[] = $user;
    }

    public function get(string $id): User
    {
        $filtered = array_filter($this->users, function (User $user) use ($id) {
            return $user->id() === $id;
        });
        $filtered = array_values($filtered);

        if (empty($filtered)) {
            throw new UserNotFound();
        }

        return $filtered[0];
    }
}
