defmodule Dotcom.PageController do
  use Dotcom.Web, :controller

  alias Dotcom.Page

  # Makes logging available
  require Logger

  def index(conn, _params) do
    query = from p in Page,
      where: p.slug == "home",
      select: p
    page = Repo.one!(query)
    # Original Method, no Title Information
    # render(conn, "index.html", page: page)
    conn
    |> assign(:browser_title, page.title)
    |> render("index.html", page: page)
  end


end
