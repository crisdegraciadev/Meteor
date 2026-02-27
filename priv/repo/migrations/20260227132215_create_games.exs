defmodule Meteor.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :sgdb_id, :integer
      add :cover, :string
      add :hero, :string

      timestamps(type: :utc_datetime)
    end
  end
end
