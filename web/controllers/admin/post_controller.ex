defmodule Dotcom.Admin.PostController do
  use Dotcom.Web, :controller

  alias Dotcom.Post
  alias Dotcom.Comment

  require Logger

  plug :scrub_params, "comment" when action in [:add_comment]

  # Pattern Matching for the /post path
  def index(conn, _params) do
    posts = Repo.all(Post)
    conn
    |> assign(:browser_title, "Admin :: Listing Posts")
    |> render("index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    conn
    |> assign(:browser_title, "Admin :: Create Post")
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: admin_post_path(conn, :index))
      {:error, changeset} ->
        conn
        |> assign(:browser_title, "Admin :: Create User")
        |> put_flash(:info, "Unable to create post.")
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.preload([:comments])
    changeset = Comment.changeset(%Comment{})
    conn
    |> assign(:browser_title, "Preview :: #{post.title}")
    |> render("show.html", post: post, changeset: changeset, live: :false)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    conn
    |> assign(:browser_title, "Admin :: Edit :: #{post.title}")
    |> render("edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: admin_post_path(conn, :show, post))
      {:error, changeset} ->
        conn
        |> assign(:browser_title, "Admin :: Edit :: #{post.title}")
        |> render("edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: admin_post_path(conn, :index))
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

end
