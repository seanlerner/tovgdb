class CreateSubgenres < ActiveRecord::Migration
  def change
    create_table :subgenres do |t|
      t.string :name, null: false
      t.string :description
      t.integer :games_subgenres_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
