defmodule Dox.Response do
  @moduledoc """
  Response wrapper for DigitalOcean API responses.
  """

  defstruct [:body, :status_code, :rate_limit, :rate_remaining, :rate_reset]

  @type t :: %__MODULE__{
          body: map(),
          status_code: non_neg_integer(),
          rate_limit: non_neg_integer() | nil,
          rate_remaining: non_neg_integer() | nil,
          rate_reset: integer() | nil
        }

  @doc """
  Creates a new response struct with rate limit info extracted from headers.
  Headers are processed internally but not exposed to users.
  """
  def new(body, headers, status_code, _request \\ %{}) do
    %__MODULE__{
      body: body,
      status_code: status_code,
      rate_limit: get_header(headers, "ratelimit-limit") |> parse_int(),
      rate_remaining: get_header(headers, "ratelimit-remaining") |> parse_int(),
      rate_reset: get_header(headers, "ratelimit-reset") |> parse_int()
    }
  end

  defp get_header(headers, key) do
    case List.keyfind(headers, key, 0) do
      nil -> nil
      {_, value} -> value
    end
  end

  defp parse_int(nil), do: nil
  defp parse_int(""), do: nil

  defp parse_int(value) do
    case Integer.parse(value) do
      {int, _} -> int
      :error -> nil
    end
  end

  @doc """
  Extracts the data from the response body.
  """
  def data(%__MODULE__{body: body}) do
    Map.get(body, "data", body)
  end

  @doc """
  Extracts meta information from the response (like pagination).
  """
  def meta(%__MODULE__{body: body}) do
    Map.get(body, "meta", %{})
  end

  @doc """
  Extracts links information from the response (for pagination).
  """
  def links(%__MODULE__{body: body}) do
    Map.get(body, "links", %{})
  end

  @doc """
  Checks if the response is successful (2xx status code).
  """
  def success?(%__MODULE__{status_code: status}) do
    status >= 200 and status < 300
  end

  @doc """
  Checks if the response is an error (4xx or 5xx status code).
  """
  def error?(%__MODULE__{status_code: status}) do
    status >= 400
  end

  @doc """
  Returns rate limit information.
  """
  def rate_limit_info(%__MODULE__{} = response) do
    %{
      limit: response.rate_limit,
      remaining: response.rate_remaining,
      reset: response.rate_reset
    }
  end

  @doc """
  Checks if the response is near the rate limit threshold.
  """
  def near_rate_limit?(%__MODULE__{} = response, threshold \\ 100) do
    case response.rate_remaining do
      nil -> false
      remaining -> remaining <= threshold
    end
  end
end
