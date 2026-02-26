defmodule MeteorWeb.PageController do
  use MeteorWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
