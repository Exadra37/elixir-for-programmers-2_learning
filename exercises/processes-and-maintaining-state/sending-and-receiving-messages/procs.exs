defmodule Procs do

  @doc """

  Sending messages to a process:

  #PID<0.113.0>
  iex(2)> pid = v(-1)
  #PID<0.113.0>
  iex(3)> send pid, "World!"
  Hello "World!"
  "World!"

  And now the process will not receive the message:

  iex(4)> send pid, "Again!"
  "Again!"

  And this is because the process is not running anymore, it exited after
  receiving the last message:

  iex(6)> Process.alive? pid
  false

  If we make the function tail recursive, by adding a call to itself at the end
  of the function, then after receiving a message it will be available to
  receive more messages. In fact it will loop forever.

  Let's try again:

  iex(7)> r Procs
  warning: redefining module Procs (current version defined in memory)
    procs.exs:1

  {:reloaded, [Procs]}
  iex(8)> pid = spawn Procs, :hello, []
  #PID<0.130.0>
  iex(9)> send pid, "World!"
  Hello "World!"
  "World!"
  iex(10)> send pid, "Again!"
  Hello "Again!"
  "Again!"

  Now we can see that the process doesn't exit and is still running:
  iex(14)> Process.alive? pid
  true

  """
  def hello() do
    receive do
      msg ->
        IO.puts("Hello #{inspect msg}")
    end

    # Call itself again in order to wait for the next message to process. This
    # makes the function tail recursive and it will loop forever.
    hello()
  end

end
