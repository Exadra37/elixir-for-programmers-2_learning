defmodule Fibonacci do

  defdelegate fib(number), to: Fibonacci.Impl.Sequence

end
