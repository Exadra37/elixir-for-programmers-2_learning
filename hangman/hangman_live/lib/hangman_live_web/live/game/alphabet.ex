defmodule HangmanLiveWeb.Live.Game.Alphabet do

  use HangmanLiveWeb, :live_component

  def mount(socket) do
    letters = (?a..?z) |> Enum.map(fn char -> << char :: utf8 >> end)
    socket = assign(socket, :letters, letters)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="alphabet">
    <%= for letter <- assigns.letters do %>
      <div
        phx-click="make_move"
        phx-value-key={letter}
        class={"one-letter #{classOf(letter, @tally)}"}
      >
        <%= letter %>
      </div>
      <% end %>
    </div>
    """
  end

  defp classOf(letter, tally) do
    cond do
      Enum.member?(tally.letters, letter) -> "correct"
      Enum.member?(tally.used, letter) -> "wrong"
      true -> ""
    end
  end
end
