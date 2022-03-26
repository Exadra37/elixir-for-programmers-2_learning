defmodule Chain do

  defstruct(
    next_node: nil,
    count: 1000
  )

  def start_link(next_node, count \\ 1000) do
    spawn_link(Chain, :message_loop, [%Chain{next_node: next_node, count: count}])
    |> Process.register(:chainer)
  end

  def message_loop(%{count: 0}) do
    IO.puts "done"
  end

  def message_loop(state) do
    receive do
      {:trigger, list} ->
        IO.inspect(state.count)
        send({:chainer, state.next_node}, {:trigger, [node() | list]})
    end

    message_loop(%{state | count: state.count - 1})
  end

end
