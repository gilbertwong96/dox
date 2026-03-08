defmodule Dox.KubernetesTest do
  use ExUnit.Case, async: true

  alias Dox.Kubernetes

  describe "Dox.Kubernetes" do
    test "list_clusters/1 returns clusters" do
      {:ok, response} = Kubernetes.list_clusters(token: "test-token")
      assert response.status_code == 200
    end

    test "get_cluster/2 returns cluster" do
      {:ok, response} = Kubernetes.get_cluster("cluster-id", token: "test-token")
      assert response.status_code == 200
    end
  end
end
