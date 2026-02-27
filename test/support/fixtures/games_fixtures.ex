defmodule Meteor.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Meteor.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        cover: "some cover",
        hero: "some hero",
        name: "some name",
        sgdb_id: 42
      })
      |> Meteor.Games.create_game()

    game
  end
end
