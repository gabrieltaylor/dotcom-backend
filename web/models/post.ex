defmodule Dotcom.Post do
  use Dotcom.Web, :model

  schema "posts" do
    field :title, :string
    field :body, :string

    has_many :comments, Dotcom.Comment
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
  end
end
