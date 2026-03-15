defmodule Dox.ResponseTest do
  use ExUnit.Case, async: true

  alias Dox.Response

  describe "new/4" do
    test "creates a response with body, status, and rate limit info" do
      headers = [
        {"ratelimit-limit", "5000"},
        {"ratelimit-remaining", "4999"},
        {"ratelimit-reset", "1234567890"}
      ]

      response = Response.new(%{"data" => []}, headers, 200)

      assert response.body == %{"data" => []}
      assert response.status_code == 200
      assert response.rate_limit == 5000
      assert response.rate_remaining == 4999
      assert response.rate_reset == 1_234_567_890
    end

    test "creates a response with default rate limit values when headers missing" do
      response = Response.new(%{"data" => []}, [], 200)

      assert response.body == %{"data" => []}
      assert response.status_code == 200
      assert response.rate_limit == nil
      assert response.rate_remaining == nil
      assert response.rate_reset == nil
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

  describe "rate_limit_info/1" do
    test "returns rate limit information" do
      response = %Response{
        body: %{},
        status_code: 200,
        rate_limit: 5000,
        rate_remaining: 4999,
        rate_reset: 1_234_567_890
      }

      assert Response.rate_limit_info(response) == %{
               limit: 5000,
               remaining: 4999,
               reset: 1_234_567_890
             }
    end
  end

  describe "near_rate_limit?/1" do
    test "returns true when near rate limit threshold" do
      response = %Response{
        body: %{},
        status_code: 200,
        rate_limit: 5000,
        rate_remaining: 50,
        rate_reset: 1_234_567_890
      }

      assert Response.near_rate_limit?(response, 100) == true
    end

    test "returns false when not near rate limit" do
      response = %Response{
        body: %{},
        status_code: 200,
        rate_limit: 5000,
        rate_remaining: 4999,
        rate_reset: 1_234_567_890
      }

      assert Response.near_rate_limit?(response, 100) == false
    end

    test "returns false when rate_remaining is nil" do
      response = %Response{
        body: %{},
        status_code: 200,
        rate_limit: nil,
        rate_remaining: nil,
        rate_reset: nil
      }

      assert Response.near_rate_limit?(response, 100) == false
    end
  end
end
