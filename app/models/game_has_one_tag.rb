class GameHasOneTag < GameTag
  # So child classes won't utilize the implied STI table name of this class
  self.abstract_class = true

  # Delegations
  def count
    games_count
  end
end
