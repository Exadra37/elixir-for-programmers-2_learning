defmodule Cache do

  alias Cache.Runtime.Server

  defdelegate start_link(), to: Server

  defdelegate all(), to: Server

  defdelegate get(key), to: Server
  defdelegate get(key, default), to: Server

  defdelegate update(key, data), to: Server

  defdelegate delete(key), to: Server

  defdelegate destroy(), to: Server
end
