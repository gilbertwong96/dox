defmodule Dox.AccountTest do
  use ExUnit.Case, async: true

  alias Dox.Account

  describe "Dox.Account" do
    test "get/1 returns account info" do
      {:ok, response} = Account.get(token: "test-token")
      assert response.status_code == 200
    end

    test "get!/1 returns account info on success" do
      response = Account.get!(token: "test-token")
      assert response.status_code == 200
    end

    test "list_keys/1 returns SSH keys" do
      {:ok, response} = Account.list_keys(token: "test-token")
      assert response.status_code == 200
    end

    test "list_keys!/1 returns SSH keys on success" do
      response = Account.list_keys!(token: "test-token")
      assert response.status_code == 200
    end

    test "get_key/2 returns SSH key" do
      {:ok, response} = Account.get_key("key-id", token: "test-token")
      assert response.status_code == 200
    end

    test "get_key!/2 returns SSH key on success" do
      response = Account.get_key!("key-id", token: "test-token")
      assert response.status_code == 200
    end
  end
end
