defmodule Dox.Databases do
  @moduledoc """
  DigitalOcean Databases API client.

  ## Usage

    Dox.Databases.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all database clusters available on your account.

  To list all of the database clusters available on your account, send a GET request to `/v2/databases`.
  To limit the results to database clusters with a specific tag, include the `tag_name` query parameter.
  The result will be a JSON object with a `databases` key containing an array of database objects.
  The embedded `connection` and `private_connection` objects contain the information needed to access the database cluster.
  For multi-node clusters, the `standby_connection` and `standby_private_connection` objects contain information for standby nodes.

  ## Parameters
  - `opts` - Optional parameters including `token` and `tag_name`

  ## Examples

      Dox.Databases.list(token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `databases` array containing cluster information (id, name, engine, region, status, etc.)
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/databases", opts)
  end

  @doc """
  Same as `list/1` but raises on error.
  """
  def list!(opts \\ []) do
    case list(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create a new database cluster.

  To create a database cluster, send a POST request to `/v2/databases`. To see available options for each engine, such as regions, size slugs, and versions, send a GET request to `/v2/databases/options`.
  The create response returns a JSON object with a key called `database`. The initial value of the cluster's `status` attribute is `creating`. When the cluster is ready to receive traffic, this changes to `online`.
  DigitalOcean managed PostgreSQL and MySQL database clusters take automated daily backups.

  ## Parameters
  - `opts` - Optional parameters including `token`, `name`, `engine`, `version`, `region`, `size`, `num_nodes`, etc.

  ## Examples

      Dox.Databases.create(token: "your_token", name: "my-database", engine: "pg", version: "15", region: "nyc1", size: "db-s-2vcpu-4gb")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `database` object containing cluster information
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/databases", opts)
  end

  @doc """
  Same as `create/1` but raises on error.
  """
  def create!(opts \\ []) do
    case create(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an existing database cluster.

  To show information about an existing database cluster, send a GET request to `/v2/databases/$DATABASE_ID`.
  The response will be a JSON object with a database key containing standard database cluster attributes.
  The embedded `connection` and `private_connection` objects contain the information needed to access the database cluster.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.get("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `database` object containing cluster details
  """
  def get(database_cluster_id, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(database_cluster_id, opts \\ []) do
    case get(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Destroy a database cluster.

  To destroy a specific database, send a DELETE request to `/v2/databases/$DATABASE_ID`.
  A status of 204 will be returned, indicating that the request was processed successfully with no response body.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster to delete
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.delete("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with empty body on success (204 No Content)
  """
  def delete(database_cluster_id, opts \\ []) do
    Request.request(:delete, "/v2/databases/#{database_cluster_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(database_cluster_id, opts \\ []) do
    case delete(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all database users.

  To list all of the users for your database cluster, send a GET request to `/v2/databases/$DATABASE_ID/users`.
  Note: User management is not supported for Caching or Valkey clusters.
  The result will be a JSON object with a `users` key containing an array of database user objects.
  User passwords will not show without the `database:view_credentials` scope.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.list_users("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `users` array containing user information
  """
  def list_users(database_cluster_id, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/users", opts)
  end

  @doc """
  Same as `list_users/2` but raises on error.
  """
  def list_users!(database_cluster_id, opts \\ []) do
    case list_users(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create a database user.

  To create a new database user, send a POST request to `/v2/databases/$DATABASE_ID/users`.
  Note: User management is not supported for Caching or Valkey clusters.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token` and `name` (username)

  ## Examples

      Dox.Databases.create_user("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token", name: "newuser")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `user` object containing the created user details
  """
  def create_user(database_cluster_id, opts \\ []) do
    Request.request(:post, "/v2/databases/#{database_cluster_id}/users", opts)
  end

  @doc """
  Same as `create_user/2` but raises on error.
  """
  def create_user!(database_cluster_id, opts \\ []) do
    case create_user(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an existing database user.

  To show information about an existing database user, send a GET request to `/v2/databases/$DATABASE_ID/users/$USERNAME`.
  Note: User management is not supported for Caching or Valkey clusters.
  The user's password will not show unless the `database:view_credentials` scope is present.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `username` - The username of the user to retrieve
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.get_user("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", "doadmin", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `user` object containing user details
  """
  def get_user(database_cluster_id, username, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/users/#{username}", opts)
  end

  @doc """
  Same as `get_user/3` but raises on error.
  """
  def get_user!(database_cluster_id, username, opts \\ []) do
    case get_user(database_cluster_id, username, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Remove a database user.

  To remove a specific database user, send a DELETE request to `/v2/databases/$DATABASE_ID/users/$USERNAME`.
  Note: User management is not supported for Caching or Valkey clusters.
  A status of 204 will be given, indicating that the request was processed successfully with no response body.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `username` - The username of the user to delete
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.delete_user("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", "doadmin", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with empty body on success (204 No Content)
  """
  def delete_user(database_cluster_id, username, opts \\ []) do
    Request.request(:delete, "/v2/databases/#{database_cluster_id}/users/#{username}", opts)
  end

  @doc """
  Same as `delete_user/3` but raises on error.
  """
  def delete_user!(database_cluster_id, username, opts \\ []) do
    case delete_user(database_cluster_id, username, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all databases in a cluster.

  To list all of the databases in a cluster, send a GET request to `/v2/databases/$DATABASE_ID/dbs`.
  Note: Database management is not supported for Caching or Valkey clusters.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.list_databases("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `dbs` array containing database information
  """
  def list_databases(database_cluster_id, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/dbs", opts)
  end

  @doc """
  Same as `list_databases/2` but raises on error.
  """
  def list_databases!(database_cluster_id, opts \\ []) do
    case list_databases(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Add a new database to a cluster.

  To add a new database to an existing cluster, send a POST request to `/v2/databases/$DATABASE_ID/dbs`.
  Note: Database management is not supported for Caching or Valkey clusters.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token` and `name` (database name)

  ## Examples

      Dox.Databases.create_database("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token", name: "mydb")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `db` object containing the created database details
  """
  def create_database(database_cluster_id, opts \\ []) do
    Request.request(:post, "/v2/databases/#{database_cluster_id}/dbs", opts)
  end

  @doc """
  Same as `create_database/2` but raises on error.
  """
  def create_database!(database_cluster_id, opts \\ []) do
    case create_database(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a database from a cluster.

  To delete a specific database, send a DELETE request to `/v2/databases/$DATABASE_ID/dbs/$DB_NAME`.
  Note: Database management is not supported for Caching or Valkey clusters.
  A status of 204 will be given, indicating that the request was processed successfully with no response body.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `db_name` - The name of the database to delete
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.delete_database("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", "mydb", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with empty body on success (204 No Content)
  """
  def delete_database(database_cluster_id, db_name, opts \\ []) do
    Request.request(:delete, "/v2/databases/#{database_cluster_id}/dbs/#{db_name}", opts)
  end

  @doc """
  Same as `delete_database/3` but raises on error.
  """
  def delete_database!(database_cluster_id, db_name, opts \\ []) do
    case delete_database(database_cluster_id, db_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List connection pools for a PostgreSQL database cluster.

  To list all of the connection pools available to a PostgreSQL database cluster, send a GET request to `/v2/databases/$DATABASE_ID/pools`.
  Connection pools can be used to allow a database to handle more connections than it would normally allow.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.list_pools("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `pools` array containing connection pool information
  """
  def list_pools(database_cluster_id, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/pools", opts)
  end

  @doc """
  Same as `list_pools/2` but raises on error.
  """
  def list_pools!(database_cluster_id, opts \\ []) do
    case list_pools(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Add a new connection pool to a PostgreSQL database cluster.

  For PostgreSQL database clusters, connection pools can be used to allow a database to handle more connections than it would normally allow.
  To add a new connection pool, send a POST request to `/v2/databases/$DATABASE_ID/pools` specifying a name, the user, the database, size, and transaction mode.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`, `name`, `mode`, `size`, `db`, `user`

  ## Examples

      Dox.Databases.create_pool("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token", name: "backend-pool", mode: "transaction", size: 10, db: "defaultdb", user: "doadmin")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `pool` object containing the created connection pool details
  """
  def create_pool(database_cluster_id, opts \\ []) do
    Request.request(:post, "/v2/databases/#{database_cluster_id}/pools", opts)
  end

  @doc """
  Same as `create_pool/2` but raises on error.
  """
  def create_pool!(database_cluster_id, opts \\ []) do
    case create_pool(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an existing connection pool for a PostgreSQL database cluster.

  To show information about an existing connection pool, send a GET request to `/v2/databases/$DATABASE_ID/pools/$POOL_NAME`.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `pool_name` - The name of the connection pool
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.get_pool("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", "backend-pool", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `pool` object containing connection pool details
  """
  def get_pool(database_cluster_id, pool_name, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/pools/#{pool_name}", opts)
  end

  @doc """
  Same as `get_pool/3` but raises on error.
  """
  def get_pool!(database_cluster_id, pool_name, opts \\ []) do
    case get_pool(database_cluster_id, pool_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a connection pool from a PostgreSQL database cluster.

  To delete a specific connection pool, send a DELETE request to `/v2/databases/$DATABASE_ID/pools/$POOL_NAME`.
  A status of 204 will be given, indicating that the request was processed successfully with no response body.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `pool_name` - The name of the connection pool to delete
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.delete_pool("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", "backend-pool", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with empty body on success (204 No Content)
  """
  def delete_pool(database_cluster_id, pool_name, opts \\ []) do
    Request.request(:delete, "/v2/databases/#{database_cluster_id}/pools/#{pool_name}", opts)
  end

  @doc """
  Same as `delete_pool/3` but raises on error.
  """
  def delete_pool!(database_cluster_id, pool_name, opts \\ []) do
    case delete_pool(database_cluster_id, pool_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all read-only replicas for a database cluster.

  To list all of the read-only replicas associated with a database cluster, send a GET request to `/v2/databases/$DATABASE_ID/replicas`.
  Note: Read-only replicas are not supported for Caching or Valkey clusters.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.list_replicas("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `replicas` array containing replica information
  """
  def list_replicas(database_cluster_id, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/replicas", opts)
  end

  @doc """
  Same as `list_replicas/2` but raises on error.
  """
  def list_replicas!(database_cluster_id, opts \\ []) do
    case list_replicas(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create a read-only replica.

  To create a read-only replica for a database cluster, send a POST request to `/v2/databases/$DATABASE_ID/replicas` specifying the name, size, and region.
  Note: Read-only replicas are not supported for Caching or Valkey clusters.
  The initial value of the replica's `status` attribute will be `forking`. When ready to receive traffic, it will transition to `active`.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`, `name`, `size`, `region`

  ## Examples

      Dox.Databases.create_replica("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token", name: "read-nyc3-01", size: "db-s-2vcpu-4gb", region: "nyc3")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `replica` object containing the created replica details
  """
  def create_replica(database_cluster_id, opts \\ []) do
    Request.request(:post, "/v2/databases/#{database_cluster_id}/replicas", opts)
  end

  @doc """
  Same as `create_replica/2` but raises on error.
  """
  def create_replica!(database_cluster_id, opts \\ []) do
    case create_replica(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an existing read-only replica.

  To show information about an existing database replica, send a GET request to `/v2/databases/$DATABASE_ID/replicas/$REPLICA_NAME`.
  Note: Read-only replicas are not supported for Caching or Valkey clusters.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `replica_name` - The name of the replica
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.get_replica("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", "read-nyc3-01", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `replica` object containing replica details
  """
  def get_replica(database_cluster_id, replica_name, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/replicas/#{replica_name}", opts)
  end

  @doc """
  Same as `get_replica/3` but raises on error.
  """
  def get_replica!(database_cluster_id, replica_name, opts \\ []) do
    case get_replica(database_cluster_id, replica_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a read-only replica.

  To delete a specific read-only replica, send a DELETE request to `/v2/databases/$DATABASE_ID/replicas/$REPLICA_NAME`.
  Note: Read-only replicas are not supported for Caching or Valkey clusters.
  A status of 204 will be given, indicating that the request was processed successfully with no response body.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `replica_name` - The name of the replica to delete
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.delete_replica("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", "read-nyc3-01", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with empty body on success (204 No Content)
  """
  def delete_replica(database_cluster_id, replica_name, opts \\ []) do
    Request.request(
      :delete,
      "/v2/databases/#{database_cluster_id}/replicas/#{replica_name}",
      opts
    )
  end

  @doc """
  Same as `delete_replica/3` but raises on error.
  """
  def delete_replica!(database_cluster_id, replica_name, opts \\ []) do
    case delete_replica(database_cluster_id, replica_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get the maintenance window for a database cluster.

  To retrieve the maintenance window information for a database cluster, send a GET request to `/v2/databases/$DATABASE_ID/maintenance`.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.maintenance("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with maintenance window information (day, hour, etc.)
  """
  def maintenance(database_cluster_id, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/maintenance", opts)
  end

  @doc """
  Same as `maintenance/2` but raises on error.
  """
  def maintenance!(database_cluster_id, opts \\ []) do
    case maintenance(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Configure a database cluster's maintenance window.

  To configure the window when automatic maintenance should be performed for a database cluster, send a PUT request to `/v2/databases/$DATABASE_ID/maintenance`.
  A successful request will receive a 204 No Content status code with no body in response.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`, `day`, `hour`

  ## Examples

      Dox.Databases.update_maintenance("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token", day: "tuesday", hour: "14:00")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with empty body on success (204 No Content)
  """
  def update_maintenance(database_cluster_id, opts \\ []) do
    Request.request(:put, "/v2/databases/#{database_cluster_id}/maintenance", opts)
  end

  @doc """
  Same as `update_maintenance/2` but raises on error.
  """
  def update_maintenance!(database_cluster_id, opts \\ []) do
    case update_maintenance(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List all actions for a database cluster.

  To retrieve a list of all actions that have been executed for a database cluster, send a GET request to `/v2/databases/$DATABASE_ID/actions`.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.actions("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `actions` array containing action history
  """
  def actions(database_cluster_id, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/actions", opts)
  end

  @doc """
  Same as `actions/2` but raises on error.
  """
  def actions!(database_cluster_id, opts \\ []) do
    case actions(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Perform an action on a database cluster.

  To perform an action (such as reset_auth, migrate, resize, etc.) on a database cluster, send a POST request to `/v2/databases/$DATABASE_ID/actions`.
  Different actions require different parameters in the request body.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token` and action-specific parameters

  ## Examples

      Dox.Databases.action("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token", type: "reset_auth")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `action` object containing the initiated action details
  """
  def action(database_cluster_id, opts \\ []) do
    Request.request(:post, "/v2/databases/#{database_cluster_id}/actions", opts)
  end

  @doc """
  Same as `action/2` but raises on error.
  """
  def action!(database_cluster_id, opts \\ []) do
    case action(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List firewall rules (trusted sources) for a database cluster.

  To list all of a database cluster's firewall rules (known as "trusted sources" in the control panel), send a GET request to `/v2/databases/$DATABASE_ID/firewall`.
  The result will be a JSON object with a `rules` key.

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Databases.firewall_rules("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with `rules` array containing firewall rule information
  """
  def firewall_rules(database_cluster_id, opts \\ []) do
    Request.request(:get, "/v2/databases/#{database_cluster_id}/firewall", opts)
  end

  @doc """
  Same as `firewall_rules/2` but raises on error.
  """
  def firewall_rules!(database_cluster_id, opts \\ []) do
    case firewall_rules(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update firewall rules (trusted sources) for a database cluster.

  To update a database cluster's firewall rules (known as "trusted sources" in the control panel), send a PUT request to `/v2/databases/$DATABASE_ID/firewall` specifying which resources should be able to connect to the database.
  You may limit connections to specific Droplets, Kubernetes clusters, or IP addresses. When a tag is provided, any Droplet or Kubernetes node with that tag will have access.
  The firewall is limited to 100 rules (or trusted sources).

  ## Parameters
  - `database_cluster_id` - The unique identifier of the database cluster
  - `opts` - Optional parameters including `token` and `rules` array

  ## Examples

      Dox.Databases.update_firewall("9cc10173-e9ea-4176-9dbc-a4cee4c4ff30", token: "your_token", rules: [%{type: "ip_addr", value: "192.168.1.1"}])
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with updated `rules` array
  """
  def update_firewall(database_cluster_id, opts \\ []) do
    Request.request(:put, "/v2/databases/#{database_cluster_id}/firewall", opts)
  end

  @doc """
  Same as `update_firewall/2` but raises on error.
  """
  def update_firewall!(database_cluster_id, opts \\ []) do
    case update_firewall(database_cluster_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
