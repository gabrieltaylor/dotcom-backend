defmodule Dotcom.Page do
  use Dotcom.Web, :model

  schema "pages" do
    field :title, :string
    field :serp_title, :string
    field :serp_description, :string
    field :slug, :string
    field :body, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :serp_title, :serp_description, :slug, :body])
    |> validate_required([:title, :serp_title, :serp_description, :slug, :body])
  end
end
