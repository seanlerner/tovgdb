class DistributionChannel < ApplicationRecord
  # Constants
  CATEGORIES = ['where to get', 'where to play', 'other'].freeze

  # Associations
  has_many :games_distribution_channels, dependent: :destroy
  has_many :games, through: :games_distribution_channels

  # Validations
  validates :name, presence: { message: 'Please enter the name of this distribution channel.' }
  validates :name, uniqueness: { message: 'This distribution channel already exists.' }
  validates :category, inclusion: { in: CATEGORIES, message: 'Please select a category for this distribution channel.' }
end
