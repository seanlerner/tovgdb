class AddNewCountColumnsToGames < ActiveRecord::Migration
  def change
    add_column :games, :games_genres_count, :integer, default: 0, null: false
    add_column :games, :games_styles_count, :integer, default: 0, null: false
    add_column :games, :games_communities_count, :integer, default: 0, null: false
    add_column :games, :games_subgenres_count, :integer, default: 0, null: false
    add_column :games, :games_awards_count, :integer, default: 0, null: false
  end
end
