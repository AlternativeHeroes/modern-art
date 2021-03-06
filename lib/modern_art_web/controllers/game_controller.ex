defmodule ModernArtWeb.GameController do
  use ModernArtWeb, :controller

  alias ModernArt.Games
  alias ModernArt.Games.Game

  def new(conn, _params) do
    changeset = Games.change_game(%Game{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, _params) do
    case Games.create_game() do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: Routes.page_path(conn, :index, game.name))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"name" => name}) do
    game = Games.by_name!(name)
    render(conn, "show.html", game: game)
  end
end
