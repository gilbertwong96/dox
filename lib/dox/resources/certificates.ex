defmodule Dox.Certificates do
  @moduledoc """
  DigitalOcean Certificates API client.

  ## Usage

    Dox.Certificates.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  List All Certificates

  To list all of the certificates available on your account, send a GET
  request to `/v2/certificates`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `per_page`, `page`, `name`

  ## Examples

    Dox.Certificates.list(token: "your_token")
  """
  def list(opts \\ []) do
    Request.request(:get, "/v2/certificates", opts)
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
  Create a New Certificate

  To upload new SSL certificate which you have previously generated, send a
  POST request to `/v2/certificates`.

  When uploading a user-generated certificate, the `private_key`,
  `leaf_certificate`, and optionally the `certificate_chain` attributes should
  be provided. The type must be set to `custom`.

  When using Let's Encrypt to create a certificate, the `dns_names` attribute
  must be provided, and the type must be set to `lets_encrypt`.

  ## Parameters
  - `opts` - Optional parameters including `token`, `name`, `type`, `private_key`, `leaf_certificate`, `certificate_chain`, `dns_names`

  ## Examples

    Dox.Certificates.create(token: "your_token")
  """
  def create(opts \\ []) do
    Request.request(:post, "/v2/certificates", opts)
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
  Retrieve an Existing Certificate

  To show information about an existing certificate, send a GET request to
  `/v2/certificates/$CERTIFICATE_ID`.

  ## Parameters
  - `certificate_id` - The unique identifier for the certificate.
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Certificates.get(certificate_id, token: "your_token")
  """
  def get(certificate_id, opts \\ []) do
    Request.request(:get, "/v2/certificates/#{certificate_id}", opts)
  end

  @doc """
  Same as `get/2` but raises on error.
  """
  def get!(certificate_id, opts \\ []) do
    case get(certificate_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete a Certificate

  To delete a specific certificate, send a DELETE request to
  `/v2/certificates/$CERTIFICATE_ID`.

  ## Parameters
  - `certificate_id` - The unique identifier for the certificate.
  - `opts` - Optional parameters including `token`

  ## Examples

    Dox.Certificates.delete(certificate_id, token: "your_token")
  """
  def delete(certificate_id, opts \\ []) do
    Request.request(:delete, "/v2/certificates/#{certificate_id}", opts)
  end

  @doc """
  Same as `delete/2` but raises on error.
  """
  def delete!(certificate_id, opts \\ []) do
    case delete(certificate_id, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
