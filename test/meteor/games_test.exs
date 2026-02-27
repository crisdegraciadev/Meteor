defmodule Meteor.GamesTest do
  use Meteor.DataCase

  alias Meteor.Games

  describe "games" do
    alias Meteor.Games.Game

    import Meteor.GamesFixtures

    @invalid_attrs %{name: nil, cover: nil, sgdb_id: nil, hero: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{name: "some name", cover: "some cover", sgdb_id: 42, hero: "some hero"}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.name == "some name"
      assert game.cover == "some cover"
      assert game.sgdb_id == 42
      assert game.hero == "some hero"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{name: "some updated name", cover: "some updated cover", sgdb_id: 43, hero: "some updated hero"}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.name == "some updated name"
      assert game.cover == "some updated cover"
      assert game.sgdb_id == 43
      assert game.hero == "some updated hero"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
