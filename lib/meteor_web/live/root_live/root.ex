defmodule MeteorWeb.RootLive.Root do
  use MeteorWeb, :live_view

  def mount(_params, _session, socket), do: {:ok, socket |> redirect(to: ~p"/dashboard")}
end
