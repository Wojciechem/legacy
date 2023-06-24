<?php

declare(strict_types=1);

namespace App\Tests\TestCase;

use App\Security\Domain\Entity\User;
use App\Security\Domain\UserNotFound;
use App\Security\Domain\UserRepository;
use PHPUnit\Framework\TestCase;

abstract class UserRepositoryTestCase extends TestCase
{
    protected UserRepository $repository;

    abstract public function create(): UserRepository;
    abstract public function reset(): void;

    protected function setUp(): void
    {
        $this->repository = $this->create();
        $this->reset();
    }

    final public function testItCanBeStored(): void
    {
        self::assertEquals(0, $this->repository->count());
        $this->repository->add(new User('john'));

        self::assertEquals('john', $this->repository->get('john')->id());
    }

    public function testGetNotExistingUserResultsInException(): void
    {
        $this->expectException(UserNotFound::class);
        $this->repository->get('mrX');
    }
}
