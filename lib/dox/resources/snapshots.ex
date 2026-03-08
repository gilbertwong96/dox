defmodule Dox.Snapshots do
  @moduledoc """
  DigitalOcean Snapshots API client.

  ## Usage

    Dox.Snapshots.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all snapshots on your account.

  ## Summary
  List All Snapshots

  ## Description
  To list all of the snapshots available on your account, send a GET request to `/v2/snapshots`.

  The response will be a JSON object with a key called `snapshots`. This will be
  set to an array of `snapshot` objects, each of which will contain the standard
  snapshot attributes.

  ### Filtering Results by Resource Type

  It's possible to request filtered results by including certain query parameters.

  #### List Droplet Snapshots
  To retrieve only snapshots based on Droplets, include the `resource_type` query
  parameter set to `droplet`. For example, `/v2/snapshots?resource_type=droplet`.

  #### List Volume Snapshots
  To retrieve only snapshots based on volumes, include the `resource_type` query
  parameter set to `volume`. For example, `/v2/snapshots?resource_type=volume`.

  ## Parameters
  - `opts` - Optional parameters including:
    - `token` - API token
    - `resource_type` - Filter by resource type (`droplet` or `volume`)
    - `page` - Page number for pagination
    - `per_page` - Number of items per page

  ## Examples

    Dox.Snapshots.list(token: "your_token")

    # List only Droplet snapshots
    Dox.Snapshots.list(token: "your_token", resource_type: "droplet")

    # List only Volume snapshots
    Dox.Snapshots.list(token: "your_token", resource_type: "volume")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/snapshots", opts)
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
  Retrieve an existing snapshot.

  ## Summary
  Retrieve an Existing Snapshot

  ## Description
  To retrieve information about a snapshot, send a GET request to `/v2/snapshots/$SNAPSHOT_ID`.

  The response will be a JSON object with a key called `snapshot`. The value of this
  will be an snapshot object containing the standard snapshot attributes.

  The `snapshot_id` can be either the ID of an existing snapshot. This will be an
  integer for a Droplet snapshot or a string for a volume snapshot.

  ## Parameters
  - `snapshot_id` - The ID of an existing snapshot (integer for Droplet, string for volume)
  - `opts` - Optional parameters including `token`

  ## Examples

    # Get a Droplet snapshot by ID
    Dox.Snapshots.get(6372321, token: "your_token")

    # Get a Volume snapshot by ID
    Dox.Snapshots.get("f47ac10b-58cc-4372-a567-0e02b2c3d479", token: "your_token")
  """
  def get(snapshot_id, opts \\ []) do
    Request.request(:get, "/v2/snapshots/#{snapshot_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(snapshot_id, opts \\ []) do
    case get(snapshot_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a snapshot.

  ## Summary
  Delete a Snapshot

  ## Description
  Both Droplet and volume snapshots are managed through the `/v2/snapshots/` endpoint.
  To delete a snapshot, send a DELETE request to `/v2/snapshots/$SNAPSHOT_ID`.

  A status of 204 will be given. This indicates that the request was processed
  successfully, but that no response body is needed.

  ## Parameters
  - `snapshot_id` - The ID of an existing snapshot (integer for Droplet, string for volume)
  - `opts` - Optional parameters including `token`

  ## Examples

    # Delete a Droplet snapshot by ID
    Dox.Snapshots.delete(6372321, token: "your_token")

    # Delete a Volume snapshot by ID
    Dox.Snapshots.delete("f47ac10b-58cc-4372-a567-0e02b2c3d479", token: "your_token")
  """
  def delete(snapshot_id, opts \\ []) do
    Request.request(:delete, "/v2/snapshots/#{snapshot_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(snapshot_id, opts \\ []) do
    case delete(snapshot_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
