defmodule MeteorWeb.BrowserLive.Browser do
  import MeteorWeb.Live.BrowserLive.Components

  use MeteorWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_module={["browser"]}>
      <div class="flex flex-col justify-center items-center gap-24 h-full">
        <.idle_state />
        <div class="flex flex-col gap-8 items-center w-full">
          <.header alignment="text-center">
            <:title>Game Browser</:title>
            <:subtitle>Find your games on SGDB add add them to your library</:subtitle>
          </.header>
          <.input type="search" name="search" value="" wrapper_class="w-full lg:w-[600px]" />
        </div>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket), do: {:ok, socket}
end
