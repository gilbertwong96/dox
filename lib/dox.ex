defmodule Dox do
  @moduledoc """
  DigitalOcean API client library.

  ## Installation

  Add `dox` to your dependencies in `mix.exs`:

      {:dox, "~> 0.1.0"}

  ## Usage

  Pass your API token directly to resource functions:

      # List all droplets
      {:ok, response} = Dox.Droplets.list(token: "your_api_token")

      # Get a specific droplet
      {:ok, response} = Dox.Droplets.get(droplet_id, token: "your_api_token")

      # Or use bang versions that raise on error
      response = Dox.Droplets.list!(token: "your_api_token")

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
end
