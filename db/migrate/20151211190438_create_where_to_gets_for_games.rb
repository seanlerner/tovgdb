class CreateWhereToGetsForGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.string :steam_link
      t.string :download_link
      t.string :humble_store_link
      t.string :gog_link
    end
  end
end
