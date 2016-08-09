class GamesPlatform < ActiveRecord::Base
  # Associations
  belongs_to :game, counter_cache: true
  belongs_to :platform, counter_cache: true

  # Validations
  # validates :game, presence: true
  validates :platform, presence: { message: 'Please select a platform.' }

  # Delegations
  delegate :name, to: :platform
end
