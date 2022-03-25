defmodule Cache.Impl.State do

  def get(state, key, default \\ nil) do
    state
    |> Map.get(key, default)
  end

  def update(state, key, data) do
    Map.put(state, key, data)
  end

  def delete(state, key) do
    state
    |> Map.delete(key)
  end

end
