defmodule Dox.Application do
  @moduledoc """
  Dox OTP application with Finch HTTP client supervisor.
  """

  use Application

  @default_finch_pool_config [size: 1, protocols: [:http2]]
  @finch_pool_config Application.compile_env(:dox, :finch_pool, @default_finch_pool_config)

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: Dox.Finch, pools: %{default: @finch_pool_config}}
    ]

    opts = [strategy: :one_for_one, name: Dox.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
