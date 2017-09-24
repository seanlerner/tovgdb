class GameHandlesEmptyDesc < ActiveRecord::Migration
  def up
    change_column_default(:games, :short_description, '')
  end

  def down
    change_column_default(:games, :short_description, nil)
  end
end
