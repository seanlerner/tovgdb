class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references  :object_has_link, polymorphic: true, index: true
      t.references  :link_type, null: false
      t.text        :uri, null: false
      t.string      :description_override, null: true
    end
  end
end
