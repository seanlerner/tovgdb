class Link < ActiveRecord::Base
  # Associations
  belongs_to :link_type
  belongs_to :object_has_link, polymorphic: true

  # Scopes
  scope :games, -> { where(object_has_link_type: 'Game') }
  scope :creators, -> { where(object_has_link_type: 'Creator') }

  # Validations
  validates :link_type, presence: { message: 'Please select link type.' }
  validates :object_has_link, presence: true

  # Delegations
  delegate :name, to: :link_type
end
