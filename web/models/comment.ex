defmodule Dotcom.Comment do
  use Dotcom.Web, :model

  schema "comments" do
    field :name, :string
    field :content, :string
    belongs_to :post, Dotcom.Post, foreign_key: :post_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :content])
    |> validate_required([:name, :content, :post_id])
  end
end
