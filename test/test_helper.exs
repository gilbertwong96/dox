ExUnit.start()

# Create a simple mock client module for testing
defmodule Dox.ClientMock do
  alias Dox.Response

  def request(_method, _path, _opts \\ []) do
    {:ok, Response.new(%{"data" => []}, [], 200)}
  end

  def request!(method, path, opts \\ []) do
    {:ok, response} = request(method, path, opts)
    response
  end

  def get(path, opts \\ []), do: request(:get, path, opts)
  def get!(path, opts \\ []), do: request!(:get, path, opts)
  def post(path, opts \\ []), do: request(:post, path, opts)
  def post!(path, opts \\ []), do: request!(:post, path, opts)
  def put(path, opts \\ []), do: request(:put, path, opts)
  def put!(path, opts \\ []), do: request!(:put, path, opts)
  def patch(path, opts \\ []), do: request(:patch, path, opts)
  def patch!(path, opts \\ []), do: request!(:patch, path, opts)
  def delete(path, opts \\ []), do: request(:delete, path, opts)
  def delete!(path, opts \\ []), do: request!(:delete, path, opts)
end

# Set the HTTP client to use the mock in test environment
Application.put_env(:dox, :http_client, Dox.ClientMock)
