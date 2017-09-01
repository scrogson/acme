defmodule Acme.Support.IssueCreator do
  import Ecto.Changeset
  alias Acme.{Repo, Support}

  def create_issue(user, attrs) do
    %Support.Issue{}
    |> issue_changeset(user, attrs)
    |> Repo.insert()
  end

  defp issue_changeset(issue, user, attrs) do
    issue
    |> cast(attrs, [:subject])
    |> validate_required([:subject])
    |> put_change(:status, "open")
    |> put_assoc(:comments, [comment_changeset(user, attrs)])
  end

  defp comment_changeset(user, attrs) do
    %Support.Comment{}
    |> cast(attrs, [:body])
    |> validate_required([:body])
    |> put_assoc(:user, user)
  end
end
