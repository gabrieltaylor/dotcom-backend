defmodule Dotcom.LayoutView do
  use Dotcom.Web, :view

  # Is the User Logged in?
  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end
  
end
