class GameHasManyTag < GameTag
  # So child classes won't utilize the implied STI table name of this class
  self.abstract_class = true

  # Class Methods
  def self.game_join_model
    "games_#{lowercase_pluralized}"
  end

  def self.game_join_model_as_symbol
    "games_#{lowercase_pluralized}".to_sym
  end
end
