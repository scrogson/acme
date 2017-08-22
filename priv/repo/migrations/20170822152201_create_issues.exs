defmodule Acme.Repo.Migrations.CreateIssues do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :subject, :string
      add :status, :string

      timestamps()
    end

  end
end
