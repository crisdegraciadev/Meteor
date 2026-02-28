defmodule MeteorWeb.Live.BrowserLive.Components do
  use Phoenix.Component
  use MeteorWeb, :html

  alias Meteor.Games
  alias MeteorWeb.Live.BrowserLive.SGDBGameModal

  def idle_state(assigns) do
    ~H"""
    <div />
    <div class="flex flex-col gap-12">
      <div class="flex flex-col items-center gap-2">
        <div class="flex gap-4">
          <.icon name="lucide-gamepad" size="size-24" class="opacity-50" />
          <.icon name="lucide-shapes" size="size-24" class="opacity-50" />
        </div>
        <div class="flex gap-4">
          <.icon name="lucide-ghost" size="size-24" class="opacity-50" />
          <.icon name="lucide-rocket" size="size-24" class="opacity-50" />
          <.icon name="lucide-land-plot" size="size-24" class="opacity-50" />
        </div>
        <div class="flex gap-4">
          <.icon name="lucide-skull" size="size-24" class="opacity-50" />
          <.icon name="lucide-boxes" size="size-24" class="opacity-50" />
        </div>
      </div>

      <.header alignment="text-center">
        <:title>Game Browser</:title>
        <:subtitle>Find your games on SGDB add add them to your library</:subtitle>
      </.header>
    </div>
    """
  end

  attr :query, :string, default: ""

  def search_game_form(assigns) do
    assigns = assign(assigns, :form, to_form(%{"query" => assigns.query}))

    ~H"""
    <.form for={@form} id="search-form" phx-submit="search">
      <.input field={@form[:query]} type="search" wrapper_class="w-full lg:w-[600px]" />
    </.form>
    """
  end

  attr :results, :list, default: []
  attr :query, :string, required: true
  attr :api_key, :string, required: true

  def search_game_list(assigns) do
    ~H"""
    <div class="max-w-[1920px] flex flex-col flex-1 min-h-0 gap-4">
      <.header alignment="text-center">
        <:title>Results</:title>
        <:subtitle>Mario Kart 64</:subtitle>
      </.header>
      <div class="grid grid-cols-10 gap-4 overflow-y-scroll scroll-fade">
        <.link
          :for={sgdb_game <- @results}
          patch={~p"/browser/#{sgdb_game.id}/new?query=#{@query}"}
        >
          <.live_component
            module={SGDBGameModal}
            id={sgdb_game.id}
            sgdb_game={sgdb_game}
            api_key={@api_key}
          />
        </.link>
      </div>
    </div>
    """
  end

  attr :sgdb_game, :map, required: true
  attr :query, :string, required: true

  def add_game_modal(assigns) do
    # changeset = Games.change_game(%Games.Game{}, assigns.user)
    #
    # assigns = assigns |> assign(:form, to_form(changeset))

    assigns = assign(assigns, :form, to_form(%{"name" => "", "platform" => ""}))

    ~H"""
    <.modal
      id="add-game-modal"
      backdrop_link={~p"/browser"}
      closable={false}
      class="!max-w-[1920px] !p-0"
    >
      <:body>
        <img
          src={@sgdb_game.hero}
          class="absolute top-0 left-0 right-0 h-[620px] object-fit object-cover brightness-80 "
        />
        <div class="absolute inset-x-0 top-0 h-[620px] bg-gradient-to-t from-base-200 to-transparent" />

        <img
          src={@sgdb_game.cover}
          class="absolute top-10 max-h-[500px] rounded-md left-1/2 -translate-x-1/2 "
        />

        <.header alignment="text-center" class="mt-[575px] relative z-10">
          <:title>{@sgdb_game.name}</:title>
        </.header>

        <.form for={@form} id="search-form" phx-submit="search" class="flex flex-col gap-2 max-w-[400px] mx-auto mt-4">
          <.input field={@form[:name]} label="Name" />
          <.input field={@form[:platform]} label="Platform" type="select" options={["PC","B"]} />
          <.input field={@form[:status]} label="Platform" type="select" options={["Pending","B"]} />
          <.button class="mt-3">Save to library</.button>
        </.form>
      </:body>
    </.modal>
    """
  end
end
