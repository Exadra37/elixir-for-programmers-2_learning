defmodule Dictionary.Impl.WordList do

  @type t :: list(String)
  @type word :: String.t

  @word_list "./../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/, trim: true)

  @spec word_list() :: t
  def word_list(), do: @word_list

  @spec random_word(t) :: word
  def random_word(word_list)do
    word_list
    |> Enum.random()
  end
end
