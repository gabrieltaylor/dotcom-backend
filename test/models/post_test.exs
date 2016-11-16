defmodule Dotcom.PostTest do
  use Dotcom.ModelCase

  alias Dotcom.Post

  @valid_attrs %{body: "some content",
                 title: "some content",
                 slug: "some-slug",
                 serp_title: "some SERP title",
                serp_description: "some SERP desc"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
