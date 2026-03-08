defmodule Dox.Images do
  @moduledoc """
  DigitalOcean Images API client.

  ## Usage

    Dox.Images.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Images

  To list all of the images available on your account, send a GET request
  to /v2/images.

  ## Filtering Results

  It's possible to request filtered results by including certain query
  parameters.

  **Image Type**

  Either 1-Click Application or OS Distribution images can be filtered by
  using the `type` query parameter.

  To retrieve only distribution images, include the `type` query parameter
  set to distribution: `/v2/images?type=distribution`.

  To retrieve only application images, include the `type` query parameter
  set to application: `/v2/images?type=application`.

  **User Images**

  To retrieve only the private images of a user, include the `private`
  query parameter set to true: `/v2/images?private=true`.

  **Tags**

  To list all images assigned to a specific tag, include the `tag_name`
  query parameter set to the name of the tag: `/v2/images?tag_name=$TAG_NAME`.

  ## Parameters
  - `type` - Filter by image type: "distribution" or "application"
  - `private` - Filter to show only private images (true/false)
  - `tag_name` - Filter by tag name
  - `opts` - Optional parameters including `token`, `per_page`, `page`

  ## Examples

    Dox.Images.list(token: "your_token")
    Dox.Images.list(type: "distribution", token: "your_token")
    Dox.Images.list(private: true, token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/images", opts)
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
  Create a Custom Image

  To create a new custom image, send a POST request to /v2/images.

  The body must contain a url attribute pointing to a Linux virtual machine
  image to be imported into DigitalOcean.

  The image must be in the raw, qcow2, vhdx, vdi, or vmdk format.

  It may be compressed using gzip or bzip2 and must be smaller than 100 GB
  after being decompressed.

  ## Parameters
  - `name` - The name to give the new image
  - `url` - A URL from which the image may be retrieved
  - `distribution` - The distribution of the image
  - `region` - The region to import the image to
  - `description` - An optional description of the image
  - `tags` - An optional array of tags to apply to the image
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Images.create(name: "ubuntu-18.04-minimal", url: "http://cloud-images.ubuntu.com/...", distribution: "Ubuntu", region: "nyc3", token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/images", opts)
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
  Retrieve an Existing Image

  To retrieve information about an image, send a GET request to
  /v2/images/$IDENTIFIER.

  **Public** images can be identified by image `id` or `slug`.

  **Private** images *must* be identified by image `id`.

  ## Parameters
  - `image_id` - A unique number (id) or string (slug) used to identify and reference a specific image. Public images can be identified by image id or slug. Private images must be identified by image id.
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Images.get(62137902, token: "your_token")
    Dox.Images.get("ubuntu-16-04-x64", token: "your_token")
  """
  def get(image_id, opts \\ []) do
    Request.request(:get, "/v2/images/#{image_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(image_id, opts \\ []) do
    case get(image_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete an Image

  To delete a snapshot or custom image, send a DELETE request to
  /v2/images/$IMAGE_ID.

  ## Parameters
  - `image_id` - The unique identifier of the image to delete
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Images.delete(7938391, token: "your_token")
  """
  def delete(image_id, opts \\ []) do
    Request.request(:delete, "/v2/images/#{image_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(image_id, opts \\ []) do
    case delete(image_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update an Image

  To update an image, send a PUT request to /v2/images/$IMAGE_ID.

  Set the `name` attribute to the new value you would like to use.

  For custom images, the `description` and `distribution` attributes may
  also be updated.

  ## Parameters
  - `image_id` - The unique identifier of the image to update
  - `name` - The new name for the image
  - `description` - The new description for the image (for custom images)
  - `distribution` - The new distribution for the image (for custom images)
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Images.update(7938391, name: "new-image-name", token: "your_token")
  """
  def update(image_id, opts \\ []) do
    Request.request(:put, "/v2/images/#{image_id}", opts)
  end

  @doc """
  Same as `update/2` but raises on error.
  """
  def update!(image_id, opts \\ []) do
    case update(image_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List All Actions for an Image

  To retrieve all actions that have been executed on an image, send a GET
  request to /v2/images/$IMAGE_ID/actions.

  ## Parameters
  - `image_id` - The unique identifier of the image
  - `opts` - Optional parameters including `token`, `per_page`, `page`

  ## Examples

    Dox.Images.actions(7555620, token: "your_token")
  """
  def actions(image_id, opts \\ []) do
    Request.request(:get, "/v2/images/#{image_id}/actions", opts)
  end

  @doc """
  Same as `actions/2` but raises on error.
  """
  def actions!(image_id, opts \\ []) do
    case actions(image_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Initiate an Image Action

  The following actions are available on an Image.

  ## Convert an Image to a Snapshot

  To convert an image, for example, a backup to a snapshot, send a POST request
  to /v2/images/$IMAGE_ID/actions. Set the `type` attribute to `convert`.

  ## Transfer an Image

  To transfer an image to another region, send a POST request to
  /v2/images/$IMAGE_ID/actions. Set the `type` attribute to `transfer` and set
  `region` attribute to the slug identifier of the region you wish to transfer
  to.

  ## Parameters
  - `image_id` - The unique identifier of the image
  - `type` - The action to perform: "convert" or "transfer"
  - `region` - The region to transfer the image to (required for transfer action)
  - `opts` - Optional parameters including `token`

  ## Examples

    # Transfer an image to another region
    Dox.Images.action(7938269, type: "transfer", region: "nyc2", token: "your_token")

    # Convert an image to a snapshot
    Dox.Images.action(7938269, type: "convert", token: "your_token")
  """
  def action(image_id, opts \\ []) do
    Request.request(:post, "/v2/images/#{image_id}/actions", opts)
  end

  @doc """
  Same as `action/2` but raises on error.
  """
  def action!(image_id, opts \\ []) do
    case action(image_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
