defmodule ModernArt.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:games, [:name])
  end
end
