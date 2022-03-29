defmodule AppWeb.HangmanController do
  use AppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    game = Hangman.new_game()

    conn
    |> put_session(:game, game)
    |> redirect(to: Routes.hangman_path(conn, :show))
  end

  def update(conn, %{"make_move" => %{"guess" => guess}} = params) do
    put_in(conn.params["make_move"]["guess"], "")
    |> get_session(:game)
    |> Hangman.make_move(guess)

    # PragDave have not mention, but we are not using the updated conn from the
    # pipeline above, and the game only works properly in :show because the
    # :game we get from the session is in fact a pid for the Agent storing the
    # game state, therefore when the tally for the game is retrieved in the
    # :show action it will be up to date.
    redirect(conn, to: Routes.hangman_path(conn, :show))
  end

  def show(conn, _param) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.tally()

    render(conn, "game.html", tally: tally)
  end

end
