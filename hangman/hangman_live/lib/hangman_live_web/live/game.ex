defmodule HangmanLiveWeb.Live.Game do

  use HangmanLiveWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("new_game", _params, socket) do
    socket = _start_new_game(socket)
    {:noreply, socket}
  end

  def handle_event("make_move", %{"key" => key}, %{assigns: %{game: game}} = socket) do
    tally = Hangman.make_move(game, key)
    {:noreply, assign(socket, :tally, tally)}
  end

  def handle_event("make_move", _params, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="game-holder" phx-window-keyup="make_move">
    <h1 class="text-center">Hangman Game</h1>

    <%= live_component(__MODULE__.Figure, turns_left: _turns_left(assigns), id: 1) %>

    <%= if assigns[:tally] do %>
    <%= live_component(__MODULE__.Alphabet, tally: assigns.tally, id: 2) %>
    <%= live_component(__MODULE__.WordsSoFar, tally: assigns.tally, id: 3) %>
    <% end %>

    <%= live_component(__MODULE__.Button, game_state: _game_state(assigns), id: 4) %>

    </div>
    """
  end

  defp _turns_left(%{tally: tally} = _assigns), do: tally.turns_left
  defp _turns_left(_assigns), do: nil

  defp _game_state(%{tally: tally} = _assigns), do: tally.game_state
  defp _game_state(_assigns), do: :nil

  defp _start_new_game(socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    socket
    |> assign(%{game: game, tally: tally})
  end
end
