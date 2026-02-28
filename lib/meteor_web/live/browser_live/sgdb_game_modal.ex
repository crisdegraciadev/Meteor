defmodule MeteorWeb.Live.BrowserLive.SGDBGameModal do
  use MeteorWeb, :live_component

  alias Meteor.Games

  attr :sgdb_game, :map, required: true
  attr :api_key, :string, required: true

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(%{api_key: api_key, sgdb_game: sgdb_game}, socket) do
    socket =
      socket
      |> assign(:sgdb_game, sgdb_game)
      |> assign_async(:covers, fn -> Games.get_sgdb_covers(sgdb_game.id, api_key) end)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="cursor-pointer">
      <div class="rounded-md flex flex-col gap-2 game-cover-shadow bg-base-200 border border-base-100 aspect-2/3">
        <.async_result :let={covers} assign={@covers}>
          <:loading>
            Loading...
          </:loading>

          <:failed>
            No Cover
          </:failed>

          <img
            :if={covers != []}
            class="rounded-tl-md rounded-tr-md"
            src={Games.main_asset_url(covers)}
            alt={@sgdb_game.name}
          />
        </.async_result>

        <span class="font-semibold text-sm truncate px-2 text-center pb-2">{@sgdb_game.name}</span>
      </div>
    </div>
    """
  end
end
