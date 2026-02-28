defmodule Meteor.Games.Store do
  alias Meteor.Games.Game
  alias Meteor.Repo

  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  def create_game(attrs) do
    %Game{} |> change_game(attrs) |> Repo.insert()
  end

  def update_game(%Game{} = game, attrs) do
    game |> change_game(attrs) |> Repo.update()
  end

  def delete_game!(%Game{} = game) do
    Repo.delete!(game)
  end
end
