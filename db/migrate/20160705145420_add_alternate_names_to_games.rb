class AddAlternateNamesToGames < ActiveRecord::Migration
  def change
    add_column :games, :alternate_names, :text
  end
end
