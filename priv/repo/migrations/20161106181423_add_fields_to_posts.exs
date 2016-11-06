defmodule Dotcom.Repo.Migrations.AddFieldsToPosts do
  use Ecto.Migration

  def change do

    alter table(:posts) do
      add :slug, :string
      add :serp_title, :string
      add :serp_description, :string
    end

  end

end
