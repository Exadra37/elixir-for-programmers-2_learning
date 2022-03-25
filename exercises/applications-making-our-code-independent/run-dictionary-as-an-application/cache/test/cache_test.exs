defmodule CacheTest do
  use ExUnit.Case
  doctest Cache

  test "greets the world" do
    assert Cache.hello() == :world
  end
end
