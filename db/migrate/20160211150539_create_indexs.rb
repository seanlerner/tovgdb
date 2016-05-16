class CreateIndexs < ActiveRecord::Migration
  def change
    add_index :games, :name, unique: true
    add_index :games, :published_on
    add_index :games, :initial_release_on
    add_index :games, :minimum_number_of_players
    add_index :games, :maximum_number_of_players
    add_index :awards, :name, unique: true
    add_index :communities, :name, unique: true
    add_index :companies, :name, unique: true
    add_index :companies, :founded_on
    add_index :links, [:object_has_link_id, :link_type_id]
    add_index :distribution_channels, :name, unique: true
    add_index :distribution_channels, :category
    add_index :frameworks, :name, unique: true
    add_index :games_distribution_channels, [:game_id, :distribution_channel_id], \
              name: 'index_games_dist_channels_on_game_id_and_dist_channel_id', unique: true
    add_index :games_distribution_channels, :released_on
    add_index :games_platforms, :released_on
    add_index :genres, :name, unique: true
    add_index :link_types, :name, unique: true
    add_index :link_types, :company_link
    add_index :link_types, :game_link
    add_index :platforms, :name, unique: true
    add_index :series, :name, unique: true
    add_index :styles, :name, unique: true
    add_index :subgenres, :name, unique: true
    add_index :themes, :name, unique: true
    add_index :videos, :game_id
  end
end
