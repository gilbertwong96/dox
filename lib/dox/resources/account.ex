defmodule Dox.Account do
  @moduledoc """
  DigitalOcean Account API client.

  ## Usage

    Dox.Account.list(token: "your_token")
  """

  alias Dox.Request

  @doc """
  Get User Information

  To show information about the current user account, send a GET request to `/v2/account`.

  ## Parameters
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Account.get(token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with account info including `droplet_limit`, `floating_ip_limit`, `email`, `name`, `uuid`, `email_verified`, `status`, `status_message`, and optionally `team` details.
  """
  def get(opts \\ []) do
    Request.request(:get, "/v2/account", opts)
  end

  @doc """
  Same as `get/1` but raises on error.

  ## Examples

      Dox.Account.get!(token: "your_token")
      #=> %Dox.Response{...}
  """
  def get!(opts \\ []) do
    case get(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  List All SSH Keys

  To list all of the keys in your account, send a GET request to `/v2/account/keys`. The response will be a JSON object with a key set to `ssh_keys`. The value of this will be an array of ssh_key objects, each of which contains the standard ssh_key attributes.

  ## Parameters
  - `opts` - Optional parameters including `token`, `per_page`, and `page` for pagination

  ## Examples

      Dox.Account.list_keys(token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with an array of SSH keys containing `id`, `fingerprint`, `public_key`, and `name`.
  """
  def list_keys(opts \\ []) do
    Request.request(:get, "/v2/account/keys", opts)
  end

  @doc """
  Same as `list_keys/1` but raises on error.

  ## Examples

      Dox.Account.list_keys!(token: "your_token")
      #=> %Dox.Response{...}
  """
  def list_keys!(opts \\ []) do
    case list_keys(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Create a New SSH Key

  To add a new SSH public key to your DigitalOcean account, send a POST request to `/v2/account/keys`. Set the `name` attribute to the name you wish to use and the `public_key` attribute to the full public key you are adding.

  ## Parameters
  - `opts` - Optional parameters including `token`, `name` (the name for the key), and `public_key` (the full public key)

  ## Examples

      Dox.Account.create_key(token: "your_token", name: "My SSH Key", public_key: "ssh-rsa AEXAMPLE...")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the created SSH key containing `id`, `fingerprint`, `public_key`, and `name`.
  """
  def create_key(opts \\ []) do
    Request.request(:post, "/v2/account/keys", opts)
  end

  @doc """
  Same as `create_key/1` but raises on error.

  ## Examples

      Dox.Account.create_key!(token: "your_token", name: "My SSH Key", public_key: "ssh-rsa AEXAMPLE...")
      #=> %Dox.Response{...}
  """
  def create_key!(opts \\ []) do
    case create_key(opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Retrieve an Existing SSH Key

  To get information about a key, send a GET request to `/v2/account/keys/$KEY_ID` or `/v2/account/keys/$KEY_FINGERPRINT`.

  ## Parameters
  - `ssh_key_identifier` - The unique identifier (ID or fingerprint) of the SSH key
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Account.get_key(512190, token: "your_token")
      #=> {:ok, %Dox.Response{...}}

      Dox.Account.get_key("3b:16:bf:e4:8b:00:8b:b8:59:8c:a9:d3:f0:19:45:fa", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the SSH key containing `id`, `fingerprint`, `public_key`, and `name`.
  """
  def get_key(ssh_key_identifier, opts \\ []) do
    Request.request(:get, "/v2/account/keys/#{ssh_key_identifier}", opts)
  end

  @doc """
  Same as `get_key/2` but raises on error.

  ## Examples

      Dox.Account.get_key!(512190, token: "your_token")
      #=> %Dox.Response{...}
  """
  def get_key!(ssh_key_identifier, opts \\ []) do
    case get_key(ssh_key_identifier, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Update an SSH Key's Name

  To update the name of an SSH key, send a PUT request to either `/v2/account/keys/$SSH_KEY_ID` or `/v2/account/keys/$SSH_KEY_FINGERPRINT`. Set the `name` attribute to the new name you want to use.

  ## Parameters
  - `ssh_key_identifier` - The unique identifier (ID or fingerprint) of the SSH key
  - `opts` - Optional parameters including `token` and `name` (the new name for the key)

  ## Examples

      Dox.Account.update_key(512190, token: "your_token", name: "Renamed SSH Key")
      #=> {:ok, %Dox.Response{...}}

      Dox.Account.update_key("3b:16:bf:e4:8b:00:8b:b8:59:8c:a9:d3:f0:19:45:fa", token: "your_token", name: "New Key Name")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with the updated SSH key containing `id`, `fingerprint`, `public_key`, and `name`.
  """
  def update_key(ssh_key_identifier, opts \\ []) do
    Request.request(:put, "/v2/account/keys/#{ssh_key_identifier}", opts)
  end

  @doc """
  Same as `update_key/2` but raises on error.

  ## Examples

      Dox.Account.update_key!(512190, token: "your_token", name: "Renamed SSH Key")
      #=> %Dox.Response{...}
  """
  def update_key!(ssh_key_identifier, opts \\ []) do
    case update_key(ssh_key_identifier, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end

  @doc """
  Delete an SSH Key

  To destroy a public SSH key that you have in your account, send a DELETE request to `/v2/account/keys/$KEY_ID` or `/v2/account/keys/$KEY_FINGERPRINT`.

  ## Parameters
  - `ssh_key_identifier` - The unique identifier (ID or fingerprint) of the SSH key
  - `opts` - Optional parameters including `token`

  ## Examples

      Dox.Account.delete_key(512190, token: "your_token")
      #=> {:ok, %Dox.Response{...}}

      Dox.Account.delete_key("3b:16:bf:e4:8b:00:8b:b8:59:8c:a9:d3:f0:19:45:fa", token: "your_token")
      #=> {:ok, %Dox.Response{...}}

  ## Response
  Returns `%Dox.Response{}` with an empty body on success (204 status).
  """
  def delete_key(ssh_key_identifier, opts \\ []) do
    Request.request(:delete, "/v2/account/keys/#{ssh_key_identifier}", opts)
  end

  @doc """
  Same as `delete_key/2` but raises on error.

  ## Examples

      Dox.Account.delete_key!(512190, token: "your_token")
      #=> %Dox.Response{...}
  """
  def delete_key!(ssh_key_identifier, opts \\ []) do
    case delete_key(ssh_key_identifier, opts) do
      {:ok, response} -> response
      {:error, error} -> raise error
    end
  end
end
