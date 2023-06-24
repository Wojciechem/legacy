<?php

declare(strict_types=1);

namespace App\Tests\Fake;

use App\Security\Domain\UserRepository;
use App\Tests\TestCase\UserRepositoryTestCase;

/**
 * @property FakeUserRepository $repository
 * @covers \App\Tests\Fake\FakeUserRepository
 */
final class FakeUserRepositoryTest extends UserRepositoryTestCase
{
    public function create(): UserRepository
    {
        return new FakeUserRepository();
    }

    public function reset(): void
    {
        $this->repository->reset();
    }
}
