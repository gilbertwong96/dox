defmodule Dox.Vpcs do
  @moduledoc """
  DigitalOcean Vpcs API client.

  ## Usage

    Dox.Vpcs.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all VPCs.

  To list all of the VPCs on your account, send a GET request to `/v2/vpcs`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `per_page`, `page`

  ## Examples

    Dox.Vpcs.list(token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/vpcs", opts)
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
  Create a new VPC.

  To create a VPC, send a POST request to `/v2/vpcs` specifying the attributes
  in the JSON body (name, region, ip_range, description).

  **Note:** If you do not currently have a VPC network in a specific datacenter
  region, the first one that you create will be set as the default for that
  region. The default VPC for a region cannot be changed or deleted.

  ## Parameters
  - `opts` - Optional parameters including `token`, `name`, `region`, `ip_range`, `description`

  ## Examples

    Dox.Vpcs.create(token: "your_token", name: "my-new-vpc", region: "nyc1",
      ip_range: "10.10.10.0/24")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/vpcs", opts)
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
  Retrieve an existing VPC.

  To show information about an existing VPC, send a GET request to
  `/v2/vpcs/$VPC_ID`.

  ## Parameters
  - `vpc_id` - The ID of the VPC to retrieve
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Vpcs.get("5a4981aa-9653-4bd1-bef5-d6bff52042e4", token: "your_token")
  """
  def get(vpc_id, opts \\ []) do
    Request.request(:get, "/v2/vpcs/#{vpc_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(vpc_id, opts \\ []) do
    case get(vpc_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update a VPC.

  To update information about a VPC, send a PUT request to `/v2/vpcs/$VPC_ID`.

  ## Parameters
  - `vpc_id` - The ID of the VPC to update
  - `opts` - Optional parameters including `token`, `name`, `description`, `default`

  ## Examples

    Dox.Vpcs.update("5a4981aa-9653-4bd1-bef5-d6bff52042e4",
      token: "your_token", name: "renamed-new-vpc", description: "A new description")
  """
  def update(vpc_id, opts \\ []) do
    Request.request(:put, "/v2/vpcs/#{vpc_id}", opts)
  end

  @doc """
  Same as `update/2` but raises on error.
  """
  def update!(vpc_id, opts \\ []) do
    case update(vpc_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a VPC.

  To delete a VPC, send a DELETE request to `/v2/vpcs/$VPC_ID`. A 204 status
  code with no body will be returned in response to a successful request.

  The default VPC for a region cannot be deleted. Additionally, a VPC can only
  be deleted if it does not contain any member resources. Attempting to delete
  a region's default VPC or a VPC that still has members will result in a 403
  Forbidden error response.

  ## Parameters
  - `vpc_id` - The ID of the VPC to delete
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Vpcs.delete("e0fe0f4d-596a-465e-a902-571ce57b79fa", token: "your_token")
  """
  def delete(vpc_id, opts \\ []) do
    Request.request(:delete, "/v2/vpcs/#{vpc_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(vpc_id, opts \\ []) do
    case delete(vpc_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List the member resources of a VPC.

  To list all of the resources that are members of a VPC, send a GET request to
  `/v2/vpcs/$VPC_ID/members`.

  To only list resources of a specific type that are members of the VPC, include
  a `resource_type` query parameter. For example, to only list Droplets in the VPC,
  send a GET request to `/v2/vpcs/$VPC_ID/members?resource_type=droplet`.

  Only resources that you are authorized to see will be returned (e.g. to see
  Droplets, you must have `droplet:read`).

  ## Parameters
  - `vpc_id` - The ID of the VPC
  - `opts` - Optional parameters including `token`, `resource_type`, `per_page`, `page`

  ## Examples

    # List all VPC members
    Dox.Vpcs.members("5a4981aa-9653-4bd1-bef5-d6bff52042e4", token: "your_token")

    # List only Droplet members
    Dox.Vpcs.members("5a4981aa-9653-4bd1-bef5-d6bff52042e4",
      token: "your_token", resource_type: "droplet")
  """
  def members(vpc_id, opts \\ []) do
    Request.request(:get, "/v2/vpcs/#{vpc_id}/members", opts)
  end

  @doc """
  Same as `members/2` but raises on error.
  """
  def members!(vpc_id, opts \\ []) do
    case members(vpc_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List VPC resources.

  Note: This function is an alias for `members/2` and uses the same endpoint
  `/v2/vpcs/$VPC_ID/members` to list all resources that are members of a VPC.

  ## Parameters
  - `vpc_id` - The ID of the VPC
  - `opts` - Optional parameters including `token`, `resource_type`, `per_page`, `page`

  ## Examples

    Dox.Vpcs.resources("5a4981aa-9653-4bd1-bef5-d6bff52042e4", token: "your_token")
  """
  def resources(vpc_id, opts \\ []) do
    Request.request(:get, "/v2/vpcs/#{vpc_id}/resources", opts)
  end

  @doc """
  Same as `resources/2` but raises on error.
  """
  def resources!(vpc_id, opts \\ []) do
    case resources(vpc_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
