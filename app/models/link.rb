class Link < ActiveRecord::Base
  # Associations
  belongs_to :link_type
  belongs_to :object_has_link, polymorphic: true

  # Scopes
  scope :games, -> { where(object_has_link_type: 'Game') }
  scope :creators, -> { where(object_has_link_type: 'Creator') }

  # Validations
  validates :link_type, presence: { message: 'Please select link type.' }
  validate :link_belongs_to_game_or_creator

  def link_belongs_to_game_or_creator
    errors.add(:object_has_link) << 'Link must be associated with object.' unless object_has_link_type
  end

  # Delegations
  delegate :name, to: :link_type
end
