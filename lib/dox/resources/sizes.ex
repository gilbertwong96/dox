defmodule Dox.Sizes do
  @moduledoc """
  DigitalOcean Sizes API client.

  ## Usage

    Dox.Sizes.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Droplet Sizes

  To list all of available Droplet sizes, send a GET request to `/v2/sizes`.

  The response will be a JSON object with a key called `sizes`. The value of this
  will be an array of `size` objects each of which contain the standard size attributes.

  ## Parameters
  - `opts` - Optional parameters including:
    - `token` - Authentication token
    - `per_page` - Number of items returned per page (1-200, default: 20)
    - `page` - Which page of paginated results to return

  ## Examples

    Dox.Sizes.list(token: "your_token")

    # With pagination
    Dox.Sizes.list(per_page: 50, page: 2)
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/sizes", opts)
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
