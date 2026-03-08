defmodule Dox.Droplets do
  @moduledoc """
  DigitalOcean Droplets API client.

  ## Usage

    Dox.Droplets.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all Droplets in your account.

  ## Parameters
  - `opts` - Optional parameters including:
    - `tag_name` - Filter by a specific tag
    - `name` - Filter by exact Droplet name (case-insensitive)
    - `type` - Set to "gpus" to only return GPU Droplets
    - `page` - Page number for pagination
    - `per_page` - Number of items per page (default 25)

  ## Examples

    Dox.Droplets.list(token: "your_token")
    #=> {:ok, %Dox.Response{...}}

    Dox.Droplets.list(tag_name: "env:prod", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with a `droplets` array containing Droplet objects.
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/droplets", opts)
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
  Create a new Droplet.

  ## Parameters
  - `opts` - Optional parameters including:
    - `name` - The Droplet name (string) or `names` for multiple Droplets (array, max 10)
    - `region` - The region to create the Droplet in (e.g., "nyc1")
    - `size` - The size slug (e.g., "s-1vcpu-1gb")
    - `image` - The image ID or slug to use
    - `ssh_keys` - Array of SSH key IDs
    - `backups` - Boolean to enable backups
    - `ipv6` - Boolean to enable IPv6
    - `private_networking` - Boolean to enable private networking
    - `tags` - Array of tag strings

  ## Examples

    Dox.Droplets.create(name: "my-droplet", region: "nyc1", size: "s-1vcpu-1gb", image: "ubuntu-20-04-x64", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

    Dox.Droplets.create(names: ["web-01", "web-02"], region: "nyc1", size: "s-1vcpu-1gb", image: "ubuntu-20-04-x64", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the created Droplet object. Response code is 202 Accepted.
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/droplets", opts)
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
  Retrieve an existing Droplet by its ID.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Droplets.get(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the Droplet object containing standard attributes like id, name, region, size, status, etc.
  """
  def get(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(droplet_id, opts \\ []) do
    case get(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete an existing Droplet.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet to delete
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Droplets.delete(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with 204 status code and no body on success.
  """
  def delete(droplet_id, opts \\ []) do
    Request.request(:delete, "/v2/droplets/#{droplet_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(droplet_id, opts \\ []) do
    case delete(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List Neighbors for a Droplet.

  Retrieves Droplets that are co-located on the same physical hardware as the specified Droplet.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Droplets.neighbors(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with a `droplets` array containing neighbor Droplet objects. Empty array if no neighbors.
  """
  def neighbors(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}/neighbors", opts)
  end

  @doc """
  Same as `neighbors/2` but raises on error.
  """
  def neighbors!(droplet_id, opts \\ []) do
    case neighbors(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List Backups for a Droplet.

  Retrieves any backups associated with a Droplet.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including:
    - `page` - Page number for pagination
    - `per_page` - Number of items per page

  ## Examples

    Dox.Droplets.backups(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with a `backups` array containing backup objects with standard Droplet backup attributes.
  """
  def backups(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}/backups", opts)
  end

  @doc """
  Same as `backups/2` but raises on error.
  """
  def backups!(droplet_id, opts \\ []) do
    case backups(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List Snapshots for a Droplet.

  Retrieves snapshots that have been created from a Droplet.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including:
    - `page` - Page number for pagination
    - `per_page` - Number of items per page

  ## Examples

    Dox.Droplets.snapshots(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with a `snapshots` array containing snapshot objects with standard Droplet snapshot attributes.
  """
  def snapshots(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}/snapshots", opts)
  end

  @doc """
  Same as `snapshots/2` but raises on error.
  """
  def snapshots!(droplet_id, opts \\ []) do
    case snapshots(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List Actions for a Droplet.

  Retrieves all actions that have been executed for a Droplet.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including:
    - `page` - Page number for pagination
    - `per_page` - Number of items per page

  ## Examples

    Dox.Droplets.actions(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with an `actions` array containing action objects with standard action attributes.
  """
  def actions(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}/actions", opts)
  end

  @doc """
  Same as `actions/2` but raises on error.
  """
  def actions!(droplet_id, opts \\ []) do
    case actions(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Initiate a Droplet Action.

  Initiates an action on a Droplet such as reboot, shutdown, power cycle, etc.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including:
    - `type` - The action type (enable_backups, disable_backups, reboot, power_cycle, shutdown, power_off, power_on, resize, etc.)
    - Additional parameters depend on the action type (e.g., `size` for resize)

  ## Examples

    Dox.Droplets.action(3164494, type: "reboot", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

    Dox.Droplets.action(3164494, type: "power_off", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

    Dox.Droplets.action(3164494, type: "resize", size: "s-2vcpu-2gb", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the action object. Use the action ID to check status via the actions endpoint.
  """
  def action(droplet_id, opts \\ []) do
    Request.request(:post, "/v2/droplets/#{droplet_id}/actions", opts)
  end

  @doc """
  Same as `action/2` but raises on error.
  """
  def action!(droplet_id, opts \\ []) do
    case action(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List All Available Kernels for a Droplet.

  Retrieves all kernels available to a Droplet.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including:
    - `page` - Page number for pagination
    - `per_page` - Number of items per page

  ## Examples

    Dox.Droplets.kernels(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with a `kernels` array containing kernel objects with standard kernel attributes.
  """
  def kernels(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}/kernels", opts)
  end

  @doc """
  Same as `kernels/2` but raises on error.
  """
  def kernels!(droplet_id, opts \\ []) do
    case kernels(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all Firewalls Applied to a Droplet.

  Retrieves all firewalls available to a Droplet.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including:
    - `page` - Page number for pagination
    - `per_page` - Number of items per page

  ## Examples

    Dox.Droplets.firewalls(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with a `firewalls` array containing firewall objects with standard firewall attributes.
  """
  def firewalls(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}/firewalls", opts)
  end

  @doc """
  Same as `firewalls/2` but raises on error.
  """
  def firewalls!(droplet_id, opts \\ []) do
    case firewalls(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Add a Firewall to a Droplet.

  Assigns a firewall to a Droplet by adding the Droplet to a firewall.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including:
    - `firewall_id` - The ID of the firewall to add the Droplet to (passed in the request body as `droplet_ids`)

  ## Examples

    Dox.Droplets.add_firewall(3164494, firewall_id: "bb4b2611-3d72-467b-8602-280330ecd65c", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the updated firewall object.
  """
  def add_firewall(droplet_id, opts \\ []) do
    Request.request(:post, "/v2/droplets/#{droplet_id}/firewalls", opts)
  end

  @doc """
  Same as `add_firewall/2` but raises on error.
  """
  def add_firewall!(droplet_id, opts \\ []) do
    case add_firewall(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get Droplet metrics.

  Retrieves monitoring metrics for a Droplet. This endpoint provides access to various performance metrics.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including:
    - `start` - Start time for metrics (ISO 8601 format)
    - `end` - End time for metrics (ISO 8601 format)

  ## Examples

    Dox.Droplets.metrics(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with metrics data including CPU, memory, disk, and network statistics.
  """
  def metrics(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}/metrics", opts)
  end

  @doc """
  Same as `metrics/2` but raises on error.
  """
  def metrics!(droplet_id, opts \\ []) do
    case metrics(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete Droplets by tag.

  Deletes all Droplets that match the specified tag.

  ## Parameters
  - `tag_name` - The tag name to filter Droplets for deletion
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Droplets.delete_by_tag("env:test", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with 204 status code on success.
  """
  def delete_by_tag(tag_name, opts \\ []) do
    Request.request(:delete, "/v2/droplets",
      opts: Keyword.put(opts, :params, %{tag_name: tag_name})
    )
  end

  @doc """
  Same as `delete_by_tag/2` but raises on error.
  """
  def delete_by_tag!(tag_name, opts \\ []) do
    case delete_by_tag(tag_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all Droplet IDs (including neighbors).

  Retrieves all Droplets in your account with pagination set to 200 per page to get all Droplets in a single request.

  ## Parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Droplets.list_all(token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with a `droplets` array containing all Droplet objects in your account.
  """
  def list_all(opts \\ []) do
    Request.request(:get, "/v2/droplets", Keyword.put(opts, :params, %{per_page: 200}))
  end

  @doc """
  Same as `list_all/1` but raises on error.
  """
  def list_all!(opts \\ []) do
    case list_all(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List Droplet Neighbor IDs.

  Retrieves IDs of Droplets that are co-located on the same physical hardware. Pagination set to 200 per page.

  ## Parameters
  - `droplet_id` - The unique identifier for the Droplet
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Droplets.neighbor_ids(3164494, token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with a `droplets` array containing neighbor Droplet objects.
  """
  def neighbor_ids(droplet_id, opts \\ []) do
    Request.request(:get, "/v2/droplets/#{droplet_id}/neighbors",
      opts: Keyword.put(opts, :params, %{per_page: 200})
    )
  end

  @doc """
  Same as `neighbor_ids/2` but raises on error.
  """
  def neighbor_ids!(droplet_id, opts \\ []) do
    case neighbor_ids(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create Droplets by tag.

  Creates new Droplets for all Droplets matching the specified tag. This is useful for creating multiple Droplets with the same configuration.

  ## Parameters
  - `tag_name` - The tag name to match Droplets for creation
  - `opts` - Optional parameters including:
    - `name` - Name for the new Droplet(s)
    - `region` - The region to create the Droplet in
    - `size` - The size slug
    - `image` - The image ID or slug
    - `ssh_keys` - Array of SSH key IDs

  ## Examples

    Dox.Droplets.create_by_tag("web-servers", name: "new-server", region: "nyc1", size: "s-1vcpu-1gb", image: "ubuntu-20-04-x64", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the created Droplet objects. Response code is 202 Accepted.
  """
  def create_by_tag(tag_name, opts \\ []) do
    Request.request(:post, "/v2/droplets",
      opts: Keyword.put(opts, :params, %{tag_name: tag_name})
    )
  end

  @doc """
  Same as `create_by_tag/2` but raises on error.
  """
  def create_by_tag!(tag_name, opts \\ []) do
    case create_by_tag(tag_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
