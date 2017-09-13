class Video < ApplicationRecord
  # Constants
  PLATFORMS = %w[YouTube Vimeo].freeze
  VIDEO_TYPES = %w[Trailer Gameplay Demo Other].freeze

  # Associations
  belongs_to :game

  # Validations
  validates :title, presence: { message: 'Please enter a title for this Video.' }
  validates :platform, presence: { message: "Please select this Video's platform." }
  validates :platform, inclusion: { in: PLATFORMS, message: 'Please select a platform for this Video' }
  validates :video_type, presence: { message: "Please select this Video's type." }
  validates :video_type, inclusion: { in: VIDEO_TYPES, message: 'Please select a platform for this Video' }
  validates :code, presence: { message: 'Please enter a code (video id) for this Video.' }
end
