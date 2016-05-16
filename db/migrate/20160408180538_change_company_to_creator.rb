class ChangeCompanyToCreator < ActiveRecord::Migration
  def change
    rename_table :companies, :creators
    rename_table :games_companies, :games_creators
  end
end
