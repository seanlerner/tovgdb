class RemoveVideoFieldsFromGame < ActiveRecord::Migration
  def change
    remove_column :games, :video_embed_code, :text
    remove_column :games, :video_header, :text
  end
end
