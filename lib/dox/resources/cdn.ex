defmodule Dox.Cdn do
  @moduledoc """
  DigitalOcean Cdn API client.

  ## Usage

    Dox.Cdn.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All CDN Endpoints

  To list all of the CDN endpoints available on your account, send a GET
  request to `/v2/cdn/endpoints`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `per_page`, `page`

  ## Examples

    Dox.Cdn.list(token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/cdn/endpoints", opts)
  end

  @doc """
  Same as `list/1` but raises on error.
  """
  def list!(opts \\ []) do
    case list(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create a New CDN Endpoint

  To create a new CDN endpoint, send a POST request to `/v2/cdn/endpoints`.
  The origin attribute must be set to the fully qualified domain name (FQDN)
  of a DigitalOcean Space. Optionally, the TTL may be configured by setting
  the `ttl` attribute.

  A custom subdomain may be configured by specifying the `custom_domain` and
  `certificate_id` attributes.

  ## Parameters
  - `opts` - Optional parameters including `token`, `origin`, `ttl`, `certificate_id`, `custom_domain`

  ## Examples

    Dox.Cdn.create(token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/cdn/endpoints", opts)
  end

  @doc """
  Same as `create/1` but raises on error.
  """
  def create!(opts \\ []) do
    case create(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an Existing CDN Endpoint

  To show information about an existing CDN endpoint, send a GET request to
  `/v2/cdn/endpoints/$ENDPOINT_ID`.

  ## Parameters
  - `cdn_id` - The unique identifier for the CDN endpoint.
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Cdn.get(cdn_id, token: "your_token")
  """
  def get(cdn_id, opts \\ []) do
    Request.request(:get, "/v2/cdn/endpoints/#{cdn_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(cdn_id, opts \\ []) do
    case get(cdn_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update a CDN Endpoint

  To update the TTL, certificate ID, or the FQDN of the custom subdomain for
  an existing CDN endpoint, send a PUT request to
  `/v2/cdn/endpoints/$ENDPOINT_ID`.

  ## Parameters
  - `cdn_id` - The unique identifier for the CDN endpoint.
  - `opts` - Optional parameters including `token`, `ttl`, `certificate_id`, `custom_domain`

  ## Examples

    Dox.Cdn.update(cdn_id, token: "your_token")
  """
  def update(cdn_id, opts \\ []) do
    Request.request(:put, "/v2/cdn/endpoints/#{cdn_id}", opts)
  end

  @doc """
  Same as `update/2` but raises on error.
  """
  def update!(cdn_id, opts \\ []) do
    case update(cdn_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a CDN Endpoint

  To delete a specific CDN endpoint, send a DELETE request to
  `/v2/cdn/endpoints/$ENDPOINT_ID`.

  A status of 204 will be given. This indicates that the request was processed
  successfully, but that no response body is needed.

  ## Parameters
  - `cdn_id` - The unique identifier for the CDN endpoint.
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Cdn.delete(cdn_id, token: "your_token")
  """
  def delete(cdn_id, opts \\ []) do
    Request.request(:delete, "/v2/cdn/endpoints/#{cdn_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(cdn_id, opts \\ []) do
    case delete(cdn_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Purge the Cache for an Existing CDN Endpoint

  To purge cached content from a CDN endpoint, send a DELETE request to
  `/v2/cdn/endpoints/$ENDPOINT_ID/cache`. The body of the request should
  include a `files` attribute containing a list of cached file paths to be purged.
  A path may be for a single file or may contain a wildcard (`*`) to recursively
  purge all files under a directory. When only a wildcard is provided, all cached
  files will be purged.

  There is a rate limit of 50 files per 20 seconds that can be purged. CDN
  endpoints have a rate limit of 5 requests per 10 seconds.

  ## Parameters
  - `cdn_id` - The unique identifier for the CDN endpoint.
  - `opts` - Optional parameters including `token`, `files` (list of file paths to purge)

  ## Examples

    Dox.Cdn.purge_cache(cdn_id, token: "your_token")
  """
  def purge_cache(cdn_id, opts \\ []) do
    Request.request(:delete, "/v2/cdn/endpoints/#{cdn_id}/cache", opts)
  end

  @doc """
  Same as `purge_cache/2` but raises on error.
  """
  def purge_cache!(cdn_id, opts \\ []) do
    case purge_cache(cdn_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
