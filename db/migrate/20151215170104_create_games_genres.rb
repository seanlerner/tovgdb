class CreateGamesGenres < ActiveRecord::Migration
  def change
    create_table :games_genres, id: false do |t|
      t.references :game, null: false
      t.references :genre, null: false
      t.index %i[game_id genre_id], unique: true
    end
  end
end
