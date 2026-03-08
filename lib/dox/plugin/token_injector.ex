defmodule Dox.Plugin.TokenInjector do
  @moduledoc """
  Plugin that automatically injects the API token from application config.

  This plugin reads the token from `:dox, :api_token` config and injects it
  into the request options if not already present.

  ## Configuration

  Add to your `config/config.exs`:

      config :dox,
        api_token: "your_digitalocean_api_token"

  ## Usage

  The TokenInjector is automatically loaded when Dox starts. Once configured,
  you can make API calls without passing the token:

      Dox.Droplets.list()
      Dox.Droplets.get(droplet_id)

  You can still override the token per-request if needed:

      Dox.Droplets.list(token: "different_token")
  """

  use Dox.Plugin

  @impl true
  def init(opts) do
    {:ok, opts}
  end

  @impl true
  def before_request(request, state) do
    # Get token from config if not already in opts
    token = Application.get_env(:dox, :api_token)

    # Only inject if token is configured and not already present in opts
    new_opts =
      if token && !Keyword.get(request.opts, :token) do
        Keyword.put(request.opts, :token, token)
      else
        request.opts
      end

    {%{request | opts: new_opts}, state}
  end
end
