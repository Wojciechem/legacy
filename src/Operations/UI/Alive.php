<?php
declare(strict_types=1);

namespace App\Operations\UI;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpKernel\Attribute\AsController;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/aliveness')]
#[AsController]
final class Alive
{
    public function __invoke(): JsonResponse
    {
        return new JsonResponse(['alive' => true]);
    }
}
