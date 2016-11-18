defmodule Dotcom.LayoutViewTest do
  use Dotcom.ConnCase, async: true

  alias Dotcom.LayoutView
  alias Dotcom.User

  setup do
    User.changeset(%User{}, %{username: "test",
                              password: "test",
                              password_confirmation: "test",
                              email: "test@test.com",
                              first_name: "Test",
                              last_name: "Tested"})
    |> Repo.insert
    {:ok, conn: build_conn()}
  end

  test "current user returns the user in session", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{username: "test",                                                           password: "test"}
    assert LayoutView.current_user(conn)
  end

  test "current user return nothing is there is no user in the session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end

  test "deletes the user session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})
    conn = delete conn, session_path(conn, :delete, user)
    refute get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Signed out successfully!"
    assert redirected_to(conn) == page_path(conn, :index)
  end

end
