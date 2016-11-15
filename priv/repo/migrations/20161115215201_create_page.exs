defmodule Dotcom.Repo.Migrations.CreatePage do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :serp_title, :string
      add :serp_description, :string
      add :slug, :string
      add :body, :text

      timestamps()
    end

  end
end
