class AddSelfPublishedToGame < ActiveRecord::Migration
  def change
    add_column :games, :self_published, :boolean
  end
end
