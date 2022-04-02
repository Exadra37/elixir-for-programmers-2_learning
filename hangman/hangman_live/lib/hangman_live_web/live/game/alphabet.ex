defmodule HangmanLiveWeb.Live.Game.Alphabet do

  use HangmanLiveWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="alphabet">
    Alphabet
    </div>
    """
  end

end
