class CreateGamesCommunities < ActiveRecord::Migration
  def change
    create_table :games_communities, id: false do |t|
      t.references :game, null: false
      t.references :community, null: false
      t.index %w[game_id community_id], unique: true
    end
  end
end
