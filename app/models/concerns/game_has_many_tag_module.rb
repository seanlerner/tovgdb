module GameHasManyTagModule
  extend ActiveSupport::Concern

  # Instance
  included do
    # Associations
    has_many game_join_model_as_symbol
    has_many :games, through: game_join_model_as_symbol

    # Delegations
    delegate :count, to: game_join_model

    # Scopes
    scope :non_zero_count, -> { where("#{game_join_model}_count > 0") }

    # Instance Methods
    def published_games
      games.published
    end
  end
end
