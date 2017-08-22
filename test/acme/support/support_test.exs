defmodule Acme.SupportTest do
  use Acme.DataCase

  alias Acme.Support

  describe "issues" do
    alias Acme.Support.Issue

    @valid_attrs %{status: "some status", subject: "some subject"}
    @update_attrs %{status: "some updated status", subject: "some updated subject"}
    @invalid_attrs %{status: nil, subject: nil}

    def issue_fixture(attrs \\ %{}) do
      {:ok, issue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Support.create_issue()

      issue
    end

    test "list_issues/0 returns all issues" do
      issue = issue_fixture()
      assert Support.list_issues() == [issue]
    end

    test "get_issue!/1 returns the issue with given id" do
      issue = issue_fixture()
      assert Support.get_issue!(issue.id) == issue
    end

    test "create_issue/1 with valid data creates a issue" do
      assert {:ok, %Issue{} = issue} = Support.create_issue(@valid_attrs)
      assert issue.status == "some status"
      assert issue.subject == "some subject"
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Support.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue" do
      issue = issue_fixture()
      assert {:ok, issue} = Support.update_issue(issue, @update_attrs)
      assert %Issue{} = issue
      assert issue.status == "some updated status"
      assert issue.subject == "some updated subject"
    end

    test "update_issue/2 with invalid data returns error changeset" do
      issue = issue_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.update_issue(issue, @invalid_attrs)
      assert issue == Support.get_issue!(issue.id)
    end

    test "delete_issue/1 deletes the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{}} = Support.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Support.get_issue!(issue.id) end
    end

    test "change_issue/1 returns a issue changeset" do
      issue = issue_fixture()
      assert %Ecto.Changeset{} = Support.change_issue(issue)
    end
  end
end
