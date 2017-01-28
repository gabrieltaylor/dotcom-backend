defmodule Dotcom.User do
  use Dotcom.Web, :model
  alias Dotcom.User

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
    |> validate_format(:email, ~r/@/)
  end

  def login(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Dotcom.Repo.get(User,id)
  end

end
