defmodule Dox.Request do
  @moduledoc """
  Helper module for making HTTP requests.

  Delegates to the HTTP client configured in the application environment,
  allowing for easy mocking in tests.
  """

  @doc """
  Makes an HTTP request using the configured HTTP client.

  This function reads the HTTP client from application env and delegates
  the request to it, enabling dependency injection for testing.
  """
  def request(method, path, opts \\ []) do
    Dox.Client.http_client().request(method, path, opts)
  end

  @doc """
  Makes an HTTP request and raises on error.
  """
  def request!(method, path, opts \\ []) do
    Dox.Client.http_client().request!(method, path, opts)
  end
end
