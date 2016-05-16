class AddNewFieldsFromMediawikiToCompanies < ActiveRecord::Migration
  def change
    change_table :companies do |t|
      t.text :old_raw_mediawiki_data
      t.date :founded_on
    end
  end

  def up
    change_column :companies, :description, :text
  end

  def down
    change_column :companies, :description, :string
  end
end
