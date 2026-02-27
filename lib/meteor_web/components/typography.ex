defmodule MeteorWeb.Components.Typography do
  use Phoenix.Component
  use Gettext, backend: MeteorWeb.Gettext

  attr :type, :string, values: ~w(h1 h2 h3 h4 h5 h6), default: "h1"
  slot :inner_block, required: true

  def title(assigns) do
    assigns = assigns |> assign(:class, heading_classes(assigns.type))

    ~H"""
    <.dynamic_tag tag_name={@type} class={@class}>
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  defp heading_classes("h1"), do: "text-xl font-bold"
  defp heading_classes("h2"), do: "text-lg font-semibold"
  defp heading_classes("h3"), do: "text-base font-semibold"
  defp heading_classes("h4"), do: "text-sm font-semibold"
end
