class Creator < ActiveRecord::Base
  # Allow admin to delete logo
  attr_writer :remove_logo
  def remove_logo
    @remove_logo || false
  end
  before_validation { logo.clear if remove_logo == '1' }

  # Associations
  has_many :games_creators, dependent: :destroy
  has_many :games, through: :games_creators
  has_attached_file :logo, styles: { thumb: '200>x999', medium: '300x300>' }
  has_many :links, as: :object_has_link
  has_many :link_types, through: :links

  accepts_nested_attributes_for :links, allow_destroy: true

  # Validations
  validates :name, presence: { message: 'Please enter the name of this creator.' }
  validates :name, uniqueness: { message: 'There is already a creator with this name.' }
  validates_attachment_content_type :logo, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  # Scopes
  default_scope { order(name: :asc) }

  # Instance Methods
  def roles
    creator_roles = []
    creator_roles << 'Developer' if games_creators.developers.present?
    creator_roles << 'Publisher' if games_creators.publishers.present?
    creator_roles
  end
end
