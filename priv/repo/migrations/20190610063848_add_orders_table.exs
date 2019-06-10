defmodule Dummy.Repo.Migrations.AddOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :state, :string, null: false
    end
  end
end
