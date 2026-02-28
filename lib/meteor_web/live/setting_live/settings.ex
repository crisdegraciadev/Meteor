defmodule MeteorWeb.SettingsLive.Settings do
  use MeteorWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_module={["library", "settings"]}>
      Settings Page
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket), do: {:ok, socket}
end
