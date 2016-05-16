class AddIndexesToGames < ActiveRecord::Migration
  def change
    add_index :games, :framework_id
    add_index :games, :series_id
  end
end
