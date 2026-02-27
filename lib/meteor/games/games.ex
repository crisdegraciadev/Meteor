defmodule Meteor.Games do
  import Ecto.Query, warn: false
  alias Meteor.Repo

  alias Meteor.Games.Game

  def list_games do
    Repo.all(Game)
  end

  def get_game!(id), do: Repo.get!(Game, id)

  def create_game(attrs) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end
end
