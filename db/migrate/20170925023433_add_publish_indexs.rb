class AddPublishIndexs < ActiveRecord::Migration
  def change
    add_index :games,    :published
    add_index :creators, :published
  end
end
