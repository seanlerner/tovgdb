class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.string :description
      t.integer :games_communities_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
