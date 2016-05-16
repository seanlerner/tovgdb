class AddDistributionModesToGame < ActiveRecord::Migration
  def change
    add_column :games, :digital_distribution, :boolean
    add_column :games, :retail_distribution, :boolean
  end
end
