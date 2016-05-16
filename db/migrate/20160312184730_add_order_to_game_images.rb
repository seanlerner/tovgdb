class AddOrderToGameImages < ActiveRecord::Migration
  def change
    add_column :game_images, :order, :integer
    add_index :game_images, :order, unique: false
  end
end
