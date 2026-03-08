defmodule Dox.Projects do
  @moduledoc """
  DigitalOcean Projects API client.

  ## Usage

    Dox.Projects.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Projects

  To list all your projects, send a GET request to `/v2/projects`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `per_page`, `page`

  ## Examples

    Dox.Projects.list(token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/projects", opts)
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
  Create a Project

  To create a project, send a POST request to `/v2/projects`.

  ## Parameters
  - `name` - The name of the project (required)
  - `description` - A description of the project
  - `purpose` - The purpose of the project (required, e.g., "Service or API")
  - `environment` - The environment of the project (e.g., "Production", "Staging")
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Projects.create(name: "my-web-api", description: "My website API", purpose: "Service or API", environment: "Production", token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/projects", opts)
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
  Retrieve an Existing Project

  To get a project, send a GET request to `/v2/projects/$PROJECT_ID`.

  ## Parameters
  - `project_id` - The unique identifier of the project
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Projects.get("4e1bfbc3-dc3e-41f2-a18f-1b4d7ba71679", token: "your_token")
  """
  def get(project_id, opts \\ []) do
    Request.request(:get, "/v2/projects/#{project_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(project_id, opts \\ []) do
    case get(project_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update a Project

  To update a project, send a PUT request to `/v2/projects/$PROJECT_ID`.
  All of the following attributes must be sent.

  ## Parameters
  - `project_id` - The unique identifier of the project
  - `name` - The name of the project (required)
  - `description` - A description of the project (required)
  - `purpose` - The purpose of the project (required)
  - `environment` - The environment of the project (required)
  - `is_default` - Whether the project is the default project (required)
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Projects.update("4e1bfbc3-dc3e-41f2-a18f-1b4d7ba71679", name: "my-web-api", description: "My website API", purpose: "Service or API", environment: "Staging", is_default: false, token: "your_token")
  """
  def update(project_id, opts \\ []) do
    Request.request(:put, "/v2/projects/#{project_id}", opts)
  end

  @doc """
  Same as `update/2` but raises on error.
  """
  def update!(project_id, opts \\ []) do
    case update(project_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete an Existing Project

  To delete a project, send a DELETE request to `/v2/projects/$PROJECT_ID`.

  To be deleted, a project must not have any resources assigned to it. Any existing
  resources must first be reassigned or destroyed, or you will receive a 412 error.

  A successful request will receive a 204 status code with no body in response.

  ## Parameters
  - `project_id` - The unique identifier of the project
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Projects.delete("4e1bfbc3-dc3e-41f2-a18f-1b4d7ba71679", token: "your_token")
  """
  def delete(project_id, opts \\ []) do
    Request.request(:delete, "/v2/projects/#{project_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(project_id, opts \\ []) do
    case delete(project_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List Project Resources

  To list all your resources in a project, send a GET request to
  `/v2/projects/$PROJECT_ID/resources`.

  This endpoint will only return resources that you are authorized to see.
  For example, to see Droplets in a project, include the `droplet:read` scope.

  ## Parameters
  - `project_id` - The unique identifier of the project
  - `opts` - Optional parameters including `token`, `per_page`, `page`

  ## Examples

    Dox.Projects.list_resources("4e1bfbc3-dc3e-41f2-a18f-1b4d7ba71679", token: "your_token")
  """
  def list_resources(project_id, opts \\ []) do
    Request.request(:get, "/v2/projects/#{project_id}/resources", opts)
  end

  @doc """
  Same as `list_resources/2` but raises on error.
  """
  def list_resources!(project_id, opts \\ []) do
    case list_resources(project_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Assign Resources to a Project

  To assign resources to a project, send a POST request to
  `/v2/projects/$PROJECT_ID/resources`.

  You must have both `project:update` and `<resource>:read` scopes to assign
  new resources. For example, to assign a Droplet to a project, include both
  the `project:update` and `droplet:read` scopes.

  ## Parameters
  - `project_id` - The unique identifier of the project
  - `resources` - An array of resource URNs to assign (e.g., "do:droplet:13457723")
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Projects.assign_resources("4e1bfbc3-dc3e-41f2-a18f-1b4d7ba71679", resources: ["do:droplet:1", "do:floatingip:192.168.99.100"], token: "your_token")
  """
  def assign_resources(project_id, opts \\ []) do
    Request.request(:post, "/v2/projects/#{project_id}/resources", opts)
  end

  @doc """
  Same as `assign_resources/2` but raises on error.
  """
  def assign_resources!(project_id, opts \\ []) do
    case assign_resources(project_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Get default project

  ## Parameters
  - `project_id` - Path parameters
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Projects.default(project_id, token: "your_token")
  """
  def default(project_id, opts \\ []) do
    Request.request(:get, "/v2/projects/#{project_id}/default", opts)
  end

  @doc """
  Same as `default/2` but raises on error.
  """
  def default!(project_id, opts \\ []) do
    case default(project_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
