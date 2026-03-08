defmodule Dox.Tags do
  @moduledoc """
  DigitalOcean Tags API client.

  ## Usage

    Dox.Tags.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List all tags on your account.

  ## Summary
  List All Tags

  ## Description
  To list all of your tags, you can send a GET request to `/v2/tags`.

  This endpoint will only return tagged resources that you are authorized to see
  (e.g. Droplets will only be returned if you have `droplet:read`).

  ## Parameters
  - `opts` - Optional parameters including:
    - `token` - API token
    - `page` - Page number for pagination
    - `per_page` - Number of items per page

  ## Examples

    Dox.Tags.list(token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/tags", opts)
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
  Create a new tag.

  ## Summary
  Create a New Tag

  ## Description
  To create a tag you can send a POST request to `/v2/tags` with a `name` attribute.

  Tags may contain letters, numbers, colons, dashes, and underscores. There is a limit
  of 255 characters per tag.

  ## Parameters
  - `opts` - Optional parameters including:
    - `token` - API token
    - `name` - The name of the tag (required)

  ## Examples

    Dox.Tags.create(name: "awesome", token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/tags", opts)
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
  Retrieve a tag by name.

  ## Summary
  Retrieve a Tag

  ## Description
  To retrieve an individual tag, you can send a GET request to `/v2/tags/$TAG_NAME`.

  This endpoint will only return tagged resources that you are authorized to see.
  For example, to see tagged Droplets, include the `droplet:read` scope.

  The `tag_name` is the name of the tag. Tags may contain letters, numbers, colons,
  dashes, and underscores. There is a limit of 255 characters per tag.

  ## Parameters
  - `tag_name` - The name of the tag
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Tags.get("awesome", token: "your_token")
  """
  def get(tag_name, opts \\ []) do
    Request.request(:get, "/v2/tags/#{tag_name}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(tag_name, opts \\ []) do
    case get(tag_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a tag by name.

  ## Summary
  Delete a Tag

  ## Description
  A tag can be deleted by sending a DELETE request to `/v2/tags/$TAG_NAME`. Deleting
  a tag also untags all the resources that have previously been tagged by the Tag.

  ## Parameters
  - `tag_name` - The name of the tag
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Tags.delete("awesome", token: "your_token")
  """
  def delete(tag_name, opts \\ []) do
    Request.request(:delete, "/v2/tags/#{tag_name}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(tag_name, opts \\ []) do
    case delete(tag_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Tag resources (droplets, databases, images, volumes, or volume snapshots).

  ## Summary
  Tag a Resource

  ## Description
  Resources can be tagged by sending a POST request to `/v2/tags/$TAG_NAME/resources`
  with an array of json objects containing `resource_id` and `resource_type` attributes.

  Currently only tagging of Droplets, Databases, Images, Volumes, and Volume Snapshots
  is supported. `resource_type` is expected to be the string `droplet`, `database`,
  `image`, `volume` or `volume_snapshot`. `resource_id` is expected to be the ID of
  the resource as a string.

  In order to tag a resource, you must have both `tag:create` and `<resource type>:update`
  scopes. For example, to tag a Droplet, you must have `tag:create` and `droplet:update`.

  ## Parameters
  - `tag_name` - The name of the tag
  - `opts` - Optional parameters including:
    - `token` - API token
    - `resources` - Array of resources to tag with `resource_id` and `resource_type`

  ## Examples

    Dox.Tags.tag_droplets("awesome", resources: [
      %{resource_id: "9569411", resource_type: "droplet"},
      %{resource_id: "7555620", resource_type: "image"},
      %{resource_id: "3d80cb72-342b-4aaa-b92e-4e4abb24a933", resource_type: "volume"}
    ], token: "your_token")
  """
  def tag_droplets(tag_name, opts \\ []) do
    Request.request(:post, "/v2/tags/#{tag_name}/droplets", opts)
  end

  @doc """
  Same as `tag_droplets/2` but raises on error.
  """
  def tag_droplets!(tag_name, opts \\ []) do
    case tag_droplets(tag_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Untag resources (droplets, databases, images, volumes, or volume snapshots).

  ## Summary
  Untag a Resource

  ## Description
  Resources can be untagged by sending a DELETE request to `/v2/tags/$TAG_NAME/resources`
  with an array of json objects containing `resource_id` and `resource_type` attributes.

  Currently only untagging of Droplets, Databases, Images, Volumes, and Volume Snapshots
  is supported. `resource_type` is expected to be the string `droplet`, `database`,
  `image`, `volume` or `volume_snapshot`. `resource_id` is expected to be the ID of
  the resource as a string.

  In order to untag a resource, you must have both `tag:delete` and `<resource type>:update`
  scopes. For example, to untag a Droplet, you must have `tag:delete` and `droplet:update`.

  ## Parameters
  - `tag_name` - The name of the tag
  - `opts` - Optional parameters including:
    - `token` - API token
    - `resources` - Array of resources to untag with `resource_id` and `resource_type`

  ## Examples

    Dox.Tags.untag_droplets("awesome", resources: [
      %{resource_id: "9569411", resource_type: "droplet"},
      %{resource_id: "7555620", resource_type: "image"},
      %{resource_id: "3d80cb72-342b-4aaa-b92e-4e4abb24a933", resource_type: "volume"}
    ], token: "your_token")
  """
  def untag_droplets(tag_name, opts \\ []) do
    Request.request(:delete, "/v2/tags/#{tag_name}/droplets", opts)
  end

  @doc """
  Same as `untag_droplets/2` but raises on error.
  """
  def untag_droplets!(tag_name, opts \\ []) do
    case untag_droplets(tag_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
