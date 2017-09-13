class LinkType < ApplicationRecord
  # Constants
  CATEGORIES = ['website', 'email', 'social media', 'other'].freeze

  # Associations
  has_many :links, dependent: :destroy
  has_many :games, through: :links, source: :object_has_link, source_type: 'Game'
  has_many :creators, through: :links, source: :object_has_link, source_type: 'Creator'

  # Validations
  validates :name, presence: { message: 'Please enter the name of this link type.' }
  validates :name, uniqueness: { message: 'This link type already exists.' }
  validates :game_link, presence: { unless: :creator_link, message: 'Please select Game Link, Creator Link or both.' }
  validates :creator_link, presence: { unless: :game_link, message: 'Please select Game Link, Creator Link or both.' }
  validates :category, inclusion: { in: CATEGORIES, message: 'Please select a category for this Link Type.' }
end
