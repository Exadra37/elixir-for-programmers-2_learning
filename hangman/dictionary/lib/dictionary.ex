defmodule Dictionary do

  alias Dictionary.Impl.WordList

  @opaque t :: WordList.t
  @type word :: WordList.word

  @spec start() :: t
  defdelegate start(), to: WordList, as: :word_list

  @spec random_word(t) :: word
  defdelegate random_word(word_list), to: WordList
end
