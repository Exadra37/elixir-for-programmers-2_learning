defmodule Dictionary.Runtime.Server do

  @type t :: pid()
  @type word :: String.t

  @me __MODULE__

  # Let's use the Agent behavior in order to allow for the Supervisor to know
  # what it needs to start and run this Server, like the `child_spec/1` function
  # that returns a specification to start an Agent under a Supervisor.
  use Agent

  alias Dictionary.Impl.WordList

  @spec start_link(list()) :: {:ok, t}
  def start_link(_args) do
    Agent.start_link(&WordList.word_list/0, name: @me)
  end

  @spec random_word() :: word
  def random_word() do
    Agent.get(@me, &WordList.random_word/1)
  end
end
