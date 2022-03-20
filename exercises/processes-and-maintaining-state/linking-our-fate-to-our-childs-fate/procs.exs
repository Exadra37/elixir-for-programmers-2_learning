defmodule Procs do
  @moduledoc """
  # Linking our fate to our child's fate

  https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/29542500-linking-our-fate-to-our-child-s-fate
  """

  @doc """
  Open a session in iex and play with it...

  Spawning a process with `spawn_link` will link both processes to each other in
  a way that if one of them crashes without a `:normal` reason the other one
  will also crash.

    iex(1)> pid = spawn_link Procs, :hello, [0]
    #PID<0.113.0>
    iex(2)> send pid, "hello"
    "hello"
    0: Hello "hello"

  Let's crash the the process we spawned with a reason that is not `:normal`:
    iex(3)> send pid, {:crash, :kaboom}
    ** (EXIT from #PID<0.111.0>) shell process exited with reason: :kaboom

    Interactive Elixir (1.13.3) - press Ctrl+C to exit (type h() ENTER for help)

  So, iex also crashed (exited) with the same reason and was immediately
  restarted, and the state that iex was holding is now gone.

  For example, we cannot check if the process is alive because `pid` is not
  known anymore to iex as a variable:
    iex(1)> Process.alive? pid
    ** (CompileError) iex:1: undefined function pid/0 (there is no such import)

    iex(1)> pid
    ** (CompileError) iex:1: undefined function pid/0 (there is no such import)

  Let's spawn again a linked process:
    iex(1)> pid = spawn_link Procs, :hello, [0]
    #PID<0.120.0>
    iex(2)> send pid, "hello"
    0: Hello "hello"
    "hello"

  This time we will crash it with the `:normal` reason:
    iex(3)> send pid, {:crash, :normal}
    {:crash, :normal}

  But this time iex as not crashed, thus it has not restarted, therefore it
  continues to be aware of the variable `pid`, therefore we can use it to
  confirm if the process is still alive:
    iex(4)> pid
    #PID<0.120.0>
    iex(5)> Process.alive? pid
    false

  """
  def hello(count) do
    # Calls itself again in order to wait for the next message to process. This
    # makes the function tail recursive and it will loop forever.
    receive do
      # When the `reason` is the atom `:normal` then the linked process, the one
      # that spawned this one with `spawn_link`, will not be affected, but if
      # other reason is given the linked process will also exit (crash).
      {:crash, reason} ->
        exit(reason)

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
