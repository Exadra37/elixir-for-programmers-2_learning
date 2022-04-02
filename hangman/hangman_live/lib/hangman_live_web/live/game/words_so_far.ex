defmodule HangmanLiveWeb.Live.Game.WordsSoFar do

  use HangmanLiveWeb, :live_component

  @states %{
    already_used: "You already picked that letter",
    bad_guess: "That's not in the word",
    good_guess: "Good guess!",
    initializing: "Type or click on your first guess",
    lost: "sorry, you lost...",
    won: "You won!",
  }

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="words-so-far">
      <div class="words-so-far">
         <%= state_name(@tally.game_state) %>
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

  defp state_name(state) do
    @states[state] || "Unknown state"
  end

end
