class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :website
      t.text :description
      t.attachment :logo
      t.integer :games_companies_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
