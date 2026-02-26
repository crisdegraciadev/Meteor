defmodule Meteor.Repo do
  use Ecto.Repo,
    otp_app: :meteor,
    adapter: Ecto.Adapters.SQLite3
end
