defmodule Dox.ProjectsTest do
  use ExUnit.Case, async: true

  alias Dox.Projects

  describe "Dox.Projects" do
    test "list/1 returns projects" do
      {:ok, response} = Projects.list(token: "test-token")
      assert response.status_code == 200
    end

    test "get/2 returns project" do
      {:ok, response} = Projects.get("project-id", token: "test-token")
      assert response.status_code == 200
    end
  end
end
