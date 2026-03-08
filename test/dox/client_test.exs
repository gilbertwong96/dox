defmodule Dox.ClientTest do
  use ExUnit.Case, async: true

  alias Dox.Client

  describe "http_client/0" do
    test "returns the http client module" do
      client = Client.http_client()
      assert client != nil
    end

    test "returns configured mock in test env" do
      assert Client.http_client() == Dox.ClientMock
    end
  end

  describe "token handling" do
    test "raises when no token is provided" do
      assert_raise RuntimeError, fn ->
        Client.request(:get, "/v2/droplets")
      end
    end

    test "raises when token in opts is nil" do
      assert_raise RuntimeError, fn ->
        Client.request(:get, "/v2/droplets", token: nil)
      end
    end
  end
end
