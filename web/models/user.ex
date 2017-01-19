defmodule Dotcom.User do
  use Dotcom.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true

    has_many :posts, Dotcom.Post
    timestamps()
  end

  # Module Attributes Required and Optional Fields
  @required_fields ~w(email)a
  @optional_fields ~w(name)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 5)
    |> validate_format(:email, ~r/@/
  end

end
