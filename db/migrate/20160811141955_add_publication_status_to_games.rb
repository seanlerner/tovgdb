class AddPublicationStatusToGames < ActiveRecord::Migration
  def change
    add_column :games, :publication_status, :string
  end
end
