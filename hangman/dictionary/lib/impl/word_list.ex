defmodule Dictionary.Impl.WordList do

  @type word_list :: List.t
  @type word :: String.t

  @spec start() :: word_list
  def start() do
    "assets/words.txt"
    |> File.read!()
    |> String.split(~r/\n/, trim: true)
  end

  @spec random_word(word_list) :: word
  def random_word(word_list)do
    word_list
    |> Enum.random()
  end
end
