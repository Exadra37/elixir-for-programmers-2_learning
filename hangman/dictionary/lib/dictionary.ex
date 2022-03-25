defmodule Dictionary do

  alias Dictionary.Runtime.Server

  @type word :: Server.word

  @spec random_word() :: word
  defdelegate random_word(), to: Server
end
