defmodule Dictionary.Runtime.Server do

  @type t :: pid()
  @type word :: String.t

  @me __MODULE__

  alias Dictionary.Impl.WordList

  @spec start_link() :: {:ok, t}
  def start_link() do
    Agent.start_link(&WordList.word_list/0, name: @me)
  end

  @spec random_word() :: word
  def random_word() do
    Agent.get(@me, &WordList.random_word/1)
  end
end
