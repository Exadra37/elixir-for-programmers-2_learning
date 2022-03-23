defmodule Fibonacci.Impl.Sequence do
  @moduledoc """
  # Fibonacci Sequence

  As per challenge in the PragDave course we must use a Cache mechanism via Agents

  Check exercise at https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/29542517-agents-an-abstration-over-state

  My first pass at this used a Map as per the exercise recommendation, but then
  I realized that I was converting it into a list and then reversing it on every
  time I retrieved it from the cache for finding the next number in the sequence,
  therefore I refactored the code to just use a list to store the state in the
  cache and got a much nicer and clean implementation.

  In the first edition of the course I think I solved this exercise and just by
  using a list that would be passed as an accumulator while doing the recursion.

  Possible improvements to be made to the current approach are listed in this
  topic on the Elixir forum: https://elixirforum.com/t/fibonacci-with-cache-can-this-code-be-improved/46711

  """

  @doc """
  ## Calculate the Fibonacci sequence

  Run from iex:

    iex> Fibonacci.fib 1000
    [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987]
    :ok

  The returned list is conform the Fibonacci sequence listedin Wikipedia: https://en.wikipedia.org/wiki/Fibonacci_number

  """
  def fib(number) when number <= 0 do
    IO.puts("Please provide a number greater then 0")
  end

  def fib(number) do
    # {:ok, cache} = Cache.start_cache([1, 0])
    Cache.get(number)
    |>_fib(number)
  end

  defp _fib(nil, number), do: _fib_sequence(number, 0)
  defp _fib(cached_sequence, _number), do: cached_sequence

  defp _fib_sequence(number, 0) do
    Cache.update(number, 0)
    Cache.update(number, 1)
    |> _fib_sequence(number, 2)
  end

  # The exit condition
  defp _fib_sequence(sequence, number, current_number) when number <= current_number do
    sequence
    |> Enum.reverse()
  end

  defp _fib_sequence([n1, n2 | _tail] = sequence, number, _current_number) do
    current_number = n1 + n2
    _update_cache(number, current_number, sequence)
    |>_fib_sequence(number, current_number)
  end

  defp _update_cache(number, current_number, _sequence) when current_number <= number do
    Cache.update(number, current_number)
  end

  defp _update_cache(_, _, sequence), do: sequence

end
