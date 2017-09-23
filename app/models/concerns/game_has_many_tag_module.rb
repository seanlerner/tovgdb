module GameHasManyTagModule
  extend ActiveSupport::Concern

  # Instance
  included do
    # Associations
    has_many game_join_model_as_symbol
    has_many :games, through: game_join_model_as_symbol, dependent: :destroy

    # Delegations
    delegate :count, to: game_join_model

    # Scopes
    scope :non_zero_count, -> { where('? > 0', "#{game_join_model}_count") }
  end
end
