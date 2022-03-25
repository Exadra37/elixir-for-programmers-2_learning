defmodule Fibonacci.Impl.Sequence do
  @moduledoc """
  # Fibonacci Sequence

  As per challenge in the PragDave course we must use a Cache mechanism via Agents

  Check exercise at https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/29542517-agents-an-abstration-over-state

  This exercise builds up on the one solved two chapter ago to transform it into
  an application. The previous exercise code was published into the Elixir forum
  and received some suggestions for improvement: https://elixirforum.com/t/fibonacci-with-cache-can-this-code-be-improved/46711

  The current approach is a lot different from the previous, and takes some
  inspiration on the suggestions made there, especially for using a Map, instead
  of a list. I choose to keep the list for storing Fibonacci sequence, but this
  time is cached inside a map where the key is each Fibonacci number and its
  sequence of numbers.

  The previous approach only stored in cache the final result for calculating
  the fibonacci sequence for a given number, while this approach stores in cache
  the sequence for each fibonacci number found during the calculation. For
  example, if we ask to the sequence for 1000, then each fibonacci number until
  1000 will have its sequence stored in cache:

  iex(11)> Cache.all
  %{
    1 => [1, 1, 0],
    2 => [2, 1, 1, 0],
    3 => [3, 2, 1, 1, 0],
    5 => [5, 3, 2, 1, 1, 0],
    8 => [8, 5, 3, 2, 1, 1, 0],
    13 => [13, 8, 5, 3, 2, 1, 1, 0],
    21 => [21, 13, 8, 5, 3, 2, 1, 1, 0],
    34 => [34, 21, 13, 8, 5, 3, 2, 1, 1, 0],
    55 => [55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0],
    89 => [89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0],
    144 => [144, 89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0],
    233 => [233, 144, 89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0],
    377 => [377, 233, 144, 89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0],
    610 => [610, 377, 233, 144, 89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0],
    987 => [987, 610, 377, 233, 144, 89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0],
    1000 => [987, 610, 377, 233, 144, 89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1, 0]
  }

  This allows to later get the fibonacci sequence for any number up to 1000
  without the need to calculate the sequence again, and if we ask for a number
  like 10_000 we only need to calculate the sequence after `1000` because the
  other are already cached.

  For fun we can try:

  iex(17)> Fibonacci.fib 1_000_000_000_000_000_000
  %Fibonacci.Impl.Sequence{
    next_fibonacci: 1100087778366101931,
    sequence: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987,
     1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418,
     317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465,
     14930352, 24157817, 39088169, 63245986, 102334155, 165580141, 267914296,
     433494437, 701408733, 1134903170, 1836311903, 2971215073, ...]
  }

  And we get the `iex` prompt immediately and that was a surprise to me, because
  I thought it would take a few seconds.

  """

  alias Fibonacci.Impl.Sequence

  defstruct(
    next_fibonacci: 0,
    sequence: []
  )

  @doc """
  ## Calculate the Fibonacci sequence

  Run from iex:

    iex> Fibonacci.fib 1000
    %Fibonacci.Impl.Sequence{
      next_fibonacci: 1597,
      sequence: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987]
    }

  The returned list for the sequence is conform the Fibonacci sequence listed in
  the Wikipedia: https://en.wikipedia.org/wiki/Fibonacci_number

  """
  def fib(number) when number <= 0 do
    IO.puts("Please provide a number greater then 0")
  end

  def fib(number) do
    case Cache.get(number) do
      nil ->
        _fib_sequence([1, 0], number, 1)

      [fib1, fib2 | _tail] = sequence ->
        %Sequence{
          next_fibonacci: fib1 + fib2,
          sequence: Enum.reverse(sequence)
        }
    end
  end

  # The exit condition
  defp _fib_sequence(sequence, number, fibonacci_number)
    when fibonacci_number > number
  do
    Cache.update(number, sequence)

    %Sequence{
      next_fibonacci: fibonacci_number,
      sequence: Enum.reverse(sequence)
    }
  end

  defp _fib_sequence(sequence, number, fibonacci_number) do
    [fib1, fib2 | _tail] = sequence =
      case Cache.get(fibonacci_number) do
        nil ->
          _update_sequence(sequence, number, fibonacci_number)

        sequence ->
          sequence
      end

      _fib_sequence(sequence, number, fib1 + fib2)
  end

  defp _update_sequence(sequence, number, fibonacci_number)
    when fibonacci_number <= number
  do
    sequence = [fibonacci_number | sequence]
    Cache.update(fibonacci_number, sequence)
    sequence
  end

  defp _update_sequence(sequence, _number, _fibonacci_number), do: sequence

end
