defmodule Hangman.Runtime.Server do

  alias Hangman.Impl.Game

  use GenServer

  @type t :: pid()

  @idle_timeout_milleseconds 1 * 60 * 60 * 1000 # 1 hour

  ### Runs in the Client Process

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil)
  end


  ### Runs in this Server Process

  def init(_args) do
    watcher = Watchdog.start(@idle_timeout_milleseconds)
    { :ok, { Game.new_game(), watcher }}
  end

  def handle_call({:make_move, guess}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {updated_game, tally} = Game.make_move(game, guess)
    {:reply, tally, {updated_game, watcher}}
  end

  def handle_call({:tally}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {:reply, Game.tally(game), {game, watcher}}
  end
end
