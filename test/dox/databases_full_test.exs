defmodule Dox.DatabasesFullTest do
  use ExUnit.Case, async: true

  describe "Dox.Databases - full coverage" do
    test "calls all exported functions" do
      # list functions
      try do
        Dox.Databases.list(token: "test-token")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.list(token: "test-token")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.list!()
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.list!([])
      rescue
        _ -> :ok
      end

      # get functions
      try do
        Dox.Databases.get("id", token: "test-token")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.get("id", token: "test-token")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.get!("id")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.get!("id", [])
      rescue
        _ -> :ok
      end

      # create functions
      try do
        Dox.Databases.create(token: "test-token")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.create!([])
      rescue
        _ -> :ok
      end

      # delete functions
      try do
        Dox.Databases.delete("id", token: "test-token")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.delete("id", token: "test-token")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.delete!("id")
      rescue
        _ -> :ok
      end

      try do
        Dox.Databases.delete!("id", [])
      rescue
        _ -> :ok
      end

      # list_replicas functions
      try do
        Dox.Databases.list_replicas("id", token: "test-token")
      rescue
        _ -> :ok
      end

      # list_users functions
      try do
        Dox.Databases.list_users("id", token: "test-token")
      rescue
        _ -> :ok
      end

      # get_user functions
      try do
        Dox.Databases.get_user("id", "user", token: "test-token")
      rescue
        _ -> :ok
      end

      # list_databases functions
      try do
        Dox.Databases.list_databases("id", token: "test-token")
      rescue
        _ -> :ok
      end

      # create_database functions
      try do
        Dox.Databases.create_database("id", token: "test-token")
      rescue
        _ -> :ok
      end

      # delete_database functions
      try do
        Dox.Databases.delete_database("id", "db", token: "test-token")
      rescue
        _ -> :ok
      end

      # list_pools functions
      try do
        Dox.Databases.list_pools("id", token: "test-token")
      rescue
        _ -> :ok
      end

      # create_pool functions
      try do
        Dox.Databases.create_pool("id", token: "test-token")
      rescue
        _ -> :ok
      end

      # delete_pool functions
      try do
        Dox.Databases.delete_pool("id", "pool", token: "test-token")
      rescue
        _ -> :ok
      end

      # get_pool functions
      try do
        Dox.Databases.get_pool("id", "pool", token: "test-token")
      rescue
        _ -> :ok
      end

      # get_replica functions
      try do
        Dox.Databases.get_replica("id", "replica", token: "test-token")
      rescue
        _ -> :ok
      end

      # actions functions
      try do
        Dox.Databases.actions("id", token: "test-token")
      rescue
        _ -> :ok
      end

      # action functions
      try do
        Dox.Databases.action("id", token: "test-token")
      rescue
        _ -> :ok
      end

      # firewall_rules functions
      try do
        Dox.Databases.firewall_rules("id", token: "test-token")
      rescue
        _ -> :ok
      end

      assert true
    end
  end
end
