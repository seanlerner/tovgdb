class CreateGamePlatforms < ActiveRecord::Migration
  def change
    create_table :games_platforms do |t|
      t.references :game, null: false
      t.references :platform, null: false
      t.date :released_on
      t.index %i[game_id platform_id], unique: true
    end
  end
end
