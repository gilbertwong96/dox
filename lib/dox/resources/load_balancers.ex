defmodule Dox.LoadBalancers do
  @moduledoc """
  DigitalOcean LoadBalancers API client.

  ## Usage

    Dox.LoadBalancers.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Load Balancers

  To list all of the load balancer instances on your account, send a GET request
  to `/v2/load_balancers`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `page`, and `per_page`

  ## Examples

    Dox.LoadBalancers.list(token: "your_token")
    Dox.LoadBalancers.list(token: "your_token", page: 1, per_page: 20)
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/load_balancers", opts)
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
  Create a New Load Balancer

  To create a new load balancer instance, send a POST request to `/v2/load_balancers`.

  You can specify the Droplets that will sit behind the load balancer using one of two methods:

  - Set `droplet_ids` to a list of specific Droplet IDs.
  - Set `tag` to the name of a tag. All Droplets with this tag applied will be
    assigned to the load balancer. Additional Droplets will be automatically
    assigned as they are tagged.

  These methods are mutually exclusive.

  ## Parameters
  - `opts` - Optional parameters including `token` and request body

  ## Examples

    Dox.LoadBalancers.create(token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/load_balancers", opts)
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
  Retrieve an Existing Load Balancer

  To show information about a load balancer instance, send a GET request to
  `/v2/load_balancers/$LOAD_BALANCER_ID`.

  ## Parameters
  - `load_balancer_id` - The unique identifier of the load balancer
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.LoadBalancers.get("4de7ac8b-495b-4884-9a69-1050c6793cd6", token: "your_token")
  """
  def get(load_balancer_id, opts \\ []) do
    Request.request(:get, "/v2/load_balancers/#{load_balancer_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(load_balancer_id, opts \\ []) do
    case get(load_balancer_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update a Load Balancer

  To update a load balancer's settings, send a PUT request to
  `/v2/load_balancers/$LOAD_BALANCER_ID`. The request should contain a full
  representation of the load balancer including existing attributes. It may
  contain _one of_ the `droplets_ids` or `tag` attributes as they are mutually
  exclusive.

  **Note that any attribute that is not provided will be reset to its default value.**

  ## Parameters
  - `load_balancer_id` - The unique identifier of the load balancer
  - `opts` - Optional parameters including `token` and request body

  ## Examples

    Dox.LoadBalancers.update("4de7ac8b-495b-4884-9a69-1050c6793cd6", token: "your_token")
  """
  def update(load_balancer_id, opts \\ []) do
    Request.request(:put, "/v2/load_balancers/#{load_balancer_id}", opts)
  end

  @doc """
  Same as `update/2` but raises on error.
  """
  def update!(load_balancer_id, opts \\ []) do
    case update(load_balancer_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a Load Balancer

  To delete a load balancer instance, disassociating any Droplets assigned to it
  and removing it from your account, send a DELETE request to
  `/v2/load_balancers/$LOAD_BALANCER_ID`.

  A successful request will receive a 204 status code with no body in response.

  ## Parameters
  - `load_balancer_id` - The unique identifier of the load balancer
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.LoadBalancers.delete("4de7ac8b-495b-4884-9a69-1050c6793cd6", token: "your_token")
  """
  def delete(load_balancer_id, opts \\ []) do
    Request.request(:delete, "/v2/load_balancers/#{load_balancer_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(load_balancer_id, opts \\ []) do
    case delete(load_balancer_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List load balancer actions

  ## Parameters
  - `load_balancer_id` - Path parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.LoadBalancers.actions(load_balancer_id, token: "your_token")
  """
  def actions(load_balancer_id, opts \\ []) do
    Request.request(:get, "/v2/load_balancers/#{load_balancer_id}/actions", opts)
  end

  @doc """
  Same as `actions/2` but raises on error.
  """
  def actions!(load_balancer_id, opts \\ []) do
    case actions(load_balancer_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Perform load balancer action

  ## Parameters
  - `load_balancer_id` - Path parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.LoadBalancers.action(load_balancer_id, token: "your_token")
  """
  def action(load_balancer_id, opts \\ []) do
    Request.request(:post, "/v2/load_balancers/#{load_balancer_id}/actions", opts)
  end

  @doc """
  Same as `action/2` but raises on error.
  """
  def action!(load_balancer_id, opts \\ []) do
    case action(load_balancer_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
