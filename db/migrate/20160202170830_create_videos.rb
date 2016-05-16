class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references  :game
      t.string      :title, null: false
      t.string      :platform, null: false
      t.string      :code, null: false
      t.string      :video_type, null: false
      t.timestamps  null: false
    end
  end
end
