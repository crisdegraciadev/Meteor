defmodule Meteor.Games.SGDBGame do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string
    field :cover, :string
    field :hero, :string
    field :logo, :string
    field :icon, :string
  end

  def changeset(sgdb_game, params) do
    sgdb_game
    |> cast(params, [:id, :name, :cover, :hero, :logo, :icon])
    |> validate_required([:id, :name])
  end
end
