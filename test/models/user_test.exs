defmodule Dotcom.UserTest do
  use Dotcom.ModelCase

  alias Dotcom.User

  @valid_attrs %{email: "some content", first_name: "some content", last_name: "some content", password: "test1234", password_confirmation: "test1234", username: "some content"}
  @pass_nil %{email: "some content", first_name: "some content", last_name: "some content", password: nil, password_confirmation: nil, username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password_digest value gets set to a hash" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, Ecto.Changeset.get_change(changeset, :password_digest))
  end

  test "password_digest value does not get set if password is nil" do
    changeset = User.changeset(%User{}, @pass_nil)
    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end

end
