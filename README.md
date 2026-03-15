# Dox (Experimental)

> ⚠️ **This project is in early experimental stage. APIs may change.**

[![Hex](https://img.shields.io/hexpm/v/dox.svg)](https://hex.pm/packages/dox)
[![Documentation](https://img.shields.io/badge/hexdocs-latest-blue.svg)](https://hexdocs.pm/dox)
[![CI](https://github.com/gilbertwong96/dox/workflows/CI/badge.svg)](https://github.com/gilbertwong96/dox/actions)
[![Coverage](https://coveralls.io/repos/github/gilbertwong96/dox/badge.svg?branch=main)](https://coveralls.io/github/gilbertwong96/dox?branch=main)

Dox is an Elixir library for interacting with the [DigitalOcean API v2](https://docs.digitalocean.com/reference/api/api-reference/). It provides a clean, idiomatic Elixir interface for managing DigitalOcean resources.

## Features

- **Complete API Coverage** - Supports all DigitalOcean API resources including Droplets, Volumes, Databases, Kubernetes, and more
- **Plugin System** - Extend request behavior with custom plugins for retry logic, logging, caching, metrics, etc.
- **Type-safe Responses** - Returns structured response objects with type specifications
- **Error Handling** - Comprehensive error handling with detailed error information
- **HTTP Client** - Built on top of [Finch](https://hexdocs.pm/finch/Finch.html) for reliable HTTP requests
- **OTP Application** - Supervised HTTP connection pools for production use

## Installation

Add `dox` to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dox, "~> 0.1.0"}
  ]
end
```

## Quick Start

```elixir
# Configure your API token
token = System.get_env("DIGITALOCEAN_TOKEN")

# List all droplets
{:ok, response} = Dox.Droplets.list(token: token)

# Get a specific droplet
{:ok, response} = Dox.Droplets.get(12345, token: token)

# Create a droplet
{:ok, response} = Dox.Droplets.create(
  name: "my-droplet",
  region: "nyc1",
  size: "s-1vcpu-1gb",
  image: "ubuntu-20-04-x64",
  token: token
)

# Use bang versions to raise on error
response = Dox.Droplets.list!(token: token)
```

## Configuration

### Config-based Token (Recommended)

You can set your API token in your application config:

```elixir
# config/config.exs
config :dox, api_token: System.get_env("DIGITALOCEAN_TOKEN")
```

Then use resources without passing the token each time:

```elixir
# Uses token from config
{:ok, response} = Dox.Droplets.list()
```

### Per-request Token

Alternatively, you can pass the token directly to each function:

```elixir
{:ok, response} = Dox.Droplets.list(token: "your_api_token")
```

The per-request token takes precedence over the config token if both are set.

### Custom Plugins

Configure custom plugins in your application config:

```elixir
# config/config.exs
config :dox, plugins: [MyPlugin]
```

## Available Resources

Dox provides modules for all DigitalOcean API resources:

| Module | Description |
|--------|-------------|
| `Dox.Account` | Account information and SSH keys |
| `Dox.Actions` | Actions (async operations) |
| `Dox.Apps` | App Platform |
| `Dox.Cdn` | CDN endpoints |
| `Dox.Certificates` | SSL certificates |
| `Dox.Databases` | Managed databases |
| `Dox.Domains` | DNS domains |
| `Dox.Droplets` | Virtual servers |
| `Dox.Firewalls` | Firewall rules |
| `Dox.FloatingIps` | Floating IPs |
| `Dox.Images` | Images and snapshots |
| `Dox.Kubernetes` | Kubernetes clusters |
| `Dox.LoadBalancers` | Load balancers |
| `Dox.OneClicks` | 1-Click applications |
| `Dox.Projects` | Projects |
| `Dox.Regions` | Available regions |
| `Dox.Registries` | Container registries |
| `Dox.ReservedIps` | Reserved IPs |
| `Dox.Sizes` | Available droplet sizes |
| `Dox.Snapshots` | Snapshots |
| `Dox.Tags` | Resource tags |
| `Dox.Volumes` | Block storage volumes |
| `Dox.Vpcs` | Virtual private clouds |

## Error Handling

Each function returns a tuple `{:ok, response}` or `{:error, error}`. You can also use bang versions that raise on errors:

```elixir
# Non-bang version - returns error tuple
case Dox.Droplets.get(12345, token: token) do
  {:ok, droplet} ->
    IO.puts("Got droplet: #{droplet.name}")

  {:error, %Dox.Error{message: message}} ->
    IO.puts("Error: #{message}")
end

# Bang version - raises on error
droplet = Dox.Droplets.get!(12345, token: token)
```

### Error Struct

The `Dox.Error` struct contains:

- `message` - Human-readable error message
- `status_code` - HTTP status code (if available)
- `response` - Full API response body (if available)
- `reason` - Atom indicating the error type (`:api_error`, `:timeout`, `:connect_timeout`, etc.)

## Plugin System

Dox supports plugins that can modify request and response behavior. Plugins are useful for:

- Retry logic
- Logging and debugging
- Caching
- Metrics collection
- Request/response transformation

### Creating a Plugin

```elixir
defmodule MyPlugin do
  @behaviour Dox.Plugin

  @impl true
  def init(opts) do
    # Initialize plugin state
    {:ok, %{request_count: 0}}
  end

  @impl true
  def before_request(request, state) do
    # Modify request (add headers, log, etc.)
    new_headers = [{"x-my-plugin", "active"} | request.headers]
    {%{request | headers: new_headers}, state}
  end

  @impl true
  def after_response(response, state, request) do
    # Process response (log, cache, etc.)
    IO.puts("Request completed with status #{response.status}")
    {:ok, response, state}
  end
end
```

Or use the `use Dox.Plugin` macro for default implementations:

```elixir
defmodule SimplePlugin do
  use Dox.Plugin

  @impl true
  def init(opts) do
    {:ok, opts}
  end

  # before_request and after_response use default implementations
end
```

### Using Plugins

Plugins can be configured globally or per-request:

```elixir
# Per-request plugins
Dox.Droplets.list(token: token, plugins: [MyPlugin])

# Global plugins (in config/config.exs)
# config :dox, :plugins, [MyPlugin]
```

## Request Options

All resource functions accept the following options:

| Option | Type | Description |
|--------|------|-------------|
| `token` | string | **Required.** Your DigitalOcean API token |
| `params` | map | Query parameters |
| `body` | map | Request body (for POST/PUT/PATCH) |
| `plugins` | list | List of plugins to apply |
| `receive_timeout` | integer | Response receive timeout (default: 30000ms) |
| `connect_timeout` | integer | Connection timeout (default: 10000ms) |

## Examples

### Working with Droplets

```elixir
# List all droplets with pagination
{:ok, response} = Dox.Droplets.list(
  token: token,
  params: %{per_page: 100, page: 1}
)

# Create a droplet with user data
{:ok, response} = Dox.Droplets.create(
  name: "web-server",
  region: "nyc1",
  size: "s-2vcpu-2gb",
  image: "ubuntu-20-04-x64",
  user_data: "#!/bin/bash\necho 'Hello World' > /tmp/hello",
  backups: true,
  ipv6: true,
  token: token
)

# Delete a droplet
{:ok, _response} = Dox.Droplets.delete(12345, token: token)

# Get droplet action status
{:ok, response} = Dox.Droplets.action(12345, action_id: 123, token: token)
```

### Working with Volumes

```elixir
# Create a volume
{:ok, response} = Dox.Volumes.create(
  name: "my-volume",
  region: "nyc1",
  size_gigabytes: 10,
  token: token
)

# Attach volume to droplet
{:ok, response} = Dox.Volumes.attach(
  volume_id: "volume-uuid",
  droplet_id: 12345,
  token: token
)
```

### Working with Kubernetes

```elixir
# Create a Kubernetes cluster
{:ok, response} = Dox.Kubernetes.create_cluster(
  name: "my-cluster",
  region: "nyc1",
  version: "1.27",
  node_pools: [
    %{
      name: "worker-pool",
      size: "s-2vcpu-2gb",
      count: 3
    }
  ],
  token: token
)

# Get cluster credentials
{:ok, response} = Dox.Kubernetes.get_credentials(cluster_id: "cluster-uuid", token: token)
```

### Working with Databases

```elixir
# Create a managed database
{:ok, response} = Dox.Databases.create(
  name: "my-db",
  engine: "pg",
  version: "15",
  region: "nyc1",
  size: "db-s-dev-git",
  token: token
)

# Create a database user
{:ok, response} = Dox.Databases.create_user(
  cluster_id: "cluster-uuid",
  name: "admin",
  token: token
)
```

## Development

### Running Tests

```bash
mix test              # Run tests
mix test --cover     # Run tests with coverage
mix credo --strict   # Run linter
mix dialyxir         # Run type checker
mix ci               # Run full CI pipeline
```

### Building Documentation

```bash
mix docs             # Generate documentation
mix hex.build        # Build package for Hex
mix hex.publish      # Publish to Hex
```

## License

MIT License - see [LICENSE](LICENSE) for details.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linter
5. Submit a pull request

## Related Projects

- [Finch](https://github.com/finch/finch) - HTTP client used by Dox
- [DigitalOcean API Documentation](https://docs.digitalocean.com/reference/api/api-reference/) - Official API reference
