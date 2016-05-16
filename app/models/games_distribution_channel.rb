class GamesDistributionChannel < ActiveRecord::Base
  # Associations
  belongs_to :game, counter_cache: true
  belongs_to :distribution_channel, counter_cache: true

  # Validations
  validates :game, presence: true
  validates :distribution_channel, presence: { message: 'Please select a distribution channel.' }

  # Delegations
  delegate :name, to: :distribution_channel
end
