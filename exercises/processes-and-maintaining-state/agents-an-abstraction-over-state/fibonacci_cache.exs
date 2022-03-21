defmodule FibonacciCache do

  @moduledoc """
  # Fibonacci Cache

  As per challenge in the PragDave course we must use a Cache mechanism via Agents

  Check exercise at https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/29542517-agents-an-abstration-over-state

  Possible improvements to be made to the current approach are listed in this
  topic on the Elixir forum: https://elixirforum.com/t/fibonacci-with-cache-can-this-code-be-improved/46711

  """

  def start_cache(state) do
    Agent.start_link(fn -> state end)
  end

  def update(cache, number) do
    Agent.get_and_update(cache, fn state -> new_state = [number | state]; { new_state, new_state } end)
  end

  def get(cache) do
    Agent.get(cache, fn state -> state end)
  end

end
