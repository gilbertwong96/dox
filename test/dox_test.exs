defmodule DoxTest do
  use ExUnit.Case
  doctest Dox

  describe "Dox module" do
    test "module is defined" do
      assert is_atom(Dox)
    end

    test "has module info" do
      info = Dox.module_info()
      assert is_list(info)
    end

    test "has :module key in module info" do
      info = Dox.module_info()
      assert Keyword.has_key?(info, :module)
    end

    test "has :attributes key in module info" do
      info = Dox.module_info()
      assert Keyword.has_key?(info, :attributes)
    end

    test "module can be inspected" do
      assert inspect(Dox) == "Dox"
    end

    test "module name as string" do
      module_name = Dox.module_info(:module) |> Atom.to_string()
      assert String.ends_with?(module_name, "Dox")
    end
  end
end
