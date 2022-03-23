defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  test "greets the world" do
    assert Fibonacci.hello() == :world
  end
end
