defmodule Dictionary.Runtime.Server do

  @type t :: pid()
  @type word :: String.t

  alias Dictionary.Impl.WordList

  @spec start_link() :: {:ok, t}
  def start_link() do
    Agent.start_link(&WordList.word_list/0)
  end

  @spec random_word(t) :: word
  def random_word(pid) do
    Agent.get(pid, &WordList.random_word/1)
  end
end
