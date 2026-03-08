defmodule Dox.Volumes do
  @moduledoc """
  DigitalOcean Volumes API client.

  ## Usage

    Dox.Volumes.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all block storage volumes.

  To list all of the block storage volumes available on your account, send a GET
  request to `/v2/volumes`.

  ## Filtering Results

  ### By Region
  The `region` may be provided as query parameter in order to restrict results
  to volumes available in a specific region. For example:
  `/v2/volumes?region=nyc1`

  ### By Name
  It is also possible to list volumes on your account that match a specified name.
  To do so, send a GET request with the volume's name as a query parameter to
  `/v2/volumes?name=$VOLUME_NAME`.

  **Note:** You can only create one volume per region with the same name.

  ### By Name and Region
  It is also possible to retrieve information about a block storage volume by name.
  To do so, send a GET request with the volume's name and the region slug for
  the region it is located in as query parameters to
  `/v2/volumes?name=$VOLUME_NAME&region=nyc1`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `per_page`, `page`, `region`, and `name`

  ## Examples

    # List all volumes
    Dox.Volumes.list(token: "your_token")

    # List volumes in a specific region
    Dox.Volumes.list(token: "your_token", region: "nyc1")

    # List volumes filtered by name
    Dox.Volumes.list(token: "your_token", name: "example")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/volumes", opts)
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
  Create a new block storage volume.

  To create a new volume, send a POST request to `/v2/volumes`. Optionally, a
  `filesystem_type` attribute may be provided in order to automatically format
  the volume's filesystem. Pre-formatted volumes are automatically mounted when
  attached to Ubuntu, Debian, Fedora, Fedora Atomic, and CentOS Droplets created
  on or after April 26, 2018. Attaching pre-formatted volumes to Droplets without
  support for auto-mounting is not recommended.

  ## Parameters
  - `opts` - Optional parameters including `token`, `size_gigabytes`, `name`,
    `description`, `region`, `filesystem_type`, `filesystem_label`, `snapshot_id`

  ## Examples

    # Create an ext4 volume
    Dox.Volumes.create(token: "your_token", size_gigabytes: 10, name: "example",
      description: "Block store for examples", region: "nyc1", filesystem_type: "ext4")

    # Create a volume from a snapshot
    Dox.Volumes.create(token: "your_token", size_gigabytes: 10, name: "snapshot_example",
      snapshot_id: "b0798135-fb76-11eb-946a-0a58ac146f33", region: "nyc1")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/volumes", opts)
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
  Retrieve an existing block storage volume.

  To show information about a block storage volume, send a GET request to
  `/v2/volumes/$VOLUME_ID`.

  ## Parameters
  - `volume_id` - The ID of the volume to retrieve
  - `opts` - Optional parameters including `token`

  ## Examples

    # Retrieve an existing volume by ID
    Dox.Volumes.get("7724db7c-e098-11e5-b522-000f53304e51", token: "your_token")

    # Retrieve an existing volume by name
    Dox.Volumes.get("example", token: "your_token", region: "nyc1")
  """
  def get(volume_id, opts \\ []) do
    Request.request(:get, "/v2/volumes/#{volume_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(volume_id, opts \\ []) do
    case get(volume_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a block storage volume.

  To delete a block storage volume, destroying all data and removing it from
  your account, send a DELETE request to `/v2/volumes/$VOLUME_ID`.

  No response body will be sent back, but the response code will indicate success.
  Specifically, the response code will be a 204, which means that the action was
  successful with no returned body data.

  Block storage volumes may also be deleted by name by sending a DELETE request
  with the volume's **name** and the **region slug** for the region it is located
  in as query parameters to `/v2/volumes?name=$VOLUME_NAME&region=nyc1`.

  ## Parameters
  - `volume_id` - The ID of the volume to delete (or name if using name-based deletion)
  - `opts` - Optional parameters including `token`, `region` (required for name-based deletion)

  ## Examples

    # Delete a volume by ID
    Dox.Volumes.delete("7724db7c-e098-11e5-b522-000f53304e51", token: "your_token")

    # Delete a volume by name
    Dox.Volumes.delete("example", token: "your_token", region: "nyc1")
  """
  def delete(volume_id, opts \\ []) do
    Request.request(:delete, "/v2/volumes/#{volume_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(volume_id, opts \\ []) do
    case delete(volume_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all actions for a volume.

  To retrieve all actions that have been executed on a volume, send a GET request
  to `/v2/volumes/$VOLUME_ID/actions`.

  ## Parameters
  - `volume_id` - The ID of the volume
  - `opts` - Optional parameters including `token`, `per_page`, `page`

  ## Examples

    Dox.Volumes.actions("7724db7c-e098-11e5-b522-000f53304e51", token: "your_token")
  """
  def actions(volume_id, opts \\ []) do
    Request.request(:get, "/v2/volumes/#{volume_id}/actions", opts)
  end

  @doc """
  Same as `actions/2` but raises on error.
  """
  def actions!(volume_id, opts \\ []) do
    case actions(volume_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Initiate a block storage action on a volume.

  To initiate an action on a block storage volume by ID, send a POST request to
  `/v2/volumes/$VOLUME_ID/actions`.

  ## Actions

  ### Attach a Block Storage Volume to a Droplet
  - `type` - Must be `attach`
  - `droplet_id` - The Droplet's ID
  - `region` - The slug representing the region where the volume is located

  Each volume may only be attached to a single Droplet. However, up to fifteen
  volumes may be attached to a Droplet at a time. Pre-formatted volumes will be
  automatically mounted to Ubuntu, Debian, Fedora, Fedora Atomic, and CentOS
  Droplets created on or after April 26, 2018 when attached.

  ### Remove a Block Storage Volume from a Droplet
  - `type` - Must be `detach`
  - `droplet_id` - The Droplet's ID
  - `region` - The slug representing the region where the volume is located

  ### Resize a Volume
  - `type` - Must be `resize`
  - `size_gigabytes` - The new size of the block storage volume in GiB (1024^3)
  - `region` - The slug representing the region where the volume is located

  Volumes may only be resized upwards. The maximum size for a volume is 16TiB.

  ## Parameters
  - `volume_id` - The ID of the volume
  - `opts` - Optional parameters including `token`, `type`, `droplet_id`, `region`,
    `size_gigabytes`, `tags`

  ## Examples

    # Attach a volume to a Droplet
    Dox.Volumes.action("7724db7c-e098-11e5-b522-000f53304e51",
      token: "your_token", type: "attach", droplet_id: 11612190, region: "nyc1")

    # Remove a volume from a Droplet
    Dox.Volumes.action("7724db7c-e098-11e5-b522-000f53304e51",
      token: "your_token", type: "detach", droplet_id: 11612190, region: "nyc1")

    # Resize a volume
    Dox.Volumes.action("7724db7c-e098-11e5-b522-000f53304e51",
      token: "your_token", type: "resize", size_gigabytes: 100, region: "nyc1")
  """
  def action(volume_id, opts \\ []) do
    Request.request(:post, "/v2/volumes/#{volume_id}/actions", opts)
  end

  @doc """
  Same as `action/2` but raises on error.
  """
  def action!(volume_id, opts \\ []) do
    case action(volume_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List snapshots for a volume.

  To retrieve the snapshots that have been created from a volume, send a GET
  request to `/v2/volumes/$VOLUME_ID/snapshots`.

  ## Parameters
  - `volume_id` - The ID of the volume
  - `opts` - Optional parameters including `token`, `per_page`, `page`

  ## Examples

    Dox.Volumes.snapshots("82a48a18-873f-11e6-96bf-000f53315a41", token: "your_token")
  """
  def snapshots(volume_id, opts \\ []) do
    Request.request(:get, "/v2/volumes/#{volume_id}/snapshots", opts)
  end

  @doc """
  Same as `snapshots/2` but raises on error.
  """
  def snapshots!(volume_id, opts \\ []) do
    case snapshots(volume_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create a snapshot from a volume.

  To create a snapshot from a volume, send a POST request to
  `/v2/volumes/$VOLUME_ID/snapshots`.

  ## Parameters
  - `volume_id` - The ID of the volume
  - `opts` - Optional parameters including `token`, `name`, `tags`

  ## Examples

    Dox.Volumes.create_snapshot("82a48a18-873f-11e6-96bf-000f53315a41",
      token: "your_token", name: "big-data-snapshot1475261774")
  """
  def create_snapshot(volume_id, opts \\ []) do
    Request.request(:post, "/v2/volumes/#{volume_id}/snapshots", opts)
  end

  @doc """
  Same as `create_snapshot/2` but raises on error.
  """
  def create_snapshot!(volume_id, opts \\ []) do
    case create_snapshot(volume_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an existing volume snapshot.

  To retrieve the details of a snapshot that has been created from a volume,
  send a GET request to `/v2/volumes/snapshots/$VOLUME_SNAPSHOT_ID`.

  ## Parameters
  - `snapshot_id` - The ID of the snapshot to retrieve
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Volumes.get_snapshot("fbe805e8-866b-11e6-96bf-000f53315a41", token: "your_token")
  """
  def get_snapshot(snapshot_id, opts \\ []) do
    Request.request(:get, "/v2/volumes/snapshots/#{snapshot_id}", opts)
  end

  @doc """
  Same as `get_snapshot/2` but raises on error.
  """
  def get_snapshot!(snapshot_id, opts \\ []) do
    case get_snapshot(snapshot_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a volume snapshot.

  To delete a volume snapshot, send a DELETE request to
  `/v2/volumes/snapshots/$VOLUME_SNAPSHOT_ID`.

  A status of 204 will be returned. This indicates that the request was processed
  successfully, but that no response body is needed.

  ## Parameters
  - `snapshot_id` - The ID of the snapshot to delete
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Volumes.delete_snapshot("fbe805e8-866b-11e6-96bf-000f53315a41", token: "your_token")
  """
  def delete_snapshot(snapshot_id, opts \\ []) do
    Request.request(:delete, "/v2/volumes/snapshots/#{snapshot_id}", opts)
  end

  @doc """
  Same as `delete_snapshot/2` but raises on error.
  """
  def delete_snapshot!(snapshot_id, opts \\ []) do
    case delete_snapshot(snapshot_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
