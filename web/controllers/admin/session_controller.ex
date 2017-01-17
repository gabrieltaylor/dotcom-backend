defmodule Dotcom.Admin.SessionController do
  use Dotcom.Web, :controller

  def new(conn, _params) do
    conn
    |> assign(:browser_title, "LOGIN")
    |> render("new.html")
  end

  def create(conn, %{"session" => session_params}) do
    case Dotcom.Session.login(session_params, Dotcom.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> assign(:browser_title, "LOGIN")
        |> render("new.html")
    end
  end

end
