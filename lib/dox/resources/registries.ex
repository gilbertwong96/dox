defmodule Dox.Registries do
  @moduledoc """
  DigitalOcean Registries API client.

  ## Usage

    Dox.Registries.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Container Registries

  To get information about any container registry in your account, send a
  GET request to `/v2/registries`.

  ## Parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Registries.list(token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/registries", opts)
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
  Create Container Registry

  To create your container registry, send a POST request to `/v2/registries`.

  The `name` becomes part of the URL for images stored in the registry.
  For example, if your registry is called `example`, an image in it will have
  the URL `registry.digitalocean.com/example/image:tag`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `name`, `subscription_tier_slug`, `region`

  ## Examples

    Dox.Registries.create(name: "example", subscription_tier_slug: "basic", region: "fra1", token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/registries", opts)
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
  Get a Container Registry By Name

  To get information about any container registry in your account, send a
  GET request to `/v2/registries/{registry_name}`.

  ## Parameters
  - `registry_name` - The name of the registry (path parameter)
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Registries.get("example", token: "your_token")
  """
  def get(registry_name, opts \\ []) do
    Request.request(:get, "/v2/registries/#{registry_name}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(registry_name, opts \\ []) do
    case get(registry_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete Container Registry By Name

  To delete your container registry, destroying all container image data
  stored in it, send a DELETE request to `/v2/registries/{registry_name}`.

  ## Parameters
  - `registry_name` - The name of the registry (path parameter)
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Registries.delete("example", token: "your_token")
  """
  def delete(registry_name, opts \\ []) do
    Request.request(:delete, "/v2/registries/#{registry_name}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(registry_name, opts \\ []) do
    case delete(registry_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List All Container Registry Repositories (V2)

  To list all repositories in your container registry, send a GET request
  to `/v2/registries/{registry_name}/repositoriesV2`.

  This endpoint uses token-based pagination.

  ## Parameters
  - `registry_name` - The name of the registry (path parameter)
  - `opts` - Optional parameters including `token`, `page`, `per_page`, `page_size`, `page_token`

  ## Examples

    Dox.Registries.list_repositories("example", token: "your_token")
    Dox.Registries.list_repositories("example", page: 1, per_page: 10, token: "your_token")
  """
  def list_repositories(registry_name, opts \\ []) do
    Request.request(:get, "/v2/registries/#{registry_name}/repositories", opts)
  end

  @doc """
  Same as `list_repositories/2` but raises on error.
  """
  def list_repositories!(registry_name, opts \\ []) do
    case list_repositories(registry_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List All Container Registry Repository Tags

  To list all tags in one of your container registry's repository, send a GET
  request to `/v2/registries/{registry_name}/repositories/{repository_name}/tags`.

  Note that if your repository name contains `/` characters, it must be
  URL-encoded in the request URL. For example, to list tags for
  `registry.digitalocean.com/example/my/repo`, the path would be
  `/v2/registry/example/repositories/my%2Frepo/tags`.

  ## Parameters
  - `registry_name` - The name of the registry (path parameter)
  - `repository` - The name of the repository (path parameter)
  - `opts` - Optional parameters including `token`, `page`, `per_page`

  ## Examples

    Dox.Registries.list_tags("example", "repo-1", token: "your_token")
  """
  def list_tags(registry_name, repository, opts \\ []) do
    Request.request(:get, "/v2/registries/#{registry_name}/repositories/#{repository}/tags", opts)
  end

  @doc """
  Same as `list_tags/3` but raises on error.
  """
  def list_tags!(registry_name, repository, opts \\ []) do
    case list_tags(registry_name, repository, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get a Container Registry Repository Tag

  To get information about a specific tag in your container registry repository,
  send a GET request to `/v2/registries/{registry_name}/repositories/{repository_name}/tags/{repository_tag}`.

  Note that if your repository name contains `/` characters, it must be
  URL-encoded in the request URL.

  ## Parameters
  - `registry_name` - The name of the registry (path parameter)
  - `repository` - The name of the repository (path parameter)
  - `tag` - The name of the tag (path parameter)
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Registries.get_tag("example", "repo-1", "mytag", token: "your_token")
  """
  def get_tag(registry_name, repository, tag, opts \\ []) do
    Request.request(
      :get,
      "/v2/registries/#{registry_name}/repositories/#{repository}/tags/#{tag}",
      opts
    )
  end

  @doc """
  Same as `get_tag/4` but raises on error.
  """
  def get_tag!(registry_name, repository, tag, opts \\ []) do
    case get_tag(registry_name, repository, tag, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete Container Registry Repository Tag

  To delete a container repository tag in on of our container registries,
  send a DELETE request to
  `/v2/registries/{registry_name}/repositories/{repository_name}/tags/{repository_tag}`.

  Note that if your repository name contains `/` characters, it must be
  URL-encoded in the request URL. For example, to delete
  `registry.digitalocean.com/example/my/repo:mytag`, the path would be
  `/v2/registry/example/repositories/my%2Frepo/tags/mytag`.

  A successful request will receive a 204 status code with no body in response.

  ## Parameters
  - `registry_name` - The name of the registry (path parameter)
  - `repository` - The name of the repository (path parameter)
  - `tag` - The name of the tag (path parameter)
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Registries.delete_tag("example", "repo-1", "mytag", token: "your_token")
  """
  def delete_tag(registry_name, repository, tag, opts \\ []) do
    Request.request(
      :delete,
      "/v2/registries/#{registry_name}/repositories/#{repository}/tags/#{tag}",
      opts
    )
  end

  @doc """
  Same as `delete_tag/4` but raises on error.
  """
  def delete_tag!(registry_name, repository, tag, opts \\ []) do
    case delete_tag(registry_name, repository, tag, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get Docker Credentials By Registry Name

  In order to access your container registry with the Docker client or from a
  Kubernetes cluster, you will need to configure authentication. The necessary
  JSON configuration can be retrieved by sending a GET request to
  `/v2/registries/{registry_name}/docker-credentials`.

  The response will be in the format of a Docker `config.json` file.

  By default, the returned credentials have read-only access to your registry
  and cannot be used to push images. To retrieve read/write credentials,
  suitable for use with the Docker client or in a CI system, set the
  `read_write` query parameter to `true`.

  By default, the returned credentials will not expire. To retrieve credentials
  with an expiry set, use the `expiry_seconds` query parameter (e.g.,
  `expiry_seconds=3600` for credentials that expire after one hour).

  ## Parameters
  - `registry_name` - The name of the registry (path parameter)
  - `opts` - Optional parameters including `token`, `read_write`, `expiry_seconds`

  ## Examples

    Dox.Registries.docker_credentials("example", token: "your_token")
    Dox.Registries.docker_credentials("example", read_write: true, token: "your_token")
    Dox.Registries.docker_credentials("example", expiry_seconds: 3600, token: "your_token")
  """
  def docker_credentials(registry_name, opts \\ []) do
    Request.request(:get, "/v2/registries/#{registry_name}/docker-credentials", opts)
  end

  @doc """
  Same as `docker_credentials/2` but raises on error.
  """
  def docker_credentials!(registry_name, opts \\ []) do
    case docker_credentials(registry_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Validate a Container Registry Name

  To validate that a container registry name is available for use, send a POST
  request to `/v2/registries/validate-name`.

  If the name is both formatted correctly and available, the response code
  will be 204 and contain no body. If the name is already in use, the response
  will be a 409 Conflict.

  ## Parameters
  - `registry_name` - The name to validate (in request body as `name`)
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Registries.validate("example", token: "your_token")
  """
  def validate(registry_name, opts \\ []) do
    Request.request(:post, "/v2/registries/#{registry_name}/validate", opts)
  end

  @doc """
  Same as `validate/2` but raises on error.
  """
  def validate!(registry_name, opts \\ []) do
    case validate(registry_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
