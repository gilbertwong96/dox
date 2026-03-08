# CLAUDE.md

Project-specific instructions for the Dox Elixir library (DigitalOcean API client).

## Project Overview

- **Project name**: Dox
- **Type**: Elixir library (Hex package)
- **Purpose**: DigitalOcean API v2 client with full resource coverage
- **Elixir version**: ~> 1.18

## Key Files

- `lib/dox.ex` - Main module with client initialization
- `lib/dox/client.ex` - HTTP client using Req
- `lib/dox/request.ex` - Request building and execution
- `lib/dox/response.ex` - Response parsing
- `lib/dox/resources/*.ex` - Individual API resources (droplets, volumes, etc.)

## Commit Principle

Commit code with atomic commit principle and commit with the message which follows the git conventional commit spec

## Development Commands

```bash
mix deps.get          # Install dependencies
mix compile           # Compile the project
mix test              # Run tests
mix credo --strict   # Run Credo linter
mix dialyxir         # Run Dialyzer type checks
mix format           # Format code
mix format --check-formatted  # Check formatting
mix ci               # Run full CI pipeline
```

## Code Style

- Follow Elixir conventions (use `mix format`)
- Credo strict mode is enforced in CI
- Run `mix format` before committing
- Use type specs for public functions
- Match the existing documentation style in resource modules

## Verification

- Always run `mix ci` to verify changes before considering work complete
- Fix any CI failures before committing

## Testing

- Tests use Mox for mocking HTTP requests
- Test coverage minimum: 15%
- Add tests for new resource functions in `test/dox_test.exs`

## Resources

The library wraps these DigitalOcean API resources:
- account, actions, apps, cdn, certificates, databases
- domains, droplets, firewalls, floating_ips, images
- kubernetes, load_balancers, one_clicks, projects
- registries, regions, reserved_ips, sizes, snapshots
- tags, volumes, vpcs
