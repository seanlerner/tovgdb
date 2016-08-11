class GamesCreator < ActiveRecord::Base
  # Associations
  belongs_to :game, counter_cache: true
  belongs_to :creator, counter_cache: true

  # Delegations
  delegate :name, :logo, to: :creator

  # Scopes
  scope :developers, -> { where(developer: true) }
  scope :publishers, -> { where(publisher: true) }

  # Validations
  validates :game, presence: true
  validates :creator, presence: { message: 'Please select a creator.' }
  validates :developer, presence: { unless: :publisher, message: 'Please select Developer, Publisher or both.' }
  validates :publisher, presence: { unless: :developer, message: 'Please select Developer, Publisher or both.' }

  # Instance Methods
  def roles
    creator_roles = []
    creator_roles << 'Developer' if developer
    creator_roles << 'Publisher' if publisher
    creator_roles
  end
end
