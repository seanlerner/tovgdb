class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name, null: false
      t.string :description
      t.integer :games_themes_count, default: 0, null: false
      t.timestamps null: false
    end
    create_table :games_themes, id: false do |t|
      t.references :game, null: false
      t.references :theme, null: false
      t.index %i[game_id theme_id], unique: true
    end
    add_column :games, :games_themes_count, :integer, default: 0, null: false
  end
end
