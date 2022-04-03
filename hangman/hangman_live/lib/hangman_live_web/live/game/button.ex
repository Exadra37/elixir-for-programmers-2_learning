defmodule HangmanLiveWeb.Live.Game.Button do

  use HangmanLiveWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="try-again">
      <button
        class={_show_or_hide(@game_state)}
        phx-click={_phxclick_event(@game_state)}><%= _button_title_for(@game_state) %></button>
    </div>
    """
  end

  defp _show_or_hide(state) when state in [:won, :lost, nil], do: "show"
  defp _show_or_hide(_state), do: "hide"

  defp _phxclick_event(state) when state in [:won, :lost, nil], do: "new_game"
  defp _phxclick_event(_state), do: ""

  defp _button_title_for(state) when state in [:won, :lost], do: "Try Again"
  defp _button_title_for(nil), do: "Start Game"
  defp _button_title_for(_state), do: ""

end
