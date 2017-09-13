class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name, null: false
      t.string :uri, null: false
      t.string :menu, null: false
      t.integer :order
      t.timestamps null: false
      t.index :name
      t.index :uri
      t.index %i[menu order]
    end
  end
end
