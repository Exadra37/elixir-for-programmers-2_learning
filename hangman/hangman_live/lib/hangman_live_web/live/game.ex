defmodule HangmanLiveWeb.Live.Game do

  use HangmanLiveWeb, :live_view

  def mount(_parmas, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    socket = socket |> assign(%{game: game, tally: tally})

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="game-holder">

    <%= live_component(__MODULE__.Figure, tally: assigns.tally, id: 1) %>
    <%= live_component(__MODULE__.Alphabet, tally: assigns.tally, id: 2) %>
    <%= live_component(__MODULE__.WordsSoFar, tally: assigns.tally, id: 3) %>

    </div>
    """
  end
end
