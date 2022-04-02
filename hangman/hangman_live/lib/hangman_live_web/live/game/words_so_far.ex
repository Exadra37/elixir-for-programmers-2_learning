defmodule HangmanLiveWeb.Live.Game.WordsSoFar do

  use HangmanLiveWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="words-so-far">
    WordsSoFar
    </div>
    """
  end

end
