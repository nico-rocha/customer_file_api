defmodule CustomerFileApi.Repo.Migrations.Customers do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :age, :integer
      add :imported, :boolean, default: false
      timestamps()
    end
  end
end
