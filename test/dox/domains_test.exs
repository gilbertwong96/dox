defmodule Dox.DomainsTest do
  use ExUnit.Case, async: true

  alias Dox.Domains

  describe "Dox.Domains" do
    test "list/1 returns domains" do
      {:ok, response} = Domains.list(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns domain" do
      {:ok, response} = Domains.get("example.com", token: "test-token")
      assert response.status_code == 200
    end
  end
end
