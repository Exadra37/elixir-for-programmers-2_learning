defmodule HangmanLiveWeb.Live.Game.Figure do

  use HangmanLiveWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="figure">
    Figure
    </div>
    """
  end

end
