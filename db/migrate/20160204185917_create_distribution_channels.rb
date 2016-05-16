class CreateDistributionChannels < ActiveRecord::Migration
  def change
    create_table :distribution_channels do |t|
      t.string :name
      t.string :description
      t.string  :category
      t.integer :games_distribution_channels_count
      t.timestamps null: false
    end
  end
end
