defmodule Meteor.Games do
  alias Meteor.Games.Assets
  alias Meteor.Games.SGDB
  alias Meteor.Games.Store

  defdelegate main_asset_url(assets), to: Assets

  defdelegate search_sgdb_games(term), to: SGDB
  defdelegate get_sgdb_game(id, api_key), to: SGDB
  defdelegate get_sgdb_covers(id, api_key), to: SGDB
  defdelegate get_sgdb_heroes(id, api_key), to: SGDB

  defdelegate change_game(game, attrs \\ %{}), to: Store
  defdelegate delete_game!(game), to: Store
  defdelegate update_game(game, attrs), to: Store
  defdelegate create_game(attrs), to: Store
end
