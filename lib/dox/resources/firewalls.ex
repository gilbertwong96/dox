defmodule Dox.Firewalls do
  @moduledoc """
  DigitalOcean Firewalls API client.

  ## Usage

    Dox.Firewalls.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Firewalls

  To list all of the firewalls available on your account, send a GET
  request to `/v2/firewalls`.

  ## Parameters
  - `opts` - Optional parameters including:
    - `per_page` - Number of items to return per page (default: 20)
    - `page` - Which page to return (default: 1)
    - `token` - API token

  ## Examples

    Dox.Firewalls.list(token: "your_token")
    Dox.Firewalls.list(per_page: 50, page: 1, token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/firewalls", opts)
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
  Create a New Firewall

  To create a new firewall, send a POST request to `/v2/firewalls`. The
  request must contain at least one inbound or outbound access rule.

  ## Parameters
  - `opts` - Optional parameters including:
    - `name` - (required) A name for the firewall
    - `inbound_rules` - (optional) Array of inbound access rules
    - `outbound_rules` - (optional) Array of outbound access rules
    - `droplet_ids` - (optional) Array of droplet IDs to apply the firewall to
    - `tags` - (optional) Array of tag names to apply the firewall to
    - `token` - API token

  ## Examples

    Dox.Firewalls.create(name: "firewall", inbound_rules: [%{protocol: "tcp", ports: "80", sources: %{load_balancer_uids: ["4de7ac8b-495b-4884-9a69-1050c6793cd6"]}}], token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/firewalls", opts)
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
  Retrieve an Existing Firewall

  To show information about an existing firewall, send a GET request to
  `/v2/firewalls/$FIREWALL_ID`.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Firewalls.get("bb4b2611-3d72-467b-8602-280330ecd65c", token: "your_token")
  """
  def get(firewall_id, opts \\ []) do
    Request.request(:get, "/v2/firewalls/#{firewall_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(firewall_id, opts \\ []) do
    case get(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update a Firewall

  To update the configuration of an existing firewall, send a PUT request to
  `/v2/firewalls/$FIREWALL_ID`. The request should contain a full
  representation of the firewall including existing attributes. Note that any
  attributes that are not provided will be reset to their default values.

  You must have read access (e.g. `droplet:read`) to all resources attached
  to the firewall to successfully update the firewall.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including:
    - `name` - A name for the firewall
    - `inbound_rules` - Array of inbound access rules
    - `outbound_rules` - Array of outbound access rules
    - `droplet_ids` - Array of droplet IDs to apply the firewall to
    - `tags` - Array of tag names to apply the firewall to
    - `token` - API token

  ## Examples

    Dox.Firewalls.update("bb4b2611-3d72-467b-8602-280330ecd65c", name: "frontend-firewall", token: "your_token")
  """
  def update(firewall_id, opts \\ []) do
    Request.request(:put, "/v2/firewalls/#{firewall_id}", opts)
  end

  @doc """
  Same as `update/2` but raises on error.
  """
  def update!(firewall_id, opts \\ []) do
    case update(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a Firewall

  To delete a firewall send a DELETE request to `/v2/firewalls/$FIREWALL_ID`.

  No response body will be sent back, but the response code will indicate
  success. Specifically, the response code will be a 204, which means that
  the action was successful with no returned body data.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Firewalls.delete("bb4b2611-3d72-467b-8602-280330ecd65c", token: "your_token")
  """
  def delete(firewall_id, opts \\ []) do
    Request.request(:delete, "/v2/firewalls/#{firewall_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(firewall_id, opts \\ []) do
    case delete(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List Droplets Assigned to a Firewall

  To list all of the Droplets assigned to a firewall, send a GET request to
  `/v2/firewalls/$FIREWALL_ID/droplets`.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Firewalls.droplets("bb4b2611-3d72-467b-8602-280330ecd65c", token: "your_token")
  """
  def droplets(firewall_id, opts \\ []) do
    Request.request(:get, "/v2/firewalls/#{firewall_id}/droplets", opts)
  end

  @doc """
  Same as `droplets/2` but raises on error.
  """
  def droplets!(firewall_id, opts \\ []) do
    case droplets(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Add Droplets to a Firewall

  To assign a Droplet to a firewall, send a POST request to
  `/v2/firewalls/$FIREWALL_ID/droplets`. In the body of the request, there
  should be a `droplet_ids` attribute containing a list of Droplet IDs.

  No response body will be sent back, but the response code will indicate
  success. Specifically, the response code will be a 204, which means that
  the action was successful with no returned body data.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including:
    - `droplet_ids` - (required) Array of Droplet IDs to assign to the firewall
    - `token` - API token

  ## Examples

    Dox.Firewalls.add_droplets("bb4b2611-3d72-467b-8602-280330ecd65c", droplet_ids: [49696269], token: "your_token")
  """
  def add_droplets(firewall_id, opts \\ []) do
    Request.request(:post, "/v2/firewalls/#{firewall_id}/droplets", opts)
  end

  @doc """
  Same as `add_droplets/2` but raises on error.
  """
  def add_droplets!(firewall_id, opts \\ []) do
    case add_droplets(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Remove Droplets from a Firewall

  To remove a Droplet from a firewall, send a DELETE request to
  `/v2/firewalls/$FIREWALL_ID/droplets`. In the body of the request, there
  should be a `droplet_ids` attribute containing a list of Droplet IDs.

  No response body will be sent back, but the response code will indicate
  success. Specifically, the response code will be a 204, which means that
  the action was successful with no returned body data.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including:
    - `droplet_ids` - (required) Array of Droplet IDs to remove from the firewall
    - `token` - API token

  ## Examples

    Dox.Firewalls.remove_droplets("bb4b2611-3d72-467b-8602-280330ecd65c", droplet_ids: [49696269], token: "your_token")
  """
  def remove_droplets(firewall_id, opts \\ []) do
    Request.request(:delete, "/v2/firewalls/#{firewall_id}/droplets", opts)
  end

  @doc """
  Same as `remove_droplets/2` but raises on error.
  """
  def remove_droplets!(firewall_id, opts \\ []) do
    case remove_droplets(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List Tags Assigned to a Firewall

  To list all of the Tags assigned to a firewall, send a GET request to
  `/v2/firewalls/$FIREWALL_ID/tags`.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Firewalls.tags("bb4b2611-3d72-467b-8602-280330ecd65c", token: "your_token")
  """
  def tags(firewall_id, opts \\ []) do
    Request.request(:get, "/v2/firewalls/#{firewall_id}/tags", opts)
  end

  @doc """
  Same as `tags/2` but raises on error.
  """
  def tags!(firewall_id, opts \\ []) do
    case tags(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Add Tags to a Firewall

  To assign a tag representing a group of Droplets to a firewall, send a POST
  request to `/v2/firewalls/$FIREWALL_ID/tags`. In the body of the request,
  there should be a `tags` attribute containing a list of tag names.

  No response body will be sent back, but the response code will indicate
  success. Specifically, the response code will be a 204, which means that
  the action was successful with no returned body data.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including:
    - `tags` - (required) Array of tag names to assign to the firewall
    - `token` - API token

  ## Examples

    Dox.Firewalls.add_tags("bb4b2611-3d72-467b-8602-280330ecd65c", tags: ["frontend"], token: "your_token")
  """
  def add_tags(firewall_id, opts \\ []) do
    Request.request(:post, "/v2/firewalls/#{firewall_id}/tags", opts)
  end

  @doc """
  Same as `add_tags/2` but raises on error.
  """
  def add_tags!(firewall_id, opts \\ []) do
    case add_tags(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Remove Tags from a Firewall

  To remove a tag representing a group of Droplets from a firewall, send a
  DELETE request to `/v2/firewalls/$FIREWALL_ID/tags`. In the body of the
  request, there should be a `tags` attribute containing a list of tag names.

  No response body will be sent back, but the response code will indicate
  success. Specifically, the response code will be a 204, which means that
  the action was successful with no returned body data.

  ## Parameters
  - `firewall_id` - The unique identifier of the firewall
  - `opts` - Optional parameters including:
    - `tags` - (required) Array of tag names to remove from the firewall
    - `token` - API token

  ## Examples

    Dox.Firewalls.remove_tags("bb4b2611-3d72-467b-8602-280330ecd65c", tags: ["frontend"], token: "your_token")
  """
  def remove_tags(firewall_id, opts \\ []) do
    Request.request(:delete, "/v2/firewalls/#{firewall_id}/tags", opts)
  end

  @doc """
  Same as `remove_tags/2` but raises on error.
  """
  def remove_tags!(firewall_id, opts \\ []) do
    case remove_tags(firewall_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
