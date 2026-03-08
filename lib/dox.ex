defmodule Dox do
  @moduledoc """
  DigitalOcean API client library.

  ## Installation

  Add `dox` to your dependencies in `mix.exs`:

      {:dox, "~> 0.1.0"}

  ## Usage

  There are two ways to authenticate with the DigitalOcean API:

  ### Option 1: Config-based (Recommended)

  Set your API token in your application config:

      # config/config.exs
      config :dox, api_token: "your_api_token"

  Then use resource functions without passing the token:

      Dox.Droplets.list()
      Dox.Droplets.get(droplet_id)

  ### Option 2: Per-request token

  Pass your API token directly to resource functions:

      # List all droplets
      {:ok, response} = Dox.Droplets.list(token: "your_api_token")

      # Get a specific droplet
      {:ok, response} = Dox.Droplets.get(droplet_id, token: "your_api_token")

      # Or use bang versions that raise on error
      response = Dox.Droplets.list!(token: "your_api_token")

  ## Plugins

  Dox supports plugins that can modify request behavior. Plugins are
  called in order before each request.

      # Add a custom plugin
      Dox.add_plugin(MyPlugin)

  ## Resources

  The following API resources are available:

  - `Dox.Account` - Account and SSH keys
  - `Dox.Actions` - Actions
  - `Dox.Apps` - App Platform
  - `Dox.Cdn` - CDN endpoints
  - `Dox.Certificates` - SSL certificates
  - `Dox.Databases` - Managed databases
  - `Dox.Domains` - DNS domains
  - `Dox.Droplets` - Droplets
  - `Dox.Firewalls` - Firewalls
  - `Dox.FloatingIps` - Floating IPs
  - `Dox.Images` - Images
  - `Dox.Kubernetes` - Kubernetes clusters
  - `Dox.LoadBalancers` - Load balancers
  - `Dox.OneClicks` - 1-Click apps
  - `Dox.Projects` - Projects
  - `Dox.Regions` - Regions
  - `Dox.Registries` - Container registries
  - `Dox.ReservedIps` - Reserved IPs
  - `Dox.Sizes` - Sizes
  - `Dox.Snapshots` - Snapshots
  - `Dox.Tags` - Tags
  - `Dox.Volumes` - Block storage volumes
  - `Dox.Vpcs` - VPCs

  ## Error Handling

  Each function has two variants:
  - `Dox.Resource.function/1` - Returns `{:ok, response}` or `{:error, error}`
  - `Dox.Resource.function!/1` - Returns response or raises `Dox.Error`
  """

  # Default plugins loaded at compile time
  @default_plugins [Dox.Plugin.TokenInjector]

  @doc """
  Returns the list of registered plugins with their state.

  Plugins are initialized lazily on first call and cached in process dictionary.
  """
  @spec plugins() :: [{module(), term()}]
  def plugins do
    Process.get({:dox, :plugins}) || init_plugins()
  end

  defp init_plugins do
    # Get plugins from app config at runtime
    plugins =
      case Application.get_env(:dox, :plugins) do
        nil -> @default_plugins
        list when is_list(list) -> list
        _ -> @default_plugins
      end
      |> Enum.map(fn module ->
        {:ok, state} = module.init([])
        {module, state}
      end)

    Process.put({:dox, :plugins}, plugins)
    plugins
  end

  @doc """
  Adds a plugin to the registry.

  ## Examples

      Dox.add_plugin(Dox.Plugin.TokenInjector)
  """
  @spec add_plugin(module()) :: :ok
  def add_plugin(module) do
    {:ok, state} = module.init([])
    current = Process.get({:dox, :plugins}) || []
    Process.put({:dox, :plugins}, [{module, state} | current])
    :ok
  end
end
