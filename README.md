# Legacy
all code becomes legacy.. try to leave a good one

I want this repository to be a snapshot of my knowledge, experience and opinionated way of working with software.

## Features:
- Trunk-based development
- Clean Architecture
- Delivery Pipeline
- Test Driven Development
- Safe to fail over "failsafe"

## Details:
- Four-layer: UI, Application, Domain, Infrastructure. Correct dependencies between layers are guarded by high-level deptrac rules.
- Dockerfile using BuildKit features: multistage, build-time bind/cache mounts, cache export to registry
- Scalable "build-once, test-many" delivery pipeline using `-test` container image artifact
