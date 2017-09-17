class GameImage < ApplicationRecord
  # Associations
  belongs_to :game, foreign_key: 'game_id'
  has_attached_file :image, styles: { small: '150x9999>', medium: '267x9999>', large: '800x9999>' }

  # Scopes
  default_scope { order(order: :asc) }

  # Validations
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 5.megabytes
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates :order, numericality: { only_integer: true, allow_nil: true }
end
