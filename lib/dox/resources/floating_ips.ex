defmodule Dox.FloatingIps do
  @moduledoc """
  DigitalOcean FloatingIps API client.

  ## Usage

    Dox.FloatingIps.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all floating IPs.

  To list all of the floating IPs available on your account, send a GET
  request to `/v2/floating_ips`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `page`, and `per_page`

  ## Examples

      Dox.FloatingIps.list(token: "your_token")
      Dox.FloatingIps.list(page: 1, per_page: 20, token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/floating_ips", opts)
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
  Create a new floating IP.

  On creation, a floating IP must be either assigned to a Droplet or
  reserved to a region.

  * To create a new floating IP assigned to a Droplet, send a POST
    request to `/v2/floating_ips` with the `droplet_id` attribute.

  * To create a new floating IP reserved to a region, send a POST request
    to `/v2/floating_ips` with the `region` attribute.

  ## Parameters
  - `opts` - Optional parameters including `token`, `droplet_id`, `region`, and `project_id`

  ## Examples

      # Create floating IP assigned to a Droplet
      Dox.FloatingIps.create(droplet_id: 123456, token: "your_token")

      # Create floating IP reserved to a region
      Dox.FloatingIps.create(region: "nyc3", token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/floating_ips", opts)
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
  Retrieve an existing floating IP.

  To show information about a floating IP, send a GET request to
  `/v2/floating_ips/$FLOATING_IP_ADDR`.

  ## Parameters
  - `floating_ip` - The floating IP address (path parameter)
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.FloatingIps.get("45.55.96.47", token: "your_token")
  """
  def get(floating_ip, opts \\ []) do
    Request.request(:get, "/v2/floating_ips/#{floating_ip}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(floating_ip, opts \\ []) do
    case get(floating_ip, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a floating IP.

  To delete a floating IP and remove it from your account, send a DELETE
  request to `/v2/floating_ips/$FLOATING_IP_ADDR`.

  A successful request will receive a 204 status code with no body in response.

  ## Parameters
  - `floating_ip` - The floating IP address (path parameter)
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.FloatingIps.delete("45.55.96.47", token: "your_token")
  """
  def delete(floating_ip, opts \\ []) do
    Request.request(:delete, "/v2/floating_ips/#{floating_ip}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(floating_ip, opts \\ []) do
    case delete(floating_ip, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all actions for a floating IP.

  To retrieve all actions that have been executed on a floating IP, send a
  GET request to `/v2/floating_ips/$FLOATING_IP/actions`.

  ## Parameters
  - `floating_ip` - The floating IP address (path parameter)
  - `opts` - Optional parameters including `token`, `page`, and `per_page`

  ## Examples

      Dox.FloatingIps.actions("45.55.96.47", token: "your_token")
      Dox.FloatingIps.actions("45.55.96.47", page: 1, per_page: 20, token: "your_token")
  """
  def actions(floating_ip, opts \\ []) do
    Request.request(:get, "/v2/floating_ips/#{floating_ip}/actions", opts)
  end

  @doc """
  Same as `actions/2` but raises on error.
  """
  def actions!(floating_ip, opts \\ []) do
    case actions(floating_ip, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Initiate a floating IP action.

  To initiate an action on a floating IP send a POST request to
  `/v2/floating_ips/$FLOATING_IP/actions`. The `type` attribute in the
  request body specifies the action to perform:

  | Action     | Details                                  |
  |------------|------------------------------------------|
  | `assign`   | Assigns a floating IP to a Droplet       |
  | `unassign` | Unassign a floating IP from a Droplet    |

  ## Parameters
  - `floating_ip` - The floating IP address (path parameter)
  - `opts` - Optional parameters including `token`, `type`, and `droplet_id`

  ## Examples

      # Assign a floating IP to a Droplet
      Dox.FloatingIps.action("45.55.96.47", type: "assign", droplet_id: 8219222, token: "your_token")

      # Unassign a floating IP
      Dox.FloatingIps.action("45.55.96.47", type: "unassign", token: "your_token")
  """
  def action(floating_ip, opts \\ []) do
    Request.request(:post, "/v2/floating_ips/#{floating_ip}/actions", opts)
  end

  @doc """
  Same as `action/2` but raises on error.
  """
  def action!(floating_ip, opts \\ []) do
    case action(floating_ip, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
