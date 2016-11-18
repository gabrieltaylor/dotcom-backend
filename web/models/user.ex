defmodule Dotcom.User do
  use Dotcom.Web, :model

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :email, :string
    field :password_digest, :string

    timestamps()

    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :username, :email, :password, :password_confirmation])
    |> validate_required([:first_name, :last_name, :username, :email, :password, :password_confirmation])
  end
end
