defmodule HangmanLiveWeb.PageController do
  use HangmanLiveWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
