defmodule MeteorWeb.Live.BrowserLive.Components do
  use Phoenix.Component
  use MeteorWeb, :html

  def idle_state(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-2">
      <div class="flex gap-4">
        <.icon name="lucide-skull" size="size-28" class="opacity-50" />
        <.icon name="lucide-boxes" size="size-28" class="opacity-50" />
      </div>
      <div class="flex gap-4">
        <.icon name="lucide-ghost" size="size-28" class="opacity-50" />
        <.icon name="lucide-rocket" size="size-28" class="opacity-50" />
        <.icon name="lucide-land-plot" size="size-28" class="opacity-50" />
      </div>
      <div class="flex gap-4">
        <.icon name="lucide-skull" size="size-28" class="opacity-50" />
        <.icon name="lucide-boxes" size="size-28" class="opacity-50" />
      </div>
    </div>
    """
  end
end
