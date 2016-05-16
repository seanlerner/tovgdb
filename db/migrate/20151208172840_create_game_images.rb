class CreateGameImages < ActiveRecord::Migration
  def change
    create_table :game_images do |t|
      t.references :game, index: true, foreign_key: true, null: false
      t.string :caption
    end
    add_attachment :game_images, :image
  end
end
