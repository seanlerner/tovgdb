class RemoveWebsiteFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :website, :string
  end
end
