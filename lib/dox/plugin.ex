defmodule Dox.Plugin do
  @moduledoc """
  Behaviour for Dox plugins that allow extending request behavior.

  Plugins can implement any of these callbacks to modify requests and responses:
  - `init/1` - Initialize plugin state
  - `before_request/2` - Modify the request before it's sent
  - `after_response/3` - Process the response after receiving

  ## Example Plugin

      defmodule MyPlugin do
        @behaviour Dox.Plugin

        def init(opts) do
          {:ok, opts}
        end

        def before_request(request, state) do
          # Add custom header, log, etc.
          {request, state}
        end

        def after_response(response, state, _request) do
          # Process response, add caching, etc.
          {:ok, response, state}
        end
      end
  """

  @doc """
  Called when the plugin is initialized. Use this to set up any state
  needed by the plugin.

  ## Options
    - Any options passed to the plugin when configured

  ## Returns
    - `{:ok, state}` - Successful initialization with state
    - `{:error, reason}` - Failed to initialize
  """
  @callback init(term()) :: {:ok, term()} | {:error, term()}

  @doc """
  Called before the request is sent. Use this to modify the request,
  add headers, log, etc.

  ## Parameters
    - `request` - The Dox.RequestStruct struct
    - `state` - The plugin state from init

  ## Returns
    - `{request, state}` - Modified request and state
  """
  @callback before_request(Dox.RequestStruct.t(), term()) :: {Dox.RequestStruct.t(), term()}

  @doc """
  Called after the response is received. Use this to process the response,
  add caching, logging, metrics, etc.

  ## Parameters
    - `response` - The Dox.Response struct
    - `state` - The plugin state from init
    - `request` - The original request (for reference)

  ## Returns
    - `{:ok, response, state}` - Response and updated state
  """
  @callback after_response(Dox.Response.t(), term(), Dox.RequestStruct.t()) ::
              {:ok, Dox.Response.t(), term()}

  # Default implementations

  defmacro __using__(_opts) do
    quote do
      @behaviour Dox.Plugin

      @impl true
      def init(opts) do
        {:ok, opts}
      end

      @impl true
      def before_request(request, state) do
        {request, state}
      end

      @impl true
      def after_response(response, state, _request) do
        {:ok, response, state}
      end

      defoverridable init: 1, before_request: 2, after_response: 3
    end
  end
end
