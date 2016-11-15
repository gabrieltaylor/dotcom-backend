defmodule Dotcom.PageTest do
  use Dotcom.ModelCase

  alias Dotcom.Page

  @valid_attrs %{body: "some content", serp_description: "some content", serp_title: "some content", slug: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Page.changeset(%Page{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Page.changeset(%Page{}, @invalid_attrs)
    refute changeset.valid?
  end
end
