<?php

declare(strict_types=1);

namespace App\Security\Domain;

use App\Security\Domain\Entity\User;

interface UserRepository
{
    public function count(): int;

    public function add(User $user);

    public function get(string $id): User;
}
