defmodule Acme.Support.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Acme.Support.{Issue, Comment}
  alias Acme.UserManager.User

  schema "comments" do
    field :body, :string

    belongs_to :issue, Issue
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
