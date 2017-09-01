defmodule AcmeWeb.IssueController do
  use AcmeWeb, :controller

  alias Acme.Support
  alias Acme.Support.{Comment, Issue}

  plug :authorize when action not in [:index, :show]

  def index(conn, _params) do
    issues = Support.list_issues()
    render(conn, "index.html", issues: issues)
  end

  def new(conn, _params) do
    comment = Support.change_comment(%Comment{})
    changeset = Support.change_issue(%Issue{comments: [comment]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"issue" => issue_params}) do
    case Support.create_issue(conn.assigns.current_user, issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue created successfully.")
        |> redirect(to: issue_path(conn, :show, issue))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Support.get_issue!(id)
    render(conn, "show.html", issue: issue)
  end

  def edit(conn, %{"id" => id}) do
    issue = Support.get_issue!(id)
    changeset = Support.change_issue(issue)
    render(conn, "edit.html", issue: issue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Support.get_issue!(id)

    case Support.update_issue(issue, issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue updated successfully.")
        |> redirect(to: issue_path(conn, :show, issue))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", issue: issue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Support.get_issue!(id)
    {:ok, _issue} = Support.delete_issue(issue)

    conn
    |> put_flash(:info, "Issue deleted successfully.")
    |> redirect(to: issue_path(conn, :index))
  end

  defp authorize(conn, _) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to create or update issues")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
