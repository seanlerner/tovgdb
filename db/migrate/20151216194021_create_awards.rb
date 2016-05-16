class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name, null: false
      t.string :description
      t.integer :games_awards_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
