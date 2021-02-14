defmodule ModernArtWeb.PageLive do
  require Logger
  use ModernArtWeb, :live_view
  alias ModernArt.Games
  alias Phoenix.PubSub

  @topic inspect(__MODULE__)

  @impl true
  def mount(%{"name" => name}, _session, socket) do
    PubSub.subscribe(ModernArt.PubSub, topic(name))
    game = Games.by_name!(name)
    {:ok, assign(socket,
      game: game,
      msgs: [],
    )}
  end

  defp broadcast(socket, event) do
    PubSub.broadcast(
      ModernArt.PubSub,
      topic(socket.assigns.game.name),
      event
    )
    socket
  end

  defp noreply(socket) do
    {:noreply, socket}
  end

  def handle_event("send-message", %{"message" => msg}, socket) do
    socket
    |> broadcast({:new_msg, msg})
    |> noreply
  end

  def handle_info({:new_msg, msg}, socket) do
    socket
    |> assign(msgs: socket.assigns.msgs ++ [msg])
    |> noreply
  end
  
  defp topic(), do: @topic
  defp topic(game_name), do: topic() <> to_string(game_name)
end
