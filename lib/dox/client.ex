defmodule Dox.Client do
  @moduledoc """
  Main client for DigitalOcean API.

  ## Usage

      # Pass token directly to resource functions
      Dox.Droplets.list(token: "your_api_token")
  """

  @base_url "https://api.digitalocean.com"

  @doc """
  Returns the HTTP client module to use for API requests.
  Can be overridden via application env for testing.
  """
  def http_client, do: Application.get_env(:dox, :http_client, __MODULE__)

  @doc """
  Makes an HTTP request to the DigitalOcean API.
  """
  def request(method, path, opts \\ []) do
    token = Keyword.get(opts, :token) || raise_token_error()
    params = Keyword.get(opts, :params, %{})
    body = Keyword.get(opts, :body)

    url = build_url(path, params)

    headers = [
      {"authorization", "Bearer #{token}"},
      {"content-type", "application/json"},
      {"accept", "application/json"}
    ]

    # Encode body to JSON if present
    encoded_body = if body, do: JSON.encode!(body), else: nil

    finch_opts = [
      receive_timeout: Keyword.get(opts, :receive_timeout, 30_000),
      pool_timeout: Keyword.get(opts, :connect_timeout, 10_000)
    ]

    # Build the request with method, url, headers, and body
    request = Finch.build(method, url, headers, encoded_body)

    # Execute the request with timeout options
    case Finch.request(request, Dox.Finch, finch_opts) do
      {:ok, %{status: status, headers: headers, body: body}} ->
        # Decode JSON response
        decoded_body =
          case JSON.decode(body) do
            {:ok, map} -> map
            _ -> body
          end

        headers_list = for {k, v} <- headers, do: {k, v}
        handle_response(status, decoded_body, headers_list)

      {:error, reason} ->
        {:error, Dox.Error.from_status(0, reason)}
    end
  end

  @doc """
  Makes an HTTP request and raises on error.
  """
  def request!(method, path, opts \\ []) do
    case request(method, path, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  # GET request
  def get(path, opts \\ []), do: request(:get, path, opts)
  def get!(path, opts \\ []), do: request!(:get, path, opts)

  # POST request
  def post(path, opts \\ []), do: request(:post, path, opts)
  def post!(path, opts \\ []), do: request!(:post, path, opts)

  # PUT request
  def put(path, opts \\ []), do: request(:put, path, opts)
  def put!(path, opts \\ []), do: request!(:put, path, opts)

  # PATCH request
  def patch(path, opts \\ []), do: request(:patch, path, opts)
  def patch!(path, opts \\ []), do: request!(:patch, path, opts)

  # DELETE request
  def delete(path, opts \\ []), do: request(:delete, path, opts)
  def delete!(path, opts \\ []), do: request!(:delete, path, opts)

  # Private helpers

  defp build_url(path, params) do
    query_string = URI.encode_query(params)

    if query_string == "" do
      "#{@base_url}#{path}"
    else
      "#{@base_url}#{path}?#{query_string}"
    end
  end

  defp handle_response(status, body, headers) when status >= 200 and status < 300 do
    {:ok, Dox.Response.new(body, headers, status)}
  end

  defp handle_response(status, body, _headers) do
    error =
      case body do
        %{"error" => _} ->
          Dox.Error.from_response(body)

        %{"errors" => _} ->
          Dox.Error.from_response(body)

        %{"id" => _, "message" => _} ->
          Dox.Error.from_response(body)

        _ ->
          Dox.Error.new("Request failed", status_code: status, response: body, reason: :api_error)
      end

    {:error, Map.put(error, :status_code, status)}
  end

  defp raise_token_error do
    raise """
    No API token provided. Pass token directly to the function:

        Dox.Droplets.list(token: "your_token")
    """
  end
end
