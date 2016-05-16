class AddMetaToGameImages < ActiveRecord::Migration
  def change
    add_column :game_images, :image_meta, :text
  end
end
