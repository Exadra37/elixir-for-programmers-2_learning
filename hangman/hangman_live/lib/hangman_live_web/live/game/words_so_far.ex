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
      <div class={status_class(@tally.game_state)}>
         <%= state_message(@tally.game_state) %>
      </div>

      <div class="letters">
      <%= for ch <- @tally.letters do %>
        <% cls = if ch != "_", do: "one-letter correct", else: "one-letter" %>
          <div class={cls}>
            <%= ch %>
          </div>
      <% end %>
      </div>
    </div>
    """
  end

  defp state_message(state) do
    @states[state] || "Unknown state"
  end

  defp status_class(state) do
    "status #{state}"
  end

end
