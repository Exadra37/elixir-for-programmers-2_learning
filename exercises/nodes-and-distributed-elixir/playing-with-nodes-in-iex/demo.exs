defmodule Demo do

  def reverse() do
    receive do
      {from_pid, msg} ->
        result = msg |> String.reverse()
        send(from_pid, result)
        IO.inspect(from_pid)
        reverse()
    end
  end

end
