defmodule Dox.RequestStruct do
  @moduledoc """
  Represents an HTTP request for use in plugins.
  """

  @enforce_keys [:method, :url]
  defstruct [:method, :url, :headers, :body]

  @type t :: %__MODULE__{
          method: atom(),
          url: URI.t(),
          headers: [{binary(), binary()}],
          body: term()
        }
end
