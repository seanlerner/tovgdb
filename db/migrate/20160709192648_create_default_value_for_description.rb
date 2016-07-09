class CreateDefaultValueForDescription < ActiveRecord::Migration
  def up
    Game::MANY_TAGS.each do |tag|
      change_column tag.symbol_pluralized, :description, :string, default: ''
    end
  end

  def down
    Game::MANY_TAGS.each do |tag|
      change_column tag.symbol_pluralized, :description, :string
    end
  end
end
