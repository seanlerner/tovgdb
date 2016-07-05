class AddAlternateNamesToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :alternate_names, :string
  end
end
