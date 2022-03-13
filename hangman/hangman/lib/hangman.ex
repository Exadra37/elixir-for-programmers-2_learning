defmodule Hangman do

  @state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
  @type game :: any
  @tally :: %{
    turns_left: integer,
    game_state: state,
    letters: list(String.t),
    used: list(String.t),
  }

  @spec new_game() :: game
  def new_game() do

  end

  @spec make_move(game, String.t) :: {game, tally}
  def make_move(game, guess) do

  end
end
