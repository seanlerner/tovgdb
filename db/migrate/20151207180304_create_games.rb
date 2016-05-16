class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.string :website
      t.string :short_description
      t.text :long_description
      t.date :published_on
      t.integer :games_companies_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
