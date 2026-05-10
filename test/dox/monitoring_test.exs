defmodule Dox.MonitoringTest do
  use ExUnit.Case, async: true

  test "get_droplet_bandwidth/2 returns success response" do
    assert {:ok, response} =
             Dox.Monitoring.get_droplet_bandwidth(222_651_441,
               interface: "public",
               direction: "outbound",
               start: 1_636_051_668,
               end: 1_636_051_668
             )

    assert is_struct(response, Dox.Response)
  end

  test "get_droplet_bandwidth!/2 returns response on success" do
    response =
      Dox.Monitoring.get_droplet_bandwidth!(222_651_441,
        interface: "private",
        direction: "inbound",
        start: 1_620_683_817,
        end: 1_620_705_417
      )

    assert is_struct(response, Dox.Response)
  end
end
