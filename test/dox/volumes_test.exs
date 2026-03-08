defmodule Dox.VolumesTest do
  use ExUnit.Case, async: true

  alias Dox.Volumes

  describe "Dox.Volumes" do
    test "list/1 returns volumes" do
      {:ok, response} = Volumes.list(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns volume" do
      {:ok, response} = Volumes.get("volume-id", token: "test-token")
      assert response.status_code == 200
    end
  end
end
