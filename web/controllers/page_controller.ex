defmodule Dotcom.PageController do
  use Dotcom.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
