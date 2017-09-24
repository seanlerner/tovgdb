class AddPrimaryKeyToTags < ActiveRecord::Migration
  def change
    add_column :games_genres,      :id, :primary_key
    add_column :games_communities, :id, :primary_key
    add_column :games_themes,      :id, :primary_key
    add_column :games_styles,      :id, :primary_key
  end
end
