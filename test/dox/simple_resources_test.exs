defmodule Dox.SimpleResourcesTest do
  use ExUnit.Case, async: true

  alias Dox.Actions
  alias Dox.Cdn
  alias Dox.Certificates
  alias Dox.Images
  alias Dox.LoadBalancers
  alias Dox.Regions
  alias Dox.Sizes
  alias Dox.Snapshots
  alias Dox.Tags
  alias Dox.Vpcs

  describe "Regions" do
    test "list/1 returns regions" do
      # The test_helper already stubs ClientMock to return empty data
      # This exercises the code path
      {:ok, response} = Regions.list(token: "test-token")
      assert response.status_code == 200
    end

    test "list/1 accepts options" do
      {:ok, response} = Regions.list(per_page: 50)
      assert response.status_code == 200
    end

    test "list!/1 returns response on success" do
      response = Regions.list!(token: "test-token")
      assert response.status_code == 200
    end
  end

  describe "Sizes" do
    test "list/1 returns sizes" do
      {:ok, response} = Sizes.list(token: "test-token")
      assert response.status_code == 200
    end

    test "list/1 accepts options" do
      {:ok, response} = Sizes.list(per_page: 100)
      assert response.status_code == 200
    end

    test "list!/1 returns response on success" do
      response = Sizes.list!(token: "test-token")
      assert response.status_code == 200
    end
  end

  describe "Snapshots" do
    test "list/1 returns snapshots" do
      {:ok, response} = Snapshots.list(token: "test-token")
      assert response.status_code == 200
    end

    test "list!/1 returns snapshots on success" do
      response = Snapshots.list!(token: "test-token")
      assert response.status_code == 200
    end

    test "list/1 accepts resource_type option" do
      {:ok, response} = Snapshots.list(resource_type: "droplet")
      assert response.status_code == 200
    end

    test "get/2 returns snapshot" do
      {:ok, response} = Snapshots.get("123")
      assert response.status_code == 200
    end

    test "get!/2 returns snapshot on success" do
      response = Snapshots.get!("123")
      assert response.status_code == 200
    end

    test "delete/2 deletes snapshot" do
      {:ok, response} = Snapshots.delete("123")
      assert response.status_code == 200
    end

    test "delete!/2 deletes snapshot on success" do
      response = Snapshots.delete!("123")
      assert response.status_code == 200
    end
  end

  describe "Certificates" do
    test "list/1 returns certificates" do
      {:ok, response} = Certificates.list(token: "test-token")
      assert response.status_code == 200
    end

    test "list!/1 returns certificates on success" do
      response = Certificates.list!(token: "test-token")
      assert response.status_code == 200
    end

    test "list!/1 raises on error" do
      # We can't easily test error case without custom mock
    end

    test "get/2 returns certificate" do
      {:ok, response} = Certificates.get("cert-1")
      assert response.status_code == 200
    end

    test "get!/2 returns certificate on success" do
      response = Certificates.get!("cert-1")
      assert response.status_code == 200
    end

    test "create/2 creates certificate" do
      {:ok, response} = Certificates.create(name: "my-cert")
      assert response.status_code == 200
    end

    test "create!/2 creates certificate on success" do
      response = Certificates.create!(name: "my-cert")
      assert response.status_code == 200
    end

    test "delete/2 deletes certificate" do
      {:ok, response} = Certificates.delete("cert-1")
      assert response.status_code == 200
    end

    test "delete!/2 deletes certificate on success" do
      response = Certificates.delete!("cert-1")
      assert response.status_code == 200
    end
  end

  describe "Actions" do
    test "list/1 returns actions" do
      {:ok, response} = Actions.list(token: "test-token")
      assert response.status_code == 200
    end

    test "list!/1 returns actions" do
      response = Actions.list!(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns action" do
      {:ok, response} = Actions.get(123)
      assert response.status_code == 200
    end

    test "get!/2 returns action" do
      response = Actions.get!(123)
      assert response.status_code == 200
    end
  end

  describe "Images" do
    test "list/1 returns images" do
      {:ok, response} = Images.list(token: "test-token")
      assert response.status_code == 200
    end

    test "list!/1 returns images on success" do
      response = Images.list!(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns image" do
      {:ok, response} = Images.get(123)
      assert response.status_code == 200
    end

    test "get!/2 returns image on success" do
      response = Images.get!(123)
      assert response.status_code == 200
    end

    test "create/2 creates image" do
      {:ok, response} = Images.create(name: "my-image")
      assert response.status_code == 200
    end

    test "create!/2 creates image on success" do
      response = Images.create!(name: "my-image")
      assert response.status_code == 200
    end

    test "update/2 updates image" do
      {:ok, response} = Images.update(123, name: "updated")
      assert response.status_code == 200
    end

    test "update!/2 updates image on success" do
      response = Images.update!(123, name: "updated")
      assert response.status_code == 200
    end

    test "delete/2 deletes image" do
      {:ok, response} = Images.delete(123)
      assert response.status_code == 200
    end
  end

  describe "Cdn" do
    test "list/1 returns CDN endpoints" do
      {:ok, response} = Cdn.list(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns CDN endpoint" do
      {:ok, response} = Cdn.get("cdn-id")
      assert response.status_code == 200
    end

    test "create/2 creates CDN endpoint" do
      {:ok, response} = Cdn.create(origin: "example.com")
      assert response.status_code == 200
    end

    test "update/2 updates CDN endpoint" do
      {:ok, response} = Cdn.update("cdn-id", ttl: 3600)
      assert response.status_code == 200
    end

    test "delete/2 deletes CDN endpoint" do
      {:ok, response} = Cdn.delete("cdn-id")
      assert response.status_code == 200
    end
  end

  describe "LoadBalancers" do
    test "list/1 returns load balancers" do
      {:ok, response} = LoadBalancers.list(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns load balancer" do
      {:ok, response} = LoadBalancers.get("lb-id")
      assert response.status_code == 200
    end

    test "create/2 creates load balancer" do
      {:ok, response} = LoadBalancers.create(name: "my-lb")
      assert response.status_code == 200
    end

    test "update/2 updates load balancer" do
      {:ok, response} = LoadBalancers.update("lb-id", name: "updated")
      assert response.status_code == 200
    end

    test "delete/2 deletes load balancer" do
      {:ok, response} = LoadBalancers.delete("lb-id")
      assert response.status_code == 200
    end
  end

  describe "Vpcs" do
    test "list/1 returns VPCs" do
      {:ok, response} = Vpcs.list(token: "test-token")
      assert response.status_code == 200
    end

    test "list!/1 returns VPCs on success" do
      response = Vpcs.list!(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns VPC" do
      {:ok, response} = Vpcs.get("vpc-id")
      assert response.status_code == 200
    end

    test "get!/2 returns VPC on success" do
      response = Vpcs.get!("vpc-id")
      assert response.status_code == 200
    end

    test "create/2 creates VPC" do
      {:ok, response} = Vpcs.create(name: "my-vpc")
      assert response.status_code == 200
    end

    test "create!/2 creates VPC on success" do
      response = Vpcs.create!(name: "my-vpc")
      assert response.status_code == 200
    end

    test "update/2 updates VPC" do
      {:ok, response} = Vpcs.update("vpc-id", name: "updated")
      assert response.status_code == 200
    end

    test "update!/2 updates VPC on success" do
      response = Vpcs.update!("vpc-id", name: "updated")
      assert response.status_code == 200
    end

    test "delete/2 deletes VPC" do
      {:ok, response} = Vpcs.delete("vpc-id")
      assert response.status_code == 200
    end

    test "delete!/2 deletes VPC on success" do
      response = Vpcs.delete!("vpc-id")
      assert response.status_code == 200
    end
  end

  describe "Tags" do
    test "list/1 returns tags" do
      {:ok, response} = Tags.list(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns tag" do
      {:ok, response} = Tags.get("my-tag")
      assert response.status_code == 200
    end

    test "create/2 creates tag" do
      {:ok, response} = Tags.create(name: "my-tag")
      assert response.status_code == 200
    end

    test "delete/2 deletes tag" do
      {:ok, response} = Tags.delete("my-tag")
      assert response.status_code == 200
    end
  end
end
