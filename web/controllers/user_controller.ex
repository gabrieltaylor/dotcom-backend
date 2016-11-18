defmodule Dotcom.UserController do
  use Dotcom.Web, :controller

  alias Dotcom.User

  def index(conn, _params) do
    users = Repo.all(User)
    conn
    |> assign(:browser_title, "Admin :: Listing Users")
    |> render("index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> assign(:browser_title, "Admin :: Create User")
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        conn
        |> assign(:browser_title, "Admin :: Create User")
        |> put_flash(:info, "Unable to create user.")
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    conn
    |> assign(:browser_title, "User :: #{user.username}")
    |> render("show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    conn
    |> assign(:browser_title, "Admin :: Edit :: #{user.username}")
    |> render("edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        conn
        |> assign(:browser_title, "Admin :: Edit :: #{user.username}")
        |> render("edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
