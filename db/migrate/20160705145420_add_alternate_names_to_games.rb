class AddAlternateNamesToGames < ActiveRecord::Migration
  def change
    add_column :games, :alternate_names, :string
  end
end
