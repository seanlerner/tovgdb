class NewGameAttributes < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.integer :framework_id
      t.integer :series_id
      t.date :initial_release_on
      t.string :video_header
      t.text :video_embed_code
      t.integer :games_modes_count, default: 0, null: false
      t.integer :games_platforms_count, default: 0, null: false
    end
  end
end
