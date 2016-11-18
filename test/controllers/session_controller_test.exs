defmodule Dotcom.SessionControllerTest do
  use Dotcom.ConnCase

  alias Dotcom.User

  setup do
    User.changeset(%User{}, %{username: "filhona", 
                              password: "lila",
                              password_confirmation: "lila",
                              email: "filhona@lila.com",
                              first_name: "Filhona",
                              last_name: "Lila"})
    |> Repo.insert
    {:ok, conn: build_conn()}
  end

  test "shows the login form", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "Login"
  end

  test "valid user/pass logins successfully", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{username: "filhona", password: "lila"}
    assert get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Sign in successful!"
    assert redirected_to(conn) == page_path(conn, :index)
  end
  
  test "invalid password login is unsuccessful", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{username: "filhona", password: "WRONG"}
    refute get_session(conn, :current_user)
    assert get_flash(conn, :error) == "Invalid username/password combination!"
    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "invalid user login is unsuccessful", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{username: "NOTEXISTS", password: "WRONG"}
    refute get_session(conn, :current_user)
    assert get_flash(conn, :error) == "Invalid username/password combination!"
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
