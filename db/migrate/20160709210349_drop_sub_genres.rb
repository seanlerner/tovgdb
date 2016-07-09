class DropSubGenres < ActiveRecord::Migration
  def change
    drop_table :subgenres do |t|
      t.string   'name',                  limit: 255,              null: false
      t.string   'description',           limit: 255, default: '', null: false
      t.integer  'games_subgenres_count', limit: 4,   default: 0,  null: false
      t.datetime 'created_at',                                     null: false
      t.datetime 'updated_at',                                     null: false
    end

    drop_table :games_subgenres do |t|
      t.integer 'game_id',     limit: 4, null: false
      t.integer 'subgenre_id', limit: 4, null: false
    end

    remove_column :games, :games_subgenres_count, :integer
  end
end
