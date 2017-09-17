class Creator < ApplicationRecord
  # Allow admin to delete logo
  attr_writer :remove_logo
  def remove_logo
    @remove_logo || false
  end
  before_validation { logo.clear if remove_logo == '1' }

  # Associations
  has_many :games_creators, dependent: :destroy
  has_many :games, through: :games_creators
  has_many :published_games, -> { published }, source: :game, through: :games_creators
  has_many :links, as: :object_has_link
  has_many :link_types, through: :links
  has_attached_file :logo, styles: { thumb: '200>x999', medium: '300x300>', large: '800x9999>' }

  accepts_nested_attributes_for :links, allow_destroy: true

  # Validations
  validates :name, presence: { message: 'Please enter the name of this creator.' }
  validates :name, uniqueness: { message: 'There is already a creator with this name.' }
  validates_attachment_content_type :logo, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  # Scopes
  default_scope { order(name: :asc) }
  scope :published, -> { where(published: true) }

  # Instance Methods
  def roles
    creator_roles = []
    creator_roles << 'Developer' if games_creators.developers.present?
    creator_roles << 'Publisher' if games_creators.publishers.present?
    creator_roles
  end
end
