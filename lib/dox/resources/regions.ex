defmodule Dox.Regions do
  @moduledoc """
  DigitalOcean Regions API client.

  ## Usage

    Dox.Regions.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Data Center Regions

  To list all of the regions that are available, send a GET request to `/v2/regions`.

  The response will be a JSON object with a key called `regions`. The value of this
  will be an array of `region` objects, each of which will contain the standard
  region attributes.

  ## Parameters
  - `opts` - Optional parameters including:
    - `token` - Authentication token
    - `per_page` - Number of items returned per page (1-200, default: 20)
    - `page` - Which page of paginated results to return

  ## Examples

    Dox.Regions.list(token: "your_token")

    # With pagination
    Dox.Regions.list(per_page: 50, page: 2)
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/regions", opts)
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
end
