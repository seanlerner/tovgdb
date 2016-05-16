class RemoveGameModesCountFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :games_modes_count, :integer
  end
end
