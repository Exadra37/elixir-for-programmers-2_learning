defmodule Procs do

  @doc """

  Spawning a single process:

  iex(2)> spawn Procs, :hello, ["world!"]
  Hello world!
  #PID<0.114.0>

  """
  def hello(name) do
    IO.puts("Hello #{name}")
  end

  @doc """
  And after adding Process to sleep:

  iex(4)> spawn Procs, :hello, ["world!", %{sleep: 1000}]
  #PID<0.123.0>
  Hello world!

  I increased the number until 10_000_000 without bringing down my laptop
  iex(24)> 1..10 |> Enum.each(fn n -> spawn fn -> Procs.hello("number #{n}") end end)
  :ok
  Hello number 1
  Hello number 2
  Hello number 3
  Hello number 4
  Hello number 5
  Hello number 6
  Hello number 7
  Hello number 8
  Hello number 9
  Hello number 10

  """
  def hello(name, %{sleep: sleep}) do
    Process.sleep(sleep)
    IO.puts("Hello #{name}")
  end

end
