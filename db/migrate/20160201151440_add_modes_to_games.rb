class AddModesToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.integer :minimum_number_of_players
      t.integer :maximum_number_of_players
      t.boolean :local_play
      t.boolean :online_play
      t.boolean :coop_play
      t.boolean :competitive_play
    end
  end
end
