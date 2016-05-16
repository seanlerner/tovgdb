class CreateGamesAwards < ActiveRecord::Migration
  def change
    create_table :games_awards, id: false do |t|
      t.references :game, null: false
      t.references :award, null: false
      t.index [:game_id, :award_id], unique: true
    end
  end
end
