defmodule ModernArtWeb.GameControllerTest do
  use ModernArtWeb.ConnCase

  alias ModernArt.Games

  def fixture(:game) do
    {:ok, game} = Games.create_game()
    game
  end

  describe "new game" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.game_path(conn, :new))
      assert html_response(conn, 200) =~ "New Game"
    end
  end

  describe "create game" do
    test "redirects to show", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create))

      assert %{name: name} = redirected_params(conn)
      name = URI.decode(name)
      assert redirected_to(conn) == Routes.page_path(conn, :index, name)

      conn = get(conn, Routes.page_path(conn, :index, name))
      assert html_response(conn, 200) =~ "Welcome to"
    end
  end
end
