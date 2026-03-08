defmodule Dox.OneClicks do
  @moduledoc """
  DigitalOcean OneClicks API client.

  ## Usage

    Dox.OneClicks.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List 1-Click Applications

  To list all available 1-Click applications, send a GET request to `/v2/1-clicks`.
  The `type` may be provided as query parameter in order to restrict results to a certain
  type of 1-Click, for example: `/v2/1-clicks?type=droplet`. Current supported types are
  `kubernetes` and `droplet`.

  The response will be a JSON object with a key called `1_clicks`. This will be set to an array of
  1-Click application data, each of which will contain the the slug and type for the 1-Click.

  ## Parameters
  - `opts` - Optional parameters including `token` and `type` (either "droplet" or "kubernetes")

  ## Examples

    # List all 1-clicks
    Dox.OneClicks.list(token: "your_token")

    # List only Kubernetes 1-clicks
    Dox.OneClicks.list(token: "your_token", type: "kubernetes")

    # List only Droplet 1-clicks
    Dox.OneClicks.list(token: "your_token", type: "droplet")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/1-clicks", opts)
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
  List Kubernetes 1-Click Applications

  To list all available Kubernetes 1-Click applications, send a GET request to
  `/v2/1-clicks` with `type=kubernetes` query parameter.

  This is equivalent to calling `list/1` with `type: "kubernetes"` option.

  ## Parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.OneClicks.list_kubernetes(token: "your_token")
  """
  def list_kubernetes(opts \\ []) do
    Request.request(:get, "/v2/1-clicks/kubernetes", opts)
  end

  @doc """
  Same as `list_kubernetes/1` but raises on error.
  """
  def list_kubernetes!(opts \\ []) do
    case list_kubernetes(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
