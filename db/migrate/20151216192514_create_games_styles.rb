class CreateGamesStyles < ActiveRecord::Migration
  def change
    create_table :games_styles, id: false do |t|
      t.references :game, null: false
      t.references :style, null: false
      t.index %i[game_id style_id], unique: true
    end
  end
end
