defmodule Dox.DropletsTest do
  use ExUnit.Case, async: true

  alias Dox.Droplets

  describe "Dox.Droplets.list/1" do
    test "returns droplets list" do
      assert {:ok, response} = Droplets.list(token: "test_token")
      assert response.body == %{"data" => []}
    end

    test "list!/1 returns on success" do
      response = Droplets.list!(token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.get/2" do
    test "returns droplet by id" do
      assert {:ok, response} = Droplets.get(123, token: "test_token")
      assert response.body == %{"data" => []}
    end

    test "get!/2 returns on success" do
      response = Droplets.get!(123, token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.create/1" do
    test "creates a droplet" do
      assert {:ok, response} =
               Droplets.create(
                 name: "new-droplet",
                 region: "nyc1",
                 token: "test_token"
               )

      assert response.body == %{"data" => []}
    end

    test "create!/1 returns on success" do
      response =
        Droplets.create!(
          name: "new-droplet",
          region: "nyc1",
          token: "test_token"
        )

      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.delete/2" do
    test "deletes a droplet" do
      assert {:ok, _response} = Droplets.delete(123, token: "test_token")
    end

    test "delete!/2 returns on success" do
      response = Droplets.delete!(123, token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.delete_by_tag/2" do
    test "deletes droplets by tag" do
      assert {:ok, _response} = Droplets.delete_by_tag("my-tag", token: "test_token")
    end

    test "delete_by_tag!/2 returns on success" do
      response = Droplets.delete_by_tag!("my-tag", token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.list_all/1" do
    test "returns all droplets" do
      assert {:ok, response} = Droplets.list_all(token: "test_token")
      assert response.body == %{"data" => []}
    end

    test "list_all!/1 returns on success" do
      response = Droplets.list_all!(token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.neighbor_ids/2" do
    test "returns neighbor ids" do
      assert {:ok, response} = Droplets.neighbor_ids(123, token: "test_token")
      assert response.body == %{"data" => []}
    end

    test "neighbor_ids!/2 returns on success" do
      response = Droplets.neighbor_ids!(123, token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.create_by_tag/2" do
    test "creates droplets by tag" do
      assert {:ok, _response} = Droplets.create_by_tag("my-tag", token: "test_token")
    end

    test "create_by_tag!/2 returns on success" do
      response = Droplets.create_by_tag!("my-tag", token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.kernels/2" do
    test "returns kernels" do
      assert {:ok, response} = Droplets.kernels(123, token: "test_token")
      assert response.body == %{"data" => []}
    end

    test "kernels!/2 returns on success" do
      response = Droplets.kernels!(123, token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.snapshots/2" do
    test "returns snapshots" do
      assert {:ok, response} = Droplets.snapshots(123, token: "test_token")
      assert response.body == %{"data" => []}
    end

    test "snapshots!/2 returns on success" do
      response = Droplets.snapshots!(123, token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.backups/2" do
    test "returns backups" do
      assert {:ok, response} = Droplets.backups(123, token: "test_token")
      assert response.body == %{"data" => []}
    end

    test "backups!/2 returns on success" do
      response = Droplets.backups!(123, token: "test_token")
      assert response.body == %{"data" => []}
    end
  end

  describe "Dox.Droplets.actions/2" do
    test "returns actions" do
      assert {:ok, response} = Droplets.actions(123, token: "test_token")
      assert response.body == %{"data" => []}
    end

    test "actions!/2 returns on success" do
      response = Droplets.actions!(123, token: "test_token")
      assert response.body == %{"data" => []}
    end
  end
end
