defmodule HangmanLiveWeb.Live.Game.WordsSoFar do

  use HangmanLiveWeb, :live_component

  @states %{
    already_used: "You already picked that letter",
    bad_guess: "That's not in the word",
    good_guess: "Good guess!",
    initializing: "Type one letter on your keyboard or click on the alphabet for your first guess",
    lost: "Sorry, you lost...",
    won: "You won!",
  }

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="words-so-far">
      <div class={_status_class(@tally.game_state)}>
         <%= _state_message(@tally.game_state) %>
      </div>

      <div class="letters">
      <%= for letter <- @tally.letters do %>
        <div class={_letter_class(letter)}>
          <%= letter %>
        </div>
      <% end %>
      </div>
    </div>
    """
  end

  defp _letter_class("_"), do: "one-letter"
  defp _letter_class(_letter), do: "one-letter correct"

  defp _state_message(state) do
    @states[state] || "Unknown state"
  end

  defp _status_class(state) do
    "status #{state}"
  end

end
