defmodule Dox.ErrorTest do
  use ExUnit.Case, async: true

  alias Dox.Error

  describe "new/2" do
    test "creates an error with message" do
      error = Error.new("Something went wrong")
      assert error.message == "Something went wrong"
      assert error.status_code == nil
      assert error.response == nil
      assert error.reason == nil
    end

    test "creates an error with options" do
      error =
        Error.new("Error",
          status_code: 404,
          response: %{"error" => "Not found"},
          reason: :api_error
        )

      assert error.status_code == 404
      assert error.response == %{"error" => "Not found"}
      assert error.reason == :api_error
    end
  end

  describe "from_response/1" do
    test "creates error from response with error and message keys" do
      error = Error.from_response(%{"error" => "invalid", "message" => "Invalid request"})
      assert error.message == "Invalid request"
      assert error.reason == :api_error
    end

    test "creates error from response with errors list" do
      error =
        Error.from_response(%{
          "errors" => [%{"message" => "Name is required"}, %{"message" => "Email is required"}]
        })

      assert error.message == "Name is required; Email is required"
      assert error.reason == :api_error
    end

    test "creates error from response with id and message keys" do
      error = Error.from_response(%{"id" => "not_found", "message" => "Resource not found"})
      assert error.message == "not_found: Resource not found"
      assert error.reason == :api_error
    end

    test "creates error from unknown response" do
      error = Error.from_response(%{"unknown" => "data"})
      assert error.message == "Unknown error"
      assert error.response == %{"unknown" => "data"}
      assert error.reason == :unknown
    end
  end

  describe "from_status/2" do
    test "creates error for timeout" do
      error = Error.from_status(0, :timeout)
      assert error.message == "Request timed out"
      assert error.status_code == 0
      assert error.reason == :timeout
    end

    test "creates error for connect_timeout" do
      error = Error.from_status(0, :connect_timeout)
      assert error.message == "Connection timed out"
      assert error.reason == :connect_timeout
    end

    test "creates error for econnrefused" do
      error = Error.from_status(0, :econnrefused)
      assert error.message == "Connection refused"
      assert error.reason == :econnrefused
    end

    test "creates error for econnreset" do
      error = Error.from_status(0, :econnreset)
      assert error.message == "Connection reset"
      assert error.reason == :econnreset
    end

    test "creates error for nxdomain" do
      error = Error.from_status(0, :nxdomain)
      assert error.message == "Host not found"
      assert error.reason == :nxdomain
    end

    test "creates generic HTTP error for unknown reasons" do
      error = Error.from_status(500, :some_error)
      assert error.message == "HTTP error 500"
      assert error.status_code == 500
      assert error.reason == :some_error
    end
  end

  describe "String.Chars implementation" do
    test "converts error to string" do
      error = Error.new("Not found", status_code: 404)
      assert to_string(error) == "Not found"
    end
  end
end
