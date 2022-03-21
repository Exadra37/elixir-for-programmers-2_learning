defmodule FibonacciClassic do

  @moduledoc """
  # Fibonacci Cache

  Copied from the exercise at https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/29542517-agents-an-abstration-over-state

  Running this module even with `FibonacciClassic.fib 10` doesn't finish em several minutes.

  So, as PragDave says in the exercise this is a very slow implementation.

  """
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n-1 + fib(n-2))

end
