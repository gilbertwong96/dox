defmodule Dox.RequestStruct do
  @moduledoc """
  Represents an HTTP request for use in plugins.
  """

  defstruct [:method, :url, :headers, :body, opts: []]

  @type t :: %__MODULE__{
          method: atom() | nil,
          url: URI.t() | nil,
          headers: [{binary(), binary()}] | nil,
          body: term() | nil,
          opts: keyword()
        }
end
