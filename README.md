# Legacy
All code becomes legacy, eventually. Try to leave a good one.

I want this repository to be a snapshot of my knowledge, experience and opinionated way of working with software.

## Features:
- Trunk-based development
- Clean Architecture
- Delivery Pipeline
- Test Driven Development
- Safe to fail over "failsafe"

## Details:
- Four-layer: UI, Application, Domain, Infrastructure.
- Dockerfile using BuildKit features: multistage, build-time bind/cache mounts, cache export to registry
- Scalable "build-once, test-many" delivery pipeline using `-test` container image artifact

## Contents:
 - [This File](README.md)
   - what? why?
 - [pipeline.yml](.github/workflows/pipeline.yml)
   - how to build, test and deliver this software using GitHub Actions
 - [Dockerfile](Dockerfile)
   - how to efficiently build container image for this project:
       - what OS-level software is required
       - how to install "userland" PHP packages
       - which source files are used for testing
       - which source files are used for distribution build
 - [composer.lock](composer.lock)
   - what precisely to install when running `composer install`
   - what versions of packages were _locked_ during last `composer require` / `composer update`
 - [composer.json](composer.json)
   - what open source "userland" PHP packages does this project depend on
   - which packages are required for build / test environments only (`require-dev`)
   - how to create class autoloaders
 - Source code
   - [public/index.php](public/index.php)
     - how to handle incoming http request by the application
     - which "runtime" should be used to run the application
     - which application kernel should be loaded
   - [src/Kernel.php](src/Kernel.php)
     - how does the core of the application work, based on Configuration
     - are any methods from Symfony Framework Kernel overridden
   - `src/Operations`
     - what functionality is exposed to help operate this app's deployment
 - `tests`
   - what functionality does this system provide
   - what is the correct and expected behaviour of code units
   - how to use code units
   - do the code units work
   - does the application work
 - Configuration
   - `config/packages`
     - what packages recognized by Symfony Framework are used in this project
     - what specific settings are configured for this packages
   - [bundles.php](config/bundles.php)
     - what packages should be loaded and for what environments
   - [routes.yaml](config/routes.yaml)
     - what http endpoints are exposed by this application
     - what "controllers" / UI "request handlers" do the routes point to
     - where should the framework look for more route configurations
   - [services.yaml](config/services.yaml)
     - which classes should be available in the Dependency Injection container as "services"
     - how are those "services" made
     - are there any additional aliases, tags describing them?
     - should some interfaces point to specific classes
     - should the DI component try to resolve - "autowire" service dependencies
   - [phpunit.xml.dist](phpunit.xml.dist)
     - how to run the application's tests
     - how should code coverage be calculated and reported
     - what should fail the tests
     - what should trigger a warning
   - [deptrac.yaml](deptrac.yaml)
     - what dependencies between application layers are allowed