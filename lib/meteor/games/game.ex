defmodule Meteor.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :name, :string
    field :sgdb_id, :integer
    field :cover, :string
    field :hero, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :sgdb_id, :cover, :hero])
    |> validate_required([:name, :sgdb_id, :cover, :hero])
  end
end
