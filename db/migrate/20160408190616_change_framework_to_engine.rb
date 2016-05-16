class ChangeFrameworkToEngine < ActiveRecord::Migration
  def change
    rename_table :frameworks, :engines
  end
end
