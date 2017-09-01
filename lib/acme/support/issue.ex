defmodule Acme.Support.Issue do
  use Ecto.Schema
  import Ecto.Changeset
  alias Acme.Support.{Issue, Comment}

  schema "issues" do
    field :status, :string
    field :subject, :string

    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(%Issue{} = issue, attrs) do
    issue
    |> cast(attrs, [:subject])
    |> validate_required([:subject])
  end
end
