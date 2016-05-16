class RemoveLinkFieldsFromGame < ActiveRecord::Migration
  def change
    remove_column :games, :download_link, :string
    remove_column :games, :steam_link, :string
    remove_column :games, :humble_store_link, :string
    remove_column :games, :gog_link, :string
    remove_column :games, :website, :string
  end
end
