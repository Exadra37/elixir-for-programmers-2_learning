defmodule Cache.Impl.State do

  # def get(state, key) do
  #   state
  #   |> Map.get(key)
  # end

  def update(state, key, data) do
    Map.get(state, key)
    |> _update(key, state, data)
  end

  defp _update(nil, key, state, data) do
    state
    |> Map.put(key, [data])
  end

  defp _update(value, key, state, data) do
    state
    |> Map.put(key, [data | value])
  end

  def delete(state, key) do
    state
    |> Map.delete(key)
  end

end
