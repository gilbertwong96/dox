defmodule Dox.ReservedIps do
  @moduledoc """
  DigitalOcean ReservedIps API client.

  ## Usage

    Dox.ReservedIps.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all reserved IPs.

  To list all of the reserved IPs available on your account, send a GET
  request to `/v2/reserved_ips`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `page`, and `per_page`

  ## Examples

      Dox.ReservedIps.list(token: "your_token")
      Dox.ReservedIps.list(page: 1, per_page: 20, token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/reserved_ips", opts)
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
  Create a new reserved IP.

  On creation, a reserved IP must be either assigned to a Droplet or
  reserved to a region.

  * To create a new reserved IP assigned to a Droplet, send a POST
    request to `/v2/reserved_ips` with the `droplet_id` attribute.

  * To create a new reserved IP reserved to a region, send a POST request
    to `/v2/reserved_ips` with the `region` attribute.

  ## Parameters
  - `opts` - Optional parameters including `token`, `droplet_id`, `region`, and `project_id`

  ## Examples

      # Create reserved IP assigned to a Droplet
      Dox.ReservedIps.create(droplet_id: 123456, token: "your_token")

      # Create reserved IP reserved to a region
      Dox.ReservedIps.create(region: "nyc3", token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/reserved_ips", opts)
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
  Retrieve an existing reserved IP.

  To show information about a reserved IP, send a GET request to
  `/v2/reserved_ips/$RESERVED_IP_ADDR`.

  ## Parameters
  - `reserved_ip` - The reserved IP address (path parameter)
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.ReservedIps.get("45.55.96.47", token: "your_token")
  """
  def get(reserved_ip, opts \\ []) do
    Request.request(:get, "/v2/reserved_ips/#{reserved_ip}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(reserved_ip, opts \\ []) do
    case get(reserved_ip, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a reserved IP.

  To delete a reserved IP and remove it from your account, send a DELETE
  request to `/v2/reserved_ips/$RESERVED_IP_ADDR`.

  A successful request will receive a 204 status code with no body in response.

  ## Parameters
  - `reserved_ip` - The reserved IP address (path parameter)
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.ReservedIps.delete("45.55.96.47", token: "your_token")
  """
  def delete(reserved_ip, opts \\ []) do
    Request.request(:delete, "/v2/reserved_ips/#{reserved_ip}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(reserved_ip, opts \\ []) do
    case delete(reserved_ip, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all actions for a reserved IP.

  To retrieve all actions that have been executed on a reserved IP, send a
  GET request to `/v2/reserved_ips/$RESERVED_IP/actions`.

  ## Parameters
  - `reserved_ip` - The reserved IP address (path parameter)
  - `opts` - Optional parameters including `token`, `page`, and `per_page`

  ## Examples

      Dox.ReservedIps.actions("45.55.96.47", token: "your_token")
      Dox.ReservedIps.actions("45.55.96.47", page: 1, per_page: 20, token: "your_token")
  """
  def actions(reserved_ip, opts \\ []) do
    Request.request(:get, "/v2/reserved_ips/#{reserved_ip}/actions", opts)
  end

  @doc """
  Same as `actions/2` but raises on error.
  """
  def actions!(reserved_ip, opts \\ []) do
    case actions(reserved_ip, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Initiate a reserved IP action.

  To initiate an action on a reserved IP send a POST request to
  `/v2/reserved_ips/$RESERVED_IP/actions`. The `type` attribute in the
  request body specifies the action to perform:

  | Action     | Details                                 |
  |------------|-----------------------------------------|
  | `assign`   | Assigns a reserved IP to a Droplet     |
  | `unassign` | Unassign a reserved IP from a Droplet  |

  ## Parameters
  - `reserved_ip` - The reserved IP address (path parameter)
  - `opts` - Optional parameters including `token`, `type`, and `droplet_id`

  ## Examples

      # Assign a reserved IP to a Droplet
      Dox.ReservedIps.action("45.55.96.47", type: "assign", droplet_id: 8219222, token: "your_token")

      # Unassign a reserved IP
      Dox.ReservedIps.action("45.55.96.47", type: "unassign", token: "your_token")
  """
  def action(reserved_ip, opts \\ []) do
    Request.request(:post, "/v2/reserved_ips/#{reserved_ip}/actions", opts)
  end

  @doc """
  Same as `action/2` but raises on error.
  """
  def action!(reserved_ip, opts \\ []) do
    case action(reserved_ip, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
