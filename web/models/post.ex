defmodule Dotcom.Post do
  use Dotcom.Web, :model
  import Ecto.Query

  schema "posts" do
    field :title, :string
    field :body, :string
    field :slug, :string
    field :serp_title, :string
    field :serp_description, :string

    has_many :comments, Dotcom.Comment, on_delete: :delete_all
    belongs_to :user, Dotcom.User
    timestamps()
  end

  @required_fields ~w(title slug)a
  @optional_fields ~w(body serp_title serp_description)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end

  @doc """
  Returns a collection of Posts and count as the number
  of comments.
  """
  def count_comments(query) do
    from p in query,
      group_by: p.id,
      left_join: c in assoc(p, :comments),
      select: {p, count(c.id)}
  end
end
