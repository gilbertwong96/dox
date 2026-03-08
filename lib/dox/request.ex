defmodule Dox.Request do
  @moduledoc """
  Helper module for making HTTP requests.

  Delegates to the HTTP client configured in the application environment,
  allowing for easy mocking in tests.

  Plugins are executed before each request to modify the request options.
  """

  @doc """
  Makes an HTTP request using the configured HTTP client.

  This function reads the HTTP client from application env and delegates
  the request to it, enabling dependency injection for testing.

  Before making the request, all registered plugins have their
  `before_request/2` callback called to modify the request options.
  """
  def request(method, path, opts \\ []) do
    opts = run_plugins(method, path, opts)
    Dox.Client.http_client().request(method, path, opts)
  end

  @doc """
  Makes an HTTP request and raises on error.
  """
  def request!(method, path, opts \\ []) do
    opts = run_plugins(method, path, opts)
    Dox.Client.http_client().request!(method, path, opts)
  end

  # Run all plugins before_request callbacks
  defp run_plugins(_method, _path, opts) do
    plugins = Dox.plugins()

    Enum.reduce(plugins, opts, fn {module, state}, acc_opts ->
      request_struct = %Dox.RequestStruct{opts: acc_opts}
      {modified_struct, _new_state} = module.before_request(request_struct, state)

      # Use modified opts from plugin, but preserve original if plugin didn't modify
      case modified_struct.opts do
        [] -> acc_opts
        modified_opts -> Keyword.merge(acc_opts, modified_opts)
      end
    end)
  end
end
