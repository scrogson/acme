defmodule Acme.Support.Issue do
  use Ecto.Schema
  import Ecto.Changeset
  alias Acme.Support.Issue


  schema "issues" do
    field :status, :string
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(%Issue{} = issue, attrs) do
    issue
    |> cast(attrs, [:subject, :status])
    |> validate_required([:subject, :status])
  end
end
