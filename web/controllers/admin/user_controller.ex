defmodule Dotcom.Admin.UserController do
  use Dotcom.Web, :controller

  alias Dotcom.User

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    conn
    |> assign(:browser_title, "Admin • User:")
    |> render("show.html", user: user)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> assign(:browser_title, "Admin • Add User")
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do

    changeset = User.changeset(%User{}, user_params)

    case Dotcom.Authorization.create(changeset, Dotcom.Repo) do
      {:ok, changeset} ->
        conn
        |> put_session(:current_user, changeset.id)
        |> put_flash(:info, "Your account was created")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create account")
        |> assign(:browser_title, "Admin • Add User")
        |> render("new.html", changeset: changeset)
    end

  end

end
