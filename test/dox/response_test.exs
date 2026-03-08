defmodule Dox.ResponseTest do
  use ExUnit.Case, async: true

  alias Dox.Response

  describe "new/4" do
    test "creates a response with body, headers, and status" do
      response = Response.new(%{"data" => []}, [{"content-type", "application/json"}], 200)
      assert response.body == %{"data" => []}
      assert response.headers == [{"content-type", "application/json"}]
      assert response.status_code == 200
    end

    test "creates a response with optional request" do
      request = %{method: :get, url: "https://api.digitalocean.com/v2/droplets"}
      response = Response.new(%{"data" => []}, [], 200, request)
      assert response.request == request
    end

    test "creates a response without request (defaults to empty map)" do
      response = Response.new(%{"data" => []}, [], 200)
      assert response.request == %{}
    end
  end

  describe "data/1" do
    test "extracts data from response body" do
      response = Response.new(%{"data" => [%{"id" => 1}]}, [], 200)
      assert Response.data(response) == [%{"id" => 1}]
    end

    test "returns body as-is when data key not present" do
      response = Response.new(%{"droplet" => %{}}, [], 200)
      assert Response.data(response) == %{"droplet" => %{}}
    end
  end

  describe "meta/1" do
    test "extracts meta from response body" do
      response =
        Response.new(%{"data" => [], "meta" => %{"page" => 1, "per_page" => 25}}, [], 200)

      assert Response.meta(response) == %{"page" => 1, "per_page" => 25}
    end

    test "returns empty map when meta not present" do
      response = Response.new(%{"data" => []}, [], 200)
      assert Response.meta(response) == %{}
    end
  end

  describe "links/1" do
    test "extracts links from response body" do
      response =
        Response.new(%{"data" => [], "links" => %{"pages" => %{"next" => "page=2"}}}, [], 200)

      assert Response.links(response) == %{"pages" => %{"next" => "page=2"}}
    end

    test "returns empty map when links not present" do
      response = Response.new(%{"data" => []}, [], 200)
      assert Response.links(response) == %{}
    end
  end

  describe "success?/1" do
    test "returns true for 2xx status codes" do
      assert Response.success?(%Response{status_code: 200}) == true
      assert Response.success?(%Response{status_code: 201}) == true
      assert Response.success?(%Response{status_code: 299}) == true
    end

    test "returns false for non-2xx status codes" do
      assert Response.success?(%Response{status_code: 400}) == false
      assert Response.success?(%Response{status_code: 404}) == false
      assert Response.success?(%Response{status_code: 500}) == false
    end
  end

  describe "error?/1" do
    test "returns true for 4xx and 5xx status codes" do
      assert Response.error?(%Response{status_code: 400}) == true
      assert Response.error?(%Response{status_code: 404}) == true
      assert Response.error?(%Response{status_code: 500}) == true
    end

    test "returns false for 2xx and 3xx status codes" do
      assert Response.error?(%Response{status_code: 200}) == false
      assert Response.error?(%Response{status_code: 301}) == false
    end
  end
end
