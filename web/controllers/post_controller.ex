defmodule Dotcom.PostController do
  use Dotcom.Web, :controller

  alias Dotcom.Post
  alias Dotcom.Comment

  require Logger

  plug :scrub_params, "comment" when action in [:add_comment]

  # Pattern Matching for all slugs in the / path
  def index(conn, %{"permalink" => permalink}) do
    # Ecto DSL to query the database
    query = from p in Post,
      where: p.slug == ^permalink,
      select: p
    post = Repo.one!(query) |> Repo.preload([:comments])
    # Includes the Comment model changeset
    changeset = Comment.changeset(%Comment{})
    # Conn is piped for more than one operation
    conn
    |> assign(:browser_title, post.title)
    |> render("show.html", post: post, changeset: changeset, live: :true)
  end

  # Pattern Matching for the /post path
  def index(conn, _params) do
    posts = Repo.all(Post)
    conn
    |> assign(:browser_title, "Admin :: Listing Posts")
    |> render("index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.preload([:comments])
    changeset = Comment.changeset(%Comment{})
    conn
    |> assign(:browser_title, "Preview :: #{post.title}")
    |> render("show.html", post: post, changeset: changeset, live: :false)
  end

  # Support Comments on Blog Posts
  def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    changeset = Comment.changeset(%Comment{}, Map.put(comment_params, "post_id", post_id))
    post = Post |> Repo.get(post_id) |> Repo.preload([:comments])

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Comment added.")
      |> redirect(to: post_path(conn, :show, post))

    else
      render(conn, "show.html", post: post, changeset: changeset)
    end

  end

  def home(conn, _params) do
    query = from p in Post,
    where: p.slug == "home",
    select: p
    home = Repo.one!(query)
    conn
    |> assign(:browser_title, home.title)
    |> render("home.html", page: home)
  end

end
