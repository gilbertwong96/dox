defmodule Dox.Error do
  @moduledoc """
  Error struct for handling DigitalOcean API errors.
  """

  defstruct [:message, :status_code, :response, :reason]

  @type t :: %__MODULE__{
          message: String.t(),
          status_code: non_neg_integer() | nil,
          response: map() | nil,
          reason: atom() | nil
        }

  @doc """
  Creates a new error struct.
  """
  def new(message, opts \\ []) do
    %__MODULE__{
      message: message,
      status_code: Keyword.get(opts, :status_code),
      response: Keyword.get(opts, :response),
      reason: Keyword.get(opts, :reason)
    }
  end

  @doc """
  Creates an error from an HTTP response.
  """
  def from_response(%{"error" => message, "message" => full_message}) do
    new(full_message || message, reason: :api_error)
  end

  def from_response(%{"errors" => errors}) when is_list(errors) do
    messages = Enum.map_join(errors, "; ", fn %{"message" => msg} -> msg end)
    new(messages, reason: :api_error)
  end

  def from_response(%{"id" => id, "message" => message}) do
    new("#{id}: #{message}", reason: :api_error)
  end

  def from_response(response) when is_map(response) do
    new("Unknown error", response: response, reason: :unknown)
  end

  @doc """
  Creates an error from HTTP status and reason.
  """
  def from_status(status, reason) do
    message =
      case reason do
        :timeout -> "Request timed out"
        :connect_timeout -> "Connection timed out"
        :econnrefused -> "Connection refused"
        :econnreset -> "Connection reset"
        :nxdomain -> "Host not found"
        _ -> "HTTP error #{status}"
      end

    new(message, status_code: status, reason: reason)
  end
end

defimpl String.Chars, for: Dox.Error do
  def to_string(%Dox.Error{message: message}) do
    message
  end
end
