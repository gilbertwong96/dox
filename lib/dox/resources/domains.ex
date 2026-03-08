defmodule Dox.Domains do
  @moduledoc """
  DigitalOcean Domains API client.

  ## Usage

    Dox.Domains.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Domains

  To retrieve a list of all of the domains in your account, send a GET
  request to `/v2/domains`.

  ## Parameters
  - `opts` - Optional parameters including:
    - `per_page` - Number of items to return per page (default: 20)
    - `page` - Which page to return (default: 1)
    - `token` - API token

  ## Examples

    Dox.Domains.list(token: "your_token")
    Dox.Domains.list(per_page: 50, page: 1, token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/domains", opts)
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
  Create a New Domain

  To create a new domain, send a POST request to `/v2/domains`. Set the
  "name" attribute to the domain name you are adding. Optionally, you may set
  the "ip_address" attribute, and an A record will be automatically created
  pointing to the apex domain.

  ## Parameters
  - `opts` - Optional parameters including:
    - `name` - (required) The name of the domain
    - `ip_address` - (optional) The IP address for the domain's initial A record
    - `token` - API token

  ## Examples

    Dox.Domains.create(name: "example.com", token: "your_token")
    Dox.Domains.create(name: "example.com", ip_address: "1.2.3.4", token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/domains", opts)
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
  Retrieve an Existing Domain

  To get details about a specific domain, send a GET request to
  `/v2/domains/$DOMAIN_NAME`.

  ## Parameters
  - `domain_name` - The name of the domain
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Domains.get("example.com", token: "your_token")
  """
  def get(domain_name, opts \\ []) do
    Request.request(:get, "/v2/domains/#{domain_name}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(domain_name, opts \\ []) do
    case get(domain_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a Domain

  To delete a domain, send a DELETE request to `/v2/domains/$DOMAIN_NAME`.

  ## Parameters
  - `domain_name` - The name of the domain to delete
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Domains.delete("example.com", token: "your_token")
  """
  def delete(domain_name, opts \\ []) do
    Request.request(:delete, "/v2/domains/#{domain_name}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(domain_name, opts \\ []) do
    case delete(domain_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List All Domain Records

  To get a listing of all records configured for a domain, send a GET
  request to `/v2/domains/$DOMAIN_NAME/records`.

  The list of records returned can be filtered by using the `name` and
  `type` query parameters. For example, to only include A records for a
  domain, send a GET request to `/v2/domains/$DOMAIN_NAME/records?type=A`.
  `name` must be a fully qualified record name. For example, to only
  include records matching `sub.example.com`, send a GET request to
  `/v2/domains/$DOMAIN_NAME/records?name=sub.example.com`. Both name and
  type may be used together.

  ## Parameters
  - `domain_name` - The name of the domain
  - `opts` - Optional parameters including:
    - `name` - Filter by record name
    - `type` - Filter by record type (A, AAAA, CNAME, MX, etc.)
    - `per_page` - Number of items per page
    - `page` - Page number
    - `token` - API token

  ## Examples

    Dox.Domains.list_records("example.com", token: "your_token")
    Dox.Domains.list_records("example.com", type: "A", token: "your_token")
  """
  def list_records(domain_name, opts \\ []) do
    Request.request(:get, "/v2/domains/#{domain_name}/records", opts)
  end

  @doc """
  Same as `list_records/2` but raises on error.
  """
  def list_records!(domain_name, opts \\ []) do
    case list_records(domain_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create a New Domain Record

  To create a new record to a domain, send a POST request to
  `/v2/domains/$DOMAIN_NAME/records`.

  The request must include all of the required fields for the domain
  record type being added. See the attribute table for details regarding
  record types and their respective required attributes.

  Common record types include:
  - A, AAAA: require `name`, `data`, and optionally `ttl`
  - CNAME: require `name`, `data`, and optionally `ttl`
  - MX: require `name`, `data`, `priority`, and optionally `ttl`
  - TXT: require `name`, `data`, and optionally `ttl`

  ## Parameters
  - `domain_name` - The name of the domain
  - `opts` - Optional parameters including:
    - `type` - (required) Record type (A, AAAA, CAA, CNAME, MX, NS, SOA, SRV, TXT)
    - `name` - (required) The name of the record
    - `data` - (required) The data for the record
    - `priority` - (optional) Priority for MX and SRV records
    - `port` - (optional) Port for SRV records
    - `ttl` - (optional) Time to live in seconds
    - `weight` - (optional) Weight for SRV records
    - `token` - API token

  ## Examples

    Dox.Domains.create_record("example.com", type: "A", name: "www", data: "162.10.66.0", ttl: 1800, token: "your_token")
    Dox.Domains.create_record("example.com", type: "CNAME", name: "blog", data: "example.com", token: "your_token")
  """
  def create_record(domain_name, opts \\ []) do
    Request.request(:post, "/v2/domains/#{domain_name}/records", opts)
  end

  @doc """
  Same as `create_record/2` but raises on error.
  """
  def create_record!(domain_name, opts \\ []) do
    case create_record(domain_name, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an Existing Domain Record

  To retrieve a specific domain record, send a GET request to
  `/v2/domains/$DOMAIN_NAME/records/$RECORD_ID`.

  ## Parameters
  - `domain_name` - The name of the domain
  - `record_id` - The ID of the record to retrieve
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Domains.get_record("example.com", 3352896, token: "your_token")
  """
  def get_record(domain_name, record_id, opts \\ []) do
    Request.request(:get, "/v2/domains/#{domain_name}/records/#{record_id}", opts)
  end

  @doc """
  Same as `get_record/3` but raises on error.
  """
  def get_record!(domain_name, record_id, opts \\ []) do
    case get_record(domain_name, record_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update a Domain Record

  To update an existing record, send a PUT request to
  `/v2/domains/$DOMAIN_NAME/records/$DOMAIN_RECORD_ID`. Any attribute
  valid for the record type can be set to a new value for the record.

  See the attribute table for details regarding record types and their
  respective attributes.

  ## Parameters
  - `domain_name` - The name of the domain
  - `record_id` - The ID of the record to update
  - `opts` - Optional parameters including:
    - `name` - The name of the record
    - `type` - The type of the record
    - `data` - The data for the record
    - `priority` - Priority for MX and SRV records
    - `port` - Port for SRV records
    - `ttl` - Time to live in seconds
    - `weight` - Weight for SRV records
    - `token` - API token

  ## Examples

    Dox.Domains.update_record("example.com", 3352896, name: "blog", token: "your_token")
  """
  def update_record(domain_name, record_id, opts \\ []) do
    Request.request(:put, "/v2/domains/#{domain_name}/records/#{record_id}", opts)
  end

  @doc """
  Same as `update_record/3` but raises on error.
  """
  def update_record!(domain_name, record_id, opts \\ []) do
    case update_record(domain_name, record_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a Domain Record

  To delete a record for a domain, send a DELETE request to
  `/v2/domains/$DOMAIN_NAME/records/$DOMAIN_RECORD_ID`.

  The record will be deleted and the response status will be a 204. This
  indicates a successful request with no body returned.

  ## Parameters
  - `domain_name` - The name of the domain
  - `record_id` - The ID of the record to delete
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Domains.delete_record("example.com", 3352896, token: "your_token")
  """
  def delete_record(domain_name, record_id, opts \\ []) do
    Request.request(:delete, "/v2/domains/#{domain_name}/records/#{record_id}", opts)
  end

  @doc """
  Same as `delete_record/3` but raises on error.
  """
  def delete_record!(domain_name, record_id, opts \\ []) do
    case delete_record(domain_name, record_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
