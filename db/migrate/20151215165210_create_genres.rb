class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name, null: false
      t.string :description
      t.integer :games_genres_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
