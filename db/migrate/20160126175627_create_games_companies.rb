class CreateGamesCompanies < ActiveRecord::Migration
  def change
    create_table :games_companies do |t|
      t.references  :game, index: true, foreign_key: true
      t.references  :company, index: true, foreign_key: true
      t.boolean     :developer
      t.boolean     :publisher
      t.index %i[game_id company_id], unique: true
    end
  end
end
