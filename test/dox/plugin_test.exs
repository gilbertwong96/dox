defmodule Dox.PluginTest do
  use ExUnit.Case, async: true

  # Plugin that uses the Dox.Plugin __using__ macro
  defmodule UsingPlugin do
    use Dox.Plugin
  end

  # Plugin with custom implementations
  defmodule TestPlugin do
    @behaviour Dox.Plugin

    @impl true
    def init(opts) do
      {:ok, Keyword.put(opts, :initialized, true)}
    end

    @impl true
    def before_request(request, state) do
      new_headers = [{"x-test-plugin", "active"} | request.headers]
      {%{request | headers: new_headers}, state}
    end

    @impl true
    def after_response(response, state, _request) do
      {:ok, response, state}
    end
  end

  # Plugin that modifies state in before_request
  defmodule StateModifyingPlugin do
    @behaviour Dox.Plugin

    @impl true
    def init(_opts) do
      {:ok, %{counter: 0}}
    end

    @impl true
    def before_request(request, state) do
      {request, %{state | counter: state.counter + 1}}
    end

    @impl true
    def after_response(response, state, _request) do
      {:ok, response, state}
    end
  end

  # Plugin that modifies response in after_response
  defmodule ResponseModifyingPlugin do
    @behaviour Dox.Plugin

    @impl true
    def init(_opts) do
      {:ok, %{}}
    end

    @impl true
    def before_request(request, state) do
      {request, state}
    end

    @impl true
    def after_response(response, state, _request) do
      # Return modified response
      modified_response = %{response | body: %{modified: true}}
      {:ok, modified_response, state}
    end
  end

  # Failing plugin
  defmodule FailingPlugin do
    @behaviour Dox.Plugin

    @impl true
    def init(_opts) do
      {:error, :failed_to_initialize}
    end

    @impl true
    def before_request(request, _state) do
      {request, %{}}
    end

    @impl true
    def after_response(response, _state, _request) do
      {:ok, response, %{}}
    end
  end

  describe "Dox.Plugin behaviour" do
    test "defines callbacks in behaviour" do
      callbacks = Dox.Plugin.behaviour_info(:callbacks)
      assert Keyword.has_key?(callbacks, :init)
      assert Keyword.has_key?(callbacks, :before_request)
      assert Keyword.has_key?(callbacks, :after_response)
    end
  end

  describe "plugin initialization" do
    test "init returns ok with state" do
      assert {:ok, [initialized: true]} = TestPlugin.init([])
    end

    test "init with custom options" do
      assert {:ok, [initialized: true, custom: "value"]} = TestPlugin.init(custom: "value")
    end

    test "init returns error for failing plugin" do
      assert {:error, :failed_to_initialize} = FailingPlugin.init([])
    end

    test "init with custom error reason" do
      defmodule CustomErrorPlugin do
        @behaviour Dox.Plugin

        @impl true
        def init(_opts), do: {:error, :custom_reason}
        @impl true
        def before_request(request, state), do: {request, state}
        @impl true
        def after_response(response, state, _request), do: {:ok, response, state}
      end

      assert {:error, :custom_reason} = CustomErrorPlugin.init([])
    end
  end

  describe "before_request/2" do
    test "returns modified request and state" do
      request = %Dox.RequestStruct{
        method: :get,
        url: URI.parse("https://example.com"),
        headers: [],
        body: nil
      }

      state = %{initialized: true}

      {modified_request, new_state} = TestPlugin.before_request(request, state)

      assert {"x-test-plugin", "active"} in modified_request.headers
      assert new_state == state
    end

    test "adds multiple headers" do
      defmodule MultiHeaderPlugin do
        @behaviour Dox.Plugin

        @impl true
        def init(opts), do: {:ok, opts}
        @impl true
        def before_request(request, state) do
          new_headers = [
            {"x-custom-header", "value1"},
            {"x-another-header", "value2"}
            | request.headers
          ]

          {%{request | headers: new_headers}, state}
        end

        @impl true
        def after_response(response, state, _request), do: {:ok, response, state}
      end

      request = %Dox.RequestStruct{
        method: :get,
        url: URI.parse("https://example.com"),
        headers: [],
        body: nil
      }

      {modified_request, _} = MultiHeaderPlugin.before_request(request, %{})

      assert {"x-custom-header", "value1"} in modified_request.headers
      assert {"x-another-header", "value2"} in modified_request.headers
    end

    test "modifies request body" do
      defmodule BodyModifyingPlugin do
        @behaviour Dox.Plugin

        @impl true
        def init(opts), do: {:ok, opts}
        @impl true
        def before_request(request, state) do
          {%{request | body: %{modified: true}}, state}
        end

        @impl true
        def after_response(response, state, _request), do: {:ok, response, state}
      end

      request = %Dox.RequestStruct{
        method: :post,
        url: URI.parse("https://example.com"),
        headers: [],
        body: %{original: true}
      }

      {modified_request, _} = BodyModifyingPlugin.before_request(request, %{})

      assert modified_request.body == %{modified: true}
    end

    test "modifies request method" do
      defmodule MethodModifyingPlugin do
        @behaviour Dox.Plugin

        @impl true
        def init(opts), do: {:ok, opts}
        @impl true
        def before_request(request, state) do
          {%{request | method: :post}, state}
        end

        @impl true
        def after_response(response, state, _request), do: {:ok, response, state}
      end

      request = %Dox.RequestStruct{
        method: :get,
        url: URI.parse("https://example.com"),
        headers: [],
        body: nil
      }

      {modified_request, _} = MethodModifyingPlugin.before_request(request, %{})

      assert modified_request.method == :post
    end

    test "state modifying plugin updates state" do
      request = %Dox.RequestStruct{
        method: :get,
        url: URI.parse("https://example.com"),
        headers: [],
        body: nil
      }

      initial_state = %{counter: 0}

      {_, new_state} = StateModifyingPlugin.before_request(request, initial_state)

      assert new_state.counter == 1
    end
  end

  describe "after_response/3" do
    test "returns ok tuple with response and state" do
      response = %Dox.Response{
        status_code: 200,
        body: %{}
      }

      state = %{initialized: true}

      assert {:ok, ^response, _new_state} = TestPlugin.after_response(response, state, %{})
    end

    test "response modifying plugin returns modified response" do
      response = %Dox.Response{
        status_code: 200,
        body: %{original: true}
      }

      assert {:ok, modified_response, _} =
               ResponseModifyingPlugin.after_response(response, %{}, %{})

      assert modified_response.body == %{modified: true}
    end

    test "after_response has access to original request" do
      defmodule RequestAccessingPlugin do
        @behaviour Dox.Plugin

        @impl true
        def init(opts), do: {:ok, opts}
        @impl true
        def before_request(request, state), do: {request, state}

        @impl true
        def after_response(response, state, request) do
          # Use request info to modify response
          modified_body = Map.put(response.body, :method, request.method)
          {:ok, %{response | body: modified_body}, state}
        end
      end

      response = %Dox.Response{
        status_code: 200,
        body: %{}
      }

      request = %Dox.RequestStruct{
        method: :get,
        url: URI.parse("https://example.com")
      }

      assert {:ok, result, _} = RequestAccessingPlugin.after_response(response, %{}, request)
      assert result.body.method == :get
    end
  end

  describe "__using__ macro" do
    test "provides default implementations" do
      # Test that UsingPlugin works with default implementations
      assert {:ok, []} = UsingPlugin.init([])
      assert {:ok, [custom: "value"]} = UsingPlugin.init(custom: "value")

      request = %Dox.RequestStruct{
        method: :get,
        url: URI.parse("https://example.com"),
        headers: [],
        body: nil
      }

      {returned_request, state} = UsingPlugin.before_request(request, %{key: "value"})
      assert returned_request == request
      assert state == %{key: "value"}

      response = %Dox.Response{status_code: 200, body: %{}}

      assert {:ok, ^response, state} =
               UsingPlugin.after_response(response, %{key: "value"}, request)

      assert state == %{key: "value"}
    end

    test "default implementations can be overridden" do
      # TestPlugin has custom implementations
      request = %Dox.RequestStruct{
        method: :get,
        url: URI.parse("https://example.com"),
        headers: [],
        body: nil
      }

      {modified, _} = TestPlugin.before_request(request, %{})

      # Custom plugin adds header
      assert {"x-test-plugin", "active"} in modified.headers

      # Default plugin doesn't
      {default, _} = UsingPlugin.before_request(request, %{})
      assert default.headers == []
    end

    test "defines behaviour" do
      # Verify the module declares the behaviour
      assert Dox.Plugin.behaviour_info(:callbacks) |> Keyword.keys() == [
               :init,
               :before_request,
               :after_response
             ]
    end
  end
end
