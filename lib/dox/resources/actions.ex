defmodule Dox.Actions do
  @moduledoc """
  DigitalOcean Actions API client.

  ## Usage

    Dox.Actions.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all actions.

  To list all actions in your account, send a GET request to `/v2/actions`. This will
  return the entire list of actions taken on your account, so it will be quite large.
  As with any large collection returned by the API, the results will be paginated with
  only 20 on each page by default.

  ## Parameters
  - `opts` - Optional parameters including:
    - `token` - Your DigitalOcean API token
    - `per_page` - Number of items returned per page (default: 20, max: 200)
    - `page` - Which page of paginated results to return (default: 1)

  ## Examples

      Dox.Actions.list(token: "your_token")
      #=> {:ok, %Dox.Response{...}}

      Dox.Actions.list(token: "your_token", per_page: 50, page: 2)
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns a `%Dox.Response{}` containing an array of action objects. Each action object includes:
  - `id` - Unique numeric ID for the action
  - `status` - Current status (in-progress, completed, or errored)
  - `type` - Type of action (e.g., "create", "transfer")
  - `started_at` - ISO8601 timestamp when the action was initiated
  - `completed_at` - ISO8601 timestamp when the action completed
  - `resource_id` - Unique identifier for the associated resource
  - `resource_type` - Type of resource (e.g., "droplet")
  - `region` - Region slug for the resource
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/actions", opts)
  end

  @doc """
  Same as `list/1` but raises on error.

  ## Examples

      Dox.Actions.list!(token: "your_token")
      #=> %Dox.Response{...}
  """
  def list!(opts \\ []) do
    case list(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an existing action.

  To retrieve a specific action object, send a GET request to `/v2/actions/$ACTION_ID`.

  ## Parameters
  - `action_id` - A unique numeric ID that can be used to identify and reference an action (required)
  - `opts` - Optional parameters including:
    - `token` - Your DigitalOcean API token

  ## Examples

      Dox.Actions.get(36804636, token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns a `%Dox.Response{}` containing an action object with the following attributes:
  - `id` - Unique numeric ID for the action
  - `status` - Current status (in-progress, completed, or errored)
  - `type` - Type of action (e.g., "create", "transfer")
  - `started_at` - ISO8601 timestamp when the action was initiated
  - `completed_at` - ISO8601 timestamp when the action completed
  - `resource_id` - Unique identifier for the associated resource
  - `resource_type` - Type of resource (e.g., "droplet")
  - `region` - Region slug for the resource
  """
  def get(action_id, opts \\ []) do
    Request.request(:get, "/v2/actions/#{action_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.

  ## Examples

      Dox.Actions.get!(36804636, token: "your_token")
      #=> %Dox.Response{...}
  """
  def get!(action_id, opts \\ []) do
    case get(action_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
