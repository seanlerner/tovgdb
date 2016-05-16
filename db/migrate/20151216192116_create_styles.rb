class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name, null: false
      t.string :description
      t.integer :games_styles_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
