class AddPricingToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.boolean :free
      t.boolean :freemium
      t.boolean :free_trial
      t.boolean :donation
      t.boolean :ads
      t.boolean :pay
      t.boolean :not_available
    end
  end
end
