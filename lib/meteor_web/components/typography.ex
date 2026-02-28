defmodule MeteorWeb.Components.Typography do
  use Phoenix.Component
  use Gettext, backend: MeteorWeb.Gettext

  attr :alignment, :string, values: ~w(text-left text-center text-right), default: "text-left"

  slot :title, required: true do
    attr :type, :string, values: ~w(h1 h2 h3 h4)
  end

  slot :subtitle

  def header(assigns) do
    ~H"""
    <header class={["flex flex-col gap-1", @alignment]}>
      <.title :if={@title} type={Map.get(hd(@title), :type, "h1")}>{render_slot(@title)}</.title>
      <.subtitle :if={@subtitle}>{render_slot(@subtitle)}</.subtitle>
    </header>
    """
  end

  attr :type, :string, values: ~w(h1 h2 h3 h4), default: "h1"
  slot :inner_block, required: true

  defp title(assigns) do
    assigns = assigns |> assign(:class, heading_classes(assigns.type))

    ~H"""
    <.dynamic_tag tag_name={@type} class={@class}>
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  slot :inner_block, required: true

  defp subtitle(assigns) do
    assigns = assigns |> assign(:class, heading_classes("h5"))

    ~H"""
    <.dynamic_tag tag_name="h5" class={@class}>
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  defp heading_classes("h1"), do: "text-2xl font-bold"
  defp heading_classes("h2"), do: "text-xl font-semibold"
  defp heading_classes("h3"), do: "text-lg font-semibold"
  defp heading_classes("h4"), do: "text-base font-semibold"
  defp heading_classes("h5"), do: "text-base font-normal text-gray-400"
end
