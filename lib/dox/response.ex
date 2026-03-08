defmodule Dox.Response do
  @moduledoc """
  Response wrapper for DigitalOcean API responses.
  """

  defstruct [:body, :headers, :status_code, :request]

  @type t :: %__MODULE__{
          body: map(),
          headers: [{String.t(), String.t()}],
          status_code: non_neg_integer(),
          request: map()
        }

  @doc """
  Creates a new response struct.
  """
  def new(body, headers, status_code, request \\ %{}) do
    %__MODULE__{
      body: body,
      headers: headers,
      status_code: status_code,
      request: request
    }
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
end
