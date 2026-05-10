defmodule Dox.Application do
  @moduledoc """
  Dox OTP application with Finch HTTP client supervisor.
  """

  use Application

  @default_finch_pool_config [size: 5, pool_max_idle_time: 60_000, protocols: [:http1, :http2]]

  @impl true
  def start(_type, _args) do
    _ = Dox.plugins()

    pool_config = Application.get_env(:dox, :finch_pool, @default_finch_pool_config)

    children = [
      {Finch, name: Dox.Finch, pools: %{default: pool_config}}
    ]

    opts = [strategy: :one_for_one, name: Dox.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
