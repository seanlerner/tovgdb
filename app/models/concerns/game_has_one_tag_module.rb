module GameHasOneTagModule
  extend ActiveSupport::Concern

  # Instance Methods
  included do
    # Associations
    has_many :games

    # Scopes
    scope :non_zero_count, -> { where('games_count > 0') }
  end
end
