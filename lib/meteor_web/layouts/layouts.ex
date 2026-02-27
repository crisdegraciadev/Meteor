defmodule MeteorWeb.Layouts do
  use MeteorWeb, :html

  embed_templates "templates/*"

  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :current_module, :string, default: "/"
  attr :current_scope, :map, default: nil

  slot :inner_block, required: true

  def app(assigns) do
    library_menu = [
      %{label: "Collection", href: ~p"/backlog", icon: "lucide-gamepad-2"},
      %{label: "Backlog", href: ~p"/browser", icon: "lucide-book-marked"},
      %{label: "Browser", href: ~p"/tags", icon: "lucide-file-search-corner"},
      %{label: "Settings", href: ~p"/tags", icon: "lucide-settings"}
    ]

    collections_menu = [
      %{
        label: "PSX",
        href: ~p"/backlog",
        icon: "lucide-gamepad-2",
        children: [
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 3", href: ~p"/backlog", icon: "lucide-gamepad-2"}
        ]
      },
      %{
        label: "PS2",
        href: ~p"/backlog",
        icon: "lucide-gamepad-2",
        children: [
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 3", href: ~p"/backlog", icon: "lucide-gamepad-2"}
        ]
      },
      %{
        label: "PS3",
        href: ~p"/backlog",
        icon: "lucide-gamepad-2",
        children: [
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 1", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 2", href: ~p"/backlog", icon: "lucide-gamepad-2"},
          %{label: "Game 3", href: ~p"/backlog", icon: "lucide-gamepad-2"}
        ]
      }
    ]

    assigns =
      assigns
      |> assign(:library_menu, library_menu)
      |> assign(:collections_menu, collections_menu)

    ~H"""
    <main class="flex h-screen bg-base-300">
      <nav class="flex flex-col gap-8 p-6 w-[280px] bg-base-300 border-r border-neutral-content/25">
        <div class="flex items-center gap-4">
          <img src={~p"/images/logo.svg"} width="56" />
          <.title type="h1">Meteor</.title>
        </div>

        <div class="flex flex-col gap-4 min-h-0 h-full">
          <.menu title="Library">
            <:item
              :for={item <- @library_menu}
              label={item.label}
              href={item.href}
              icon={item.icon}
              active={"/#{Enum.join(@current_module, "/")}" == item.href}
            />
          </.menu>
          <.divider />
          <div class="flex flex-col gap-4 h-full justify-between flex-1 min-h-0">
            <.menu title="Collections" class="flex-1 min-h-0">
              <:item
                :for={item <- @collections_menu}
                label={item.label}
                href={item.href}
                icon={item.icon}
                active={"/#{Enum.join(@current_module, "/")}" == item.href}
                children={item.children}
              />
            </.menu>
            <.divider />
            <.button><.icon name="lucide-folder-tree" />Manage collections</.button>
          </div>
        </div>
      </nav>
      <div class="mx-auto max-w-2xl space-y-4">
        {render_slot(@inner_block)}
      </div>
    </main>

    <.flash_group flash={@flash} />
    """
  end

  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="lucide-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="lucide-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="lucide-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="lucide-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="lucide-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :orientation, :string, default: "menu-vertical"
  attr :class, :string, default: nil

  slot :item do
    attr :label, :string
    attr :href, :string
    attr :icon, :string
    attr :active, :boolean
    attr :children, :any
  end

  defp menu(assigns) do
    ~H"""
    <ul class={["menu w-full", @class]}>
      <li class="menu-title">{@title}</li>

      <ul class="flex-1 min-h-0 overflow-y-auto">
        <li :for={item <- @item}>
          <%= if item[:children] do %>
            <details>
              <summary><.icon :if={item[:icon]} name={item.icon} /> {item.label}</summary>
              <ul>
                <li :for={child <- item.children}>
                  <.menu_item
                    label={child.label}
                    href={child.href}
                    icon={child.icon}
                    active={false}
                  />
                </li>
              </ul>
            </details>
          <% else %>
            <.menu_item label={item.label} href={item.href} icon={item.icon} active={item.active} />
          <% end %>
        </li>
      </ul>
    </ul>
    """
  end

  attr :label, :string
  attr :href, :string
  attr :icon, :string
  attr :active, :boolean

  defp menu_item(assigns) do
    ~H"""
    <.link class={[@active && "menu-active"]} navigate={@href}>
      <.icon :if={@icon} name={@icon} /> {@label}
    </.link>
    """
  end
end
