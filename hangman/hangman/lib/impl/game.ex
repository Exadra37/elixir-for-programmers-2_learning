defmodule Hangman.Impl.Game do

  @type t :: %Hangman.Impl.Game{
    turns_left: integer,
    game_state: Hangman.state(),
    letters: [String.t()],
    used: MapSet.t(String.t())
  }
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game() do
    Dictionary.random_word()
    |> new_game()
  end

  def new_game(word) do
    %__MODULE__{
      letters: word |> String.codepoints()
    }
  end
end
