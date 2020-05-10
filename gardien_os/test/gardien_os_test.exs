defmodule GardienOsTest do
  use ExUnit.Case
  doctest GardienOs

  test "greets the world" do
    assert GardienOs.hello() == :world
  end
end
