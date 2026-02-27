defmodule MeteorWeb.GameLive.Show do
  use MeteorWeb, :live_view

  alias Meteor.Games

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}></Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Game")
     |> assign(:game, Games.get_game!(id))}
  end
end
