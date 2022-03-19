defmodule Procs do
  @moduledoc """
  # Pattern matching messages in a process.

  """

  @doc """
  Open a session in iex and play with it:

    iex(2)> pid = spawn Procs, :hello, [0]
    #PID<0.114.0>
    iex(3)> send pid, "Exadra37"
    0: Hello "Exadra37"
    "Exadra37"
    iex(4)> send pid, "ALSB"
    0: Hello "ALSB"
    "ALSB"
    iex(5)> send pid, {:add, 789}
    {:add, 789}
    iex(6)> send pid, "Exadra37"
    789: Hello "Exadra37"
    "Exadra37"
    iex(7)> send pid, "ALSB"
    789: Hello "ALSB"
    "ALSB"
    iex(8)> Process.alive? pid
    true
    iex(9)> send pid, {:quit}
    I'm outta here...
    {:quit}
    iex(10)> Process.alive? pid
    false
  """
  def hello(count) do
    # Calls itself again in order to wait for the next message to process. This
    # makes the function tail recursive and it will loop forever.
    receive do
      {:quit} ->
        IO.puts "I'm outta here..."
      {:add, n} ->
        hello(count + n)
      msg ->
        IO.puts("#{count}: Hello #{inspect msg}")
        hello(count)
    end

  end

  @doc """

  Playing with it in iex:

    iex(1)> pid = spawn Procs, :greeter, [0]
    #PID<0.113.0>
    iex(2)> send pid, "Exadra37"
    0: Greeter -> "Exadra37"
    "Exadra37"
    iex(3)> send pid, "ALSB"
    1: Greeter -> "ALSB"
    "ALSB"
    iex(4)> send pid, {:add, 789}
    {:add, 789}
    iex(5)> send pid, "Exadra37"
    790: Greeter -> "Exadra37"
    "Exadra37"
    iex(6)> send pid, "ALSB"
    791: Greeter -> "ALSB"
    "ALSB"
    iex(7)> Pro
    Process     Procs       Protocol
    iex(7)> Process.alive? pid
    true
    iex(8)> send pid, {:quit}
    I'm outta here...
    {:quit}
    iex(9)> Process.alive? pid
    false

  """
  def greeter(count) do
    # Calls itself again in order to wait for the next message to process. This
    # makes the function tail recursive and it will loop forever.
    receive do
      {:quit} ->
        IO.puts "I'm outta here..."
      {:add, n} ->
        # (count - 1), because the current count is not used to print a message,
        # thus if the current count was 1 and `n` was 789, then the next message
        # printed would show 791, instead of 790.
        greeter((count - 1) + n)
      {:remove, n} ->
        greeter(count - n)
      {:reset} ->
        greeter(0)
      {:reset, n} ->
        greeter(n)
      msg ->
        IO.puts("#{count}: Greeter -> #{inspect msg}")
        greeter(count + 1)
    end
  end

end
