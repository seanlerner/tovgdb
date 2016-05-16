class CreateLinkTypes < ActiveRecord::Migration
  def change
    create_table :link_types do |t|
      t.string  :name, null: false, uniqueness: true
      t.boolean :game_link
      t.boolean :company_link
      t.string  :category
    end
  end
end
