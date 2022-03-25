defmodule Cache.Runtime.Server do

  @pid_name __MODULE__

  alias Cache.Impl.State

  def start_link() do
    Agent.start_link(fn -> %{} end, name: @pid_name)
  end

  def all() do
    Agent.get(@pid_name, fn state -> state end)
  end

  def get(key, default \\ nil) do
    Agent.get(@pid_name, fn state -> State.get(state, key, default) end)
  end

  def update(key, data) do
    Agent.get_and_update(@pid_name, fn state -> new_state = State.update(state, key, data); {new_state[key], new_state} end)
  end

  def delete(key) do
    Agent.get_and_update(@pid_name, fn state -> new_state = State.delete(state, key); {new_state, new_state} end)
  end

  def destroy() do
    Agent.get_and_update(@pid_name, fn _state -> {%{}, %{}} end)
  end
end
