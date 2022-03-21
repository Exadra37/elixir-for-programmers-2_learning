defmodule Dictionary do

  alias Dictionary.Runtime.Server

  @opaque t :: Server.t
  @type word :: Server.word

  @spec start_link() :: {:ok, t}
  defdelegate start_link(), to: Server

  @spec random_word(t) :: word
  defdelegate random_word(pid), to: Server
end
