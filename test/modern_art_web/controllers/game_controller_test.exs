defmodule ModernArtWeb.GameControllerTest do
  use ModernArtWeb.ConnCase

  alias ModernArt.Games

  @create_attrs %{name: "some name"}
  @invalid_attrs %{name: nil}

  def fixture(:game) do
    {:ok, game} = Games.create_game(@create_attrs)
    game
  end

  describe "new game" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.game_path(conn, :new))
      assert html_response(conn, 200) =~ "New Game"
    end
  end

  describe "create game" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create), game: @create_attrs)

      assert %{name: name} = redirected_params(conn)
      name = URI.decode(name)
      assert redirected_to(conn) == Routes.game_path(conn, :show, name)

      conn = get(conn, Routes.game_path(conn, :show, name))
      assert html_response(conn, 200) =~ "Show Game"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create), game: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Game"
    end
  end
end
