defmodule Meteor.Games do
  alias Meteor.Games.SGDB

  defdelegate search_sgdb_games(term), to: SGDB
  defdelegate get_sgdb_game(id, api_key), to: SGDB
  defdelegate get_sgdb_covers(id, api_key), to: SGDB
  defdelegate get_sgdb_heroes(id, api_key), to: SGDB
end
