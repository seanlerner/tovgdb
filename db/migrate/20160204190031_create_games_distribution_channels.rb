class CreateGamesDistributionChannels < ActiveRecord::Migration
  def change
    create_table :games_distribution_channels do |t|
      t.references :game
      t.references :distribution_channel
      t.date :released_on
      t.text :uri

      t.timestamps null: false
    end

    add_column :games, :games_distribution_channels_count, :integer, default: 0, null: false
  end
end
