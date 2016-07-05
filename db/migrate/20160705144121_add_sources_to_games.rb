class AddSourcesToGames < ActiveRecord::Migration
  def change
    add_column :games, :sources, :text
  end
end
