class AddNewFieldsFromMediawikiToGamess < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.text :old_raw_mediawiki_data
    end
  end
end
