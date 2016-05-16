class NoNilAllowedForStringAndTextFields < ActiveRecord::Migration
  def change
    change_column_null :platforms, :description, false, ''
    change_column_null :games_distribution_channels, :uri, false, ''
    change_column_null :awards, :description, false, ''
    change_column_null :communities, :description, false, ''
    change_column_null :companies, :description, false, ''
    change_column_null :distribution_channels, :description, false, ''
    change_column_null :frameworks, :description, false, ''
    change_column_null :game_images, :caption, false, ''
    change_column_null :games, :short_description, false, ''
    change_column_null :games, :long_description, false, ''
    change_column_null :genres, :description, false, ''
    change_column_null :links, :description_override, false, ''
    change_column_null :pages, :content, false, ''
    change_column_null :series, :description, false, ''
    change_column_null :styles, :description, false, ''
    change_column_null :subgenres, :description, false, ''
    change_column_null :themes, :description, false, ''
  end
end
