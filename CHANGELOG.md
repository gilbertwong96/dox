# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-03-15

### Added
- Rate limit information in response (`rate_limit`, `rate_remaining`, `rate_reset`)
- `Response.rate_limit_info/1` and `Response.near_rate_limit?/2` helpers

### Changed
- Allow passing keyword args directly for POST/PUT/PATCH requests (no need for `body:` wrapper)
- Hide internal headers from Response struct
- Mark project as experimental in README

## [0.1.0] - 2026-03-14

### Added
- Core library modules for DigitalOcean API client
- DigitalOcean API resource modules (account, actions, apps, cdn, certificates, databases, domains, droplets, firewalls, floating_ips, images, kubernetes, load_balancers, one_clicks, projects, registries, regions, reserved_ips, sizes, snapshots, tags, volumes, vpcs)
- Config-based token injection plugin
- GitHub Actions CI workflow
- Test suite using Mox for mocking HTTP requests
- Project documentation
- OTP application with supervised HTTP connection pools
