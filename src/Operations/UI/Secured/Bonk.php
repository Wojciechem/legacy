<?php

declare(strict_types=1);

namespace App\Operations\UI\Secured;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpKernel\Attribute\AsController;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/bonk')]
#[AsController]
final class Bonk
{
    public function __invoke(): JsonResponse
    {
        return new JsonResponse(['protected' => true]);
    }
}
