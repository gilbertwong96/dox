defmodule Dox.Apps do
  @moduledoc """
  DigitalOcean Apps API client.

  ## Usage

    Dox.Apps.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all apps

  List all apps on your account. Information about the current active
  deployment as well as any in progress ones will also be included for
  each app.

  ## Parameters
  - `opts` - Optional parameters including `token`, `page`, `per_page`

  ## Examples

    Dox.Apps.list(token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/apps", opts)
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
  Create an app

  Create a new app by submitting an app specification. For documentation
  on app specifications (`AppSpec` objects), please refer to the product
  documentation at https://docs.digitalocean.com/products/app-platform/reference/app-spec/

  ## Parameters
  - `opts` - Optional parameters including `token` and the app specification in the body

  ## Examples

    Dox.Apps.create(token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/apps", opts)
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
  Get an app

  Retrieve details about an existing app by either its ID or name. To
  retrieve an app by its name, do not include an ID in the request path.
  Information about the current active deployment as well as any in
  progress ones will also be included in the response.

  ## Parameters
  - `id` - The app ID or name
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Apps.get(id, token: "your_token")
  """
  def get(id, opts \\ []) do
    Request.request(:get, "/v2/apps/#{id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(id, opts \\ []) do
    case get(id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update an app

  Update an existing app by submitting a new app specification. For
  documentation on app specifications (`AppSpec` objects), please refer to
  the product documentation at https://docs.digitalocean.com/products/app-platform/reference/app-spec/

  ## Parameters
  - `id` - The app ID
  - `opts` - Optional parameters including `token` and the updated app specification in the body

  ## Examples

    Dox.Apps.update(id, token: "your_token")
  """
  def update(id, opts \\ []) do
    Request.request(:put, "/v2/apps/#{id}", opts)
  end

  @doc """
  Same as `update/2` but raises on error.
  """
  def update!(id, opts \\ []) do
    case update(id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete an app

  Delete an existing app. Once deleted, all active deployments will be
  permanently shut down and the app deleted. If needed, be sure to back up
  your app specification so that you may re-create it at a later time.

  ## Parameters
  - `id` - The app ID
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Apps.delete(id, token: "your_token")
  """
  def delete(id, opts \\ []) do
    Request.request(:delete, "/v2/apps/#{id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(id, opts \\ []) do
    case delete(id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create deployment

  Creating an app deployment will pull the latest changes from your
  repository and schedule a new deployment for your app.

  ## Parameters
  - `app_id` - The app ID
  - `opts` - Optional parameters including `token` and deployment options in the body

  ## Examples

    Dox.Apps.create_deployment(app_id, token: "your_token")
  """
  def create_deployment(app_id, opts \\ []) do
    Request.request(:post, "/v2/apps/#{app_id}/deployments", opts)
  end

  @doc """
  Same as `create_deployment/2` but raises on error.
  """
  def create_deployment!(app_id, opts \\ []) do
    case create_deployment(app_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get deployment

  Retrieve information about an app deployment.

  ## Parameters
  - `app_id` - The app ID
  - `deployment_id` - The deployment ID
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Apps.get_deployment(app_id, deployment_id, token: "your_token")
  """
  def get_deployment(app_id, deployment_id, opts \\ []) do
    Request.request(:get, "/v2/apps/#{app_id}/deployments/#{deployment_id}", opts)
  end

  @doc """
  Same as `get_deployment/3` but raises on error.
  """
  def get_deployment!(app_id, deployment_id, opts \\ []) do
    case get_deployment(app_id, deployment_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Cancel deployment

  Immediately cancel an in-progress deployment.

  ## Parameters
  - `app_id` - The app ID
  - `deployment_id` - The deployment ID
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Apps.cancel_deployment(app_id, deployment_id, token: "your_token")
  """
  def cancel_deployment(app_id, deployment_id, opts \\ []) do
    Request.request(:post, "/v2/apps/#{app_id}/deployments/#{deployment_id}/cancel", opts)
  end

  @doc """
  Same as `cancel_deployment/3` but raises on error.
  """
  def cancel_deployment!(app_id, deployment_id, opts \\ []) do
    case cancel_deployment(app_id, deployment_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get deployment logs

  Retrieve the logs of a past, in-progress, or active deployment. If a
  component name is specified, the logs will be limited to only that
  component. The response will include links to either real-time logs of
  an in-progress or active deployment or archived logs of a past deployment.

  ## Parameters
  - `app_id` - The app ID
  - `deployment_id` - The deployment ID
  - `opts` - Optional parameters including `token`, `live_updates`, `log_type`, `time_wait`

  ## Examples

    Dox.Apps.deployment_logs(app_id, deployment_id, token: "your_token")
  """
  def deployment_logs(app_id, deployment_id, opts \\ []) do
    Request.request(:get, "/v2/apps/#{app_id}/deployments/#{deployment_id}/logs", opts)
  end

  @doc """
  Same as `deployment_logs/3` but raises on error.
  """
  def deployment_logs!(app_id, deployment_id, opts \\ []) do
    case deployment_logs(app_id, deployment_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Restart app

  Perform a rolling restart of all or specific components in an app.

  ## Parameters
  - `app_id` - The app ID
  - `opts` - Optional parameters including `token` and `components` in the body

  ## Examples

    Dox.Apps.restart(app_id, token: "your_token")
  """
  def restart(app_id, opts \\ []) do
    Request.request(:post, "/v2/apps/#{app_id}/restart", opts)
  end

  @doc """
  Same as `restart/2` but raises on error.
  """
  def restart!(app_id, opts \\ []) do
    case restart(app_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get app logs

  Retrieve the logs of the active deployment if one exists. The response
  will include links to either real-time logs of an in-progress or active
  deployment or archived logs of a past deployment. Note log_type=BUILD
  logs will return logs associated with the current active deployment
  (being served). To view build logs associated with in-progress build,
  the query must explicitly reference the deployment id.

  ## Parameters
  - `app_id` - The app ID
  - `opts` - Optional parameters including `token`, `live_updates`, `log_type`, `time_wait`

  ## Examples

    Dox.Apps.logs(app_id, token: "your_token")
  """
  def logs(app_id, opts \\ []) do
    Request.request(:get, "/v2/apps/#{app_id}/logs", opts)
  end

  @doc """
  Same as `logs/2` but raises on error.
  """
  def logs!(app_id, opts \\ []) do
    case logs(app_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List app tiers

  List all instance sizes for `service`, `worker`, and `job` components.

  ## Parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Apps.tiers(token: "your_token")
  """
  def tiers(opts \\ []) do
    Request.request(:get, "/v2/apps/tiers/instance_sizes", opts)
  end

  @doc """
  Same as `tiers/1` but raises on error.
  """
  def tiers!(opts \\ []) do
    case tiers(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List app regions

  List all regions supported by App Platform.

  ## Parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Apps.regions(token: "your_token")
  """
  def regions(opts \\ []) do
    Request.request(:get, "/v2/apps/regions", opts)
  end

  @doc """
  Same as `regions/1` but raises on error.
  """
  def regions!(opts \\ []) do
    case regions(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
