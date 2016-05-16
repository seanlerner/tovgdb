class ChangeColumnForCompaniesToCreators < ActiveRecord::Migration
  def change
    rename_column :creators, :games_companies_count, :games_creators_count
    rename_column :games, :games_companies_count, :games_creators_count
    rename_column :games_creators, :company_id, :creator_id
    rename_column :link_types, :company_link, :creator_link
  end
end
