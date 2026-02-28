defmodule MeteorWeb.BrowserLive.Browser do
  alias Meteor.Games

  import MeteorWeb.Live.BrowserLive.Components

  use MeteorWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_module={["browser"]}>
      <div class="flex flex-col justify-between items-center gap-12 h-full">
        <.idle_state :if={!assigns[:results]} />
        <.search_game_list
          :if={assigns[:results]}
          results={@results}
          query={@query}
          api_key={@api_key}
        />
        <.search_game_form query={@query} />

        <.add_game_modal sgdb_game={@sgdb_game} query={@query} :if={@live_action == :new} />
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket), do: {:ok, socket}

  @impl true
  def handle_params(%{"query" => query, "id" => id}, _session, socket) do
    socket =
      socket
      |> assign(:query, query)
      |> assign_api_key()
      |> assign_game(id)
      |> assign_results()

    {:noreply, socket}
  end

  @impl true
  def handle_params(%{"query" => query}, _session, socket) do
    socket = socket |> assign(:query, query) |> assign_api_key() |> assign_results()

    {:noreply, socket}
  end

  @impl true
  def handle_params(_params, _session, socket) do
    socket = socket |> assign(:query, "") |> assign_api_key()

    {:noreply, socket}
  end

  @impl true
  def handle_event("search", %{"query" => query}, socket) do
    {:noreply, push_navigate(socket, to: ~p"/browser?query=#{query}", replace: true)}
  end

  defp assign_game(%{assigns: %{api_key: api_key}} = socket, id) do
    {:ok, %{game: %{id: id, name: name}}} = Games.get_sgdb_game(id, api_key)
    {:ok, %{covers: covers}} = Games.get_sgdb_covers(id, api_key)
    {:ok, %{heroes: heroes}} = Games.get_sgdb_heroes(id, api_key)

    sgdb_game = %{
      id: id,
      name: name,
      cover: Games.main_asset_url(covers),
      hero: Games.main_asset_url(heroes)
    }

    assign(socket, :sgdb_game, sgdb_game)
  end

  defp assign_results(%{assigns: %{query: query}} = socket) do
    case Games.search_sgdb_games(query) do
      {:ok, results} -> socket |> assign(:results, results)
      {:error, reason} -> socket |> put_flash(:error, reason)
    end
  end

  defp assign_api_key(socket) do
    assign(socket, :api_key, "308a3c68054ac576ef368baf1c4ac532")
  end
end
