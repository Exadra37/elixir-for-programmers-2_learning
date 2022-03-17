defmodule Dictionary do

  alias Dictionary.Impl.WordList

  @type word_list :: WordList.word_list
  @type word :: WordList.word

  @spec start() :: word_list
  defdelegate start(), to: WordList

  @spec random_word(word_list) :: word
  defdelegate random_word(word_list), to: WordList
end
