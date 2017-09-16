class RemoveAwards < ActiveRecord::Migration
  def up
    drop_table    :awards
    drop_table    :games_awards
    remove_column :games, :games_awards_count
  end

  def down
    create_table :awards do |t|
      t.string :name, null: false
      t.string :description
      t.integer :games_awards_count, default: 0, null: false
      t.timestamps null: false
    end
    create_table :games_awards, id: false do |t|
      t.references :game, null: false
      t.references :award, null: false
      t.index %i[game_id award_id], unique: true
    end
    add_column :games, :games_awards_count, :integer, default: 0, null: false
  end
end
