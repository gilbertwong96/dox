defmodule Dox.Monitoring do
  @moduledoc """
  DigitalOcean Monitoring Metrics API client.

  ## Usage

    Dox.Monitoring.get_droplet_bandwidth(222651441,
      interface: "public",
      direction: "outbound",
      start: 1636051668,
      end: 1636051668,
      token: "your_token"
    )
  """

  alias Dox.Request

  @doc """
  Get Droplet Bandwidth Metrics.

  To retrieve bandwidth metrics for a given Droplet, send a GET request to
  `/v2/monitoring/metrics/droplet/bandwidth`. Use the `interface` query
  parameter to specify if the results should be for the `private` or
  `public` interface. Use the `direction` query parameter to specify if
  the results should be for `inbound` or `outbound` traffic.

  The metrics in the response body are in megabits per second (Mbps).

  ## Parameters
  - `droplet_id` - The ID of the Droplet to retrieve bandwidth metrics for
  - `opts` - Optional parameters including:
    - `interface` - `:public` or `:private` (required)
    - `direction` - `:inbound` or `:outbound` (required)
    - `start` - Unix timestamp for the start of the metrics window (required)
    - `end` - Unix timestamp for the end of the metrics window (required)
    - `token` - Your DigitalOcean API token

  ## Examples

      Dox.Monitoring.get_droplet_bandwidth(222651441,
        interface: "public",
        direction: "outbound",
        start: 1636051668,
        end: 1636051668,
        token: "your_token"
      )
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns a `%Dox.Response{}` with a `data` object containing `result` array
  of bandwidth data points. Each data point has:
  - `date` - ISO8601 timestamp
  - `value` - Bandwidth in Mbps
  """
  @spec get_droplet_bandwidth(non_neg_integer(), keyword()) ::
          {:ok, Dox.Response.t()} | {:error, term()}
  def get_droplet_bandwidth(droplet_id, opts \\ []) do
    params =
      %{
        "host_id" => droplet_id,
        "interface" => Keyword.get(opts, :interface),
        "direction" => Keyword.get(opts, :direction),
        "start" => Keyword.get(opts, :start),
        "end" => Keyword.get(opts, :end)
      }

    Request.request(:get, "/v2/monitoring/metrics/droplet/bandwidth",
      token: Keyword.get(opts, :token),
      params: params
    )
  end

  @doc """
  Same as `get_droplet_bandwidth/2` but raises on error.

  ## Examples

      Dox.Monitoring.get_droplet_bandwidth!(222651441,
        interface: "public",
        direction: "outbound",
        start: 1636051668,
        end: 1636051668,
        token: "your_token"
      )
      #=> %Dox.Response{...}
  """
  @spec get_droplet_bandwidth!(non_neg_integer(), keyword()) :: Dox.Response.t()
  def get_droplet_bandwidth!(droplet_id, opts \\ []) do
    case get_droplet_bandwidth(droplet_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get Droplet CPU Metrics.

  To retrieve CPU metrics for a given droplet, send a GET request to
  `/v2/monitoring/metrics/droplet/cpu`.

  The metrics in the response body are CPU usage as a percentage.

  ## Parameters
  - `droplet_id` - The ID of the Droplet to retrieve CPU metrics for
  - `opts` - Optional parameters including:
    - `start` - Unix timestamp for the start of the metrics window (required)
    - `end` - Unix timestamp for the end of the metrics window (required)
    - `token` - Your DigitalOcean API token
  """
  @spec get_droplet_cpu(non_neg_integer(), keyword()) :: {:ok, Dox.Response.t()} | {:error, term()}
  def get_droplet_cpu(droplet_id, opts \\ []) do
    params = %{
      "host_id" => droplet_id,
      "start" => Keyword.get(opts, :start),
      "end" => Keyword.get(opts, :end)
    }

    Request.request(:get, "/v2/monitoring/metrics/droplet/cpu",
      token: Keyword.get(opts, :token),
      params: params
    )
  end

  @doc """
  Get Droplet Memory Metrics.

  To retrieve memory metrics for a given droplet, send a GET request to
  `/v2/monitoring/metrics/droplet/memory_free`.

  Returns free memory in bytes.

  ## Parameters
  - `droplet_id` - The ID of the Droplet
  - `opts` - Optional parameters: `start`, `end`, `token`
  """
  @spec get_droplet_memory(non_neg_integer(), keyword()) :: {:ok, Dox.Response.t()} | {:error, term()}
  def get_droplet_memory(droplet_id, opts \\ []) do
    params = %{
      "host_id" => droplet_id,
      "start" => Keyword.get(opts, :start),
      "end" => Keyword.get(opts, :end)
    }

    Request.request(:get, "/v2/monitoring/metrics/droplet/memory_free",
      token: Keyword.get(opts, :token),
      params: params
    )
  end
end
