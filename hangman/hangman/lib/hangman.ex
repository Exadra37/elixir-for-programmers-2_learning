defmodule Hangman do

  alias Hangman.Runtime.Server
  alias Hangman.Type

  @opaque game :: Server.t
  @type tally :: Type.tally

  @spec new_game() :: game
  def new_game() do
    {:ok, pid} = Server.start_link()
    pid
  end

  @spec make_move(game, String.t) :: {game, tally}
  def make_move(game, guess) do
    GenServer.call(game, {:make_move, guess})
  end

  @spec tally(game) :: tally
  def tally(game) do
    GenServer.call(game, {:tally})
  end

end
