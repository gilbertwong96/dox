defmodule Dox.Kubernetes do
  @moduledoc """
  DigitalOcean Kubernetes API client.

  ## Usage

    Dox.Kubernetes.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all Kubernetes clusters on your account.

  ## Parameters
  - `opts` - Optional parameters including `token`, `page`, `per_page`

  ## Examples

    Dox.Kubernetes.list_clusters(token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with an array of Kubernetes clusters containing `id`, `name`, `region`, `version`, `status`, `node_pools`
  """
  def list_clusters(opts \\ []) do
    Request.request(:get, "/v2/kubernetes/clusters", opts)
  end

  @doc """
  Same as `list_clusters/1` but raises on error.
  """
  def list_clusters!(opts \\ []) do
    case list_clusters(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create a new Kubernetes cluster.

  The request must contain at least one node pool with at least one worker. The request may contain a maintenance window policy describing a time period when disruptive maintenance tasks may be carried out.

  ## Parameters
  - `opts` - Optional parameters including `token`. Body should include `name`, `region`, `version`, `node_pools`

  ## Examples

    Dox.Kubernetes.create_cluster(token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the created Kubernetes cluster containing `id`, `name`, `region`, `version`, `endpoint`, `node_pools`, `maintenance_policy`
  """
  def create_cluster(opts \\ []) do
    Request.request(:post, "/v2/kubernetes/clusters", opts)
  end

  @doc """
  Same as `create_cluster/1` but raises on error.
  """
  def create_cluster!(opts \\ []) do
    case create_cluster(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an existing Kubernetes cluster.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.get_cluster("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the Kubernetes cluster containing `id`, `name`, `region`, `version`, `endpoint`, `node_pools`, `maintenance_policy`, `status`, `auto_upgrade`
  """
  def get_cluster(cluster_id, opts \\ []) do
    Request.request(:get, "/v2/kubernetes/clusters/#{cluster_id}", opts)
  end

  @doc """
  Same as `get_cluster/2` but raises on error.
  """
  def get_cluster!(cluster_id, opts \\ []) do
    case get_cluster(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a Kubernetes cluster.

  A 204 status code with no body will be returned in response to a successful request.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.delete_cluster("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with no content (204 status)
  """
  def delete_cluster(cluster_id, opts \\ []) do
    Request.request(:delete, "/v2/kubernetes/clusters/#{cluster_id}", opts)
  end

  @doc """
  Same as `delete_cluster/2` but raises on error.
  """
  def delete_cluster!(cluster_id, opts \\ []) do
    case delete_cluster(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update a Kubernetes cluster.

  Update the cluster's name, tags, maintenance policy, auto-upgrade, surge upgrade, or HA settings.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`. Body can include `name`, `tags`, `maintenance_policy`, `auto_upgrade`, `surge_upgrade`, `ha`

  ## Examples

    Dox.Kubernetes.update_cluster("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the updated Kubernetes cluster containing `id`, `name`, `region`, `version`, `maintenance_policy`, `auto_upgrade`, `surge_upgrade`, `ha`
  """
  def update_cluster(cluster_id, opts \\ []) do
    Request.request(:put, "/v2/kubernetes/clusters/#{cluster_id}", opts)
  end

  @doc """
  Same as `update_cluster/2` but raises on error.
  """
  def update_cluster!(cluster_id, opts \\ []) do
    case update_cluster(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve the kubeconfig for a Kubernetes cluster.

  Returns a kubeconfig file in YAML format that can be used to connect to and administer the cluster using kubectl. The resulting kubeconfig uses token-based authentication for clusters supporting it, and certificate-based authentication otherwise.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`, `expiry_seconds` (duration in seconds for token expiry, defaults to 7 days)

  ## Examples

    Dox.Kubernetes.kubeconfig("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the kubeconfig YAML content
  """
  def kubeconfig(cluster_id, opts \\ []) do
    Request.request(:get, "/v2/kubernetes/clusters/#{cluster_id}/kubeconfig", opts)
  end

  @doc """
  Same as `kubeconfig/2` but raises on error.
  """
  def kubeconfig!(cluster_id, opts \\ []) do
    case kubeconfig(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve credentials for a Kubernetes cluster.

  Returns a JSON object that can be used to programmatically construct Kubernetes clients which cannot parse kubeconfig files. Contains token-based authentication for clusters supporting it, and certificate-based authentication otherwise.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`, `expiry_seconds` (duration in seconds for token expiry, defaults to 7 days)

  ## Examples

    Dox.Kubernetes.credentials("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with JSON object containing `token`, `certificate`, `ca_cert`, and `endpoint`
  """
  def credentials(cluster_id, opts \\ []) do
    Request.request(:get, "/v2/kubernetes/clusters/#{cluster_id}/credentials", opts)
  end

  @doc """
  Same as `credentials/2` but raises on error.
  """
  def credentials!(cluster_id, opts \\ []) do
    case credentials(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all node pools in a Kubernetes cluster.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.list_node_pools("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with an array of node pools containing `id`, `name`, `size`, `count`, `tags`, `labels`, `auto_scale`, `min_nodes`, `max_nodes`, `nodes`
  """
  def list_node_pools(cluster_id, opts \\ []) do
    Request.request(:get, "/v2/kubernetes/clusters/#{cluster_id}/node_pools", opts)
  end

  @doc """
  Same as `list_node_pools/2` but raises on error.
  """
  def list_node_pools!(cluster_id, opts \\ []) do
    case list_node_pools(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Add a node pool to a Kubernetes cluster.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`. Body should include `name`, `size`, `count`, and optionally `tags`, `labels`, `auto_scale`, `min_nodes`, `max_nodes`

  ## Examples

    Dox.Kubernetes.create_node_pool("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the created node pool containing `id`, `name`, `size`, `count`, `tags`, `labels`, `auto_scale`, `min_nodes`, `max_nodes`, `nodes`
  """
  def create_node_pool(cluster_id, opts \\ []) do
    Request.request(:post, "/v2/kubernetes/clusters/#{cluster_id}/node_pools", opts)
  end

  @doc """
  Same as `create_node_pool/2` but raises on error.
  """
  def create_node_pool!(cluster_id, opts \\ []) do
    case create_node_pool(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve a node pool for a Kubernetes cluster.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `node_pool_id` - The unique ID of the node pool
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.get_node_pool("cluster_id", "node_pool_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the node pool containing `id`, `name`, `size`, `count`, `tags`, `labels`, `auto_scale`, `min_nodes`, `max_nodes`, `nodes`
  """
  def get_node_pool(cluster_id, node_pool_id, opts \\ []) do
    Request.request(
      :get,
      "/v2/kubernetes/clusters/#{cluster_id}/node_pools/#{node_pool_id}",
      opts
    )
  end

  @doc """
  Same as `get_node_pool/3` but raises on error.
  """
  def get_node_pool!(cluster_id, node_pool_id, opts \\ []) do
    case get_node_pool(cluster_id, node_pool_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update a node pool in a Kubernetes cluster.

  Update the name of a node pool, edit the tags applied to it, adjust its number of nodes, or modify auto-scaling settings.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `node_pool_id` - The unique ID of the node pool
  - `opts` - Optional parameters including `token`. Body can include `name`, `count`, `tags`, `labels`, `auto_scale`, `min_nodes`, `max_nodes`

  ## Examples

    Dox.Kubernetes.update_node_pool("cluster_id", "node_pool_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the updated node pool containing `id`, `name`, `size`, `count`, `tags`, `labels`, `auto_scale`, `min_nodes`, `max_nodes`, `nodes`
  """
  def update_node_pool(cluster_id, node_pool_id, opts \\ []) do
    Request.request(
      :put,
      "/v2/kubernetes/clusters/#{cluster_id}/node_pools/#{node_pool_id}",
      opts
    )
  end

  @doc """
  Same as `update_node_pool/3` but raises on error.
  """
  def update_node_pool!(cluster_id, node_pool_id, opts \\ []) do
    case update_node_pool(cluster_id, node_pool_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a node pool from a Kubernetes cluster.

  A 204 status code with no body will be returned in response to a successful request. Nodes in the pool will subsequently be drained and deleted.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `node_pool_id` - The unique ID of the node pool
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.delete_node_pool("cluster_id", "node_pool_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with no content (204 status)
  """
  def delete_node_pool(cluster_id, node_pool_id, opts \\ []) do
    Request.request(
      :delete,
      "/v2/kubernetes/clusters/#{cluster_id}/node_pools/#{node_pool_id}",
      opts
    )
  end

  @doc """
  Same as `delete_node_pool/3` but raises on error.
  """
  def delete_node_pool!(cluster_id, node_pool_id, opts \\ []) do
    case delete_node_pool(cluster_id, node_pool_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all nodes in a node pool.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `node_pool_id` - The unique ID of the node pool
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.list_nodes("cluster_id", "node_pool_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with an array of nodes containing `id`, `name`, `status`, `droplet_id`, `created_at`, `updated_at`
  """
  def list_nodes(cluster_id, node_pool_id, opts \\ []) do
    Request.request(
      :get,
      "/v2/kubernetes/clusters/#{cluster_id}/node_pools/#{node_pool_id}/nodes",
      opts
    )
  end

  @doc """
  Same as `list_nodes/3` but raises on error.
  """
  def list_nodes!(cluster_id, node_pool_id, opts \\ []) do
    case list_nodes(cluster_id, node_pool_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve available upgrades for an existing Kubernetes cluster.

  Determine whether a cluster can be upgraded and the versions to which it can be upgraded.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.list_upgrades("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with an array of available upgrade versions
  """
  def list_upgrades(cluster_id, opts \\ []) do
    Request.request(:get, "/v2/kubernetes/clusters/#{cluster_id}/upgrades", opts)
  end

  @doc """
  Same as `list_upgrades/2` but raises on error.
  """
  def list_upgrades!(cluster_id, opts \\ []) do
    case list_upgrades(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Upgrade a Kubernetes cluster to a newer patch release.

  Immediately upgrade a Kubernetes cluster to a newer patch release of Kubernetes. The body of the request must specify a version attribute.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`. Body should include `version` (the slug identifier for the target Kubernetes version)

  ## Examples

    Dox.Kubernetes.upgrade_cluster("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the upgraded Kubernetes cluster
  """
  def upgrade_cluster(cluster_id, opts \\ []) do
    Request.request(:post, "/v2/kubernetes/clusters/#{cluster_id}/upgrade", opts)
  end

  @doc """
  Same as `upgrade_cluster/2` but raises on error.
  """
  def upgrade_cluster!(cluster_id, opts \\ []) do
    case upgrade_cluster(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get the maintenance policy for a Kubernetes cluster.

  Retrieve the maintenance window policy for the cluster, which specifies when disruptive maintenance tasks may be carried out.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.maintenance_policy("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the maintenance policy containing `start_time`, `duration`, `day`
  """
  def maintenance_policy(cluster_id, opts \\ []) do
    Request.request(:get, "/v2/kubernetes/clusters/#{cluster_id}/maintenance_policy", opts)
  end

  @doc """
  Same as `maintenance_policy/2` but raises on error.
  """
  def maintenance_policy!(cluster_id, opts \\ []) do
    case maintenance_policy(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update the maintenance policy for a Kubernetes cluster.

  Update the maintenance window policy specifying when disruptive maintenance tasks may be carried out.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`. Body should include `start_time` and `day`

  ## Examples

    Dox.Kubernetes.update_maintenance_policy("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the updated maintenance policy containing `start_time`, `duration`, `day`
  """
  def update_maintenance_policy(cluster_id, opts \\ []) do
    Request.request(:put, "/v2/kubernetes/clusters/#{cluster_id}/maintenance_policy", opts)
  end

  @doc """
  Same as `update_maintenance_policy/2` but raises on error.
  """
  def update_maintenance_policy!(cluster_id, opts \\ []) do
    case update_maintenance_policy(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get available options for a specific Kubernetes cluster.

  Retrieve the available versions, regions, and node sizes that can be used when creating or updating a cluster.

  ## Parameters
  - `cluster_id` - The unique ID of the Kubernetes cluster
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.options("cluster_id", token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with available options including `versions`, `regions`, `sizes`
  """
  def options(cluster_id, opts \\ []) do
    Request.request(:get, "/v2/kubernetes/clusters/#{cluster_id}/options", opts)
  end

  @doc """
  Same as `options/2` but raises on error.
  """
  def options!(cluster_id, opts \\ []) do
    case options(cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List available regions, node sizes, and versions of Kubernetes.

  To list the versions of Kubernetes available for use, the regions that support Kubernetes, and the available node sizes, send a GET request.

  ## Parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Kubernetes.list_options(token: "your_token")
    #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with available options including `versions`, `regions`, `sizes`
  """
  def list_options(opts \\ []) do
    Request.request(:get, "/v2/kubernetes/options", opts)
  end

  @doc """
  Same as `list_options/1` but raises on error.
  """
  def list_options!(opts \\ []) do
    case list_options(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
