<?php

declare(strict_types=1);

namespace App\Security\Domain\Entity;

final class User
{
    private readonly string $id;

    public function __construct(string $id)
    {
        $this->id = $id;
    }

    public function id(): string
    {
        return $this->id;
    }
}
