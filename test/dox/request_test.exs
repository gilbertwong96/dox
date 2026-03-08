defmodule Dox.RequestTest do
  use ExUnit.Case, async: true

  alias Dox.Request

  describe "request/3" do
    test "delegates to configured http client" do
      {:ok, response} = Request.request(:get, "/v2/droplets", token: "test-token")
      assert response.status_code == 200
    end

    test "request with POST method" do
      {:ok, response} = Request.request(:post, "/v2/droplets", token: "test-token")
      assert response.status_code == 200
    end

    test "request with PUT method" do
      {:ok, response} = Request.request(:put, "/v2/droplets/123", token: "test-token")
      assert response.status_code == 200
    end

    test "request with PATCH method" do
      {:ok, response} = Request.request(:patch, "/v2/droplets/123", token: "test-token")
      assert response.status_code == 200
    end

    test "request with DELETE method" do
      {:ok, response} = Request.request(:delete, "/v2/droplets/123", token: "test-token")
      assert response.status_code == 200
    end

    test "request with params option" do
      {:ok, response} =
        Request.request(:get, "/v2/droplets", token: "test-token", params: %{per_page: 10})

      assert response.status_code == 200
    end

    test "request with body option" do
      {:ok, response} =
        Request.request(:post, "/v2/droplets", token: "test-token", body: %{name: "test"})

      assert response.status_code == 200
    end
  end

  describe "request!/3" do
    test "delegates to configured http client and returns response on success" do
      response = Request.request!(:get, "/v2/droplets", token: "test-token")
      assert response.status_code == 200
    end

    test "request! with POST method" do
      response = Request.request!(:post, "/v2/droplets", token: "test-token")
      assert response.status_code == 200
    end
  end
end
