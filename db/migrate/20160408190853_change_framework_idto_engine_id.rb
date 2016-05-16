class ChangeFrameworkIdtoEngineId < ActiveRecord::Migration
  def change
    rename_column :games, :framework_id, :engine_id
  end
end
