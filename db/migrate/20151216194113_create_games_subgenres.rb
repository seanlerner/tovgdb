class CreateGamesSubgenres < ActiveRecord::Migration
  def change
    create_table :games_subgenres, id: false do |t|
      t.references :game, null: false
      t.references :subgenre, null: false
      t.index [:game_id, :subgenre_id], unique: true
    end
  end
end
