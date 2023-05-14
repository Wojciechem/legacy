<?php
declare(strict_types=1);

namespace App\Tests;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

final class AlivenessTest extends KernelTestCase
{
    public function testThatKernelBoots(): void
    {
        self::bootKernel();
        $request = Request::create('/ops/aliveness');
        $request->headers->set('Accept', 'application/json');

        $response = self::$kernel->handle($request);

        self::assertInstanceOf(JsonResponse::class, $response);
        self::assertJsonStringEqualsJsonString('{"alive": true}', $response->getContent());
    }
}
