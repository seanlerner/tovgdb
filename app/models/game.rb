class Game < ActiveRecord::Base
  extend ModelHelper
  extend GameModelHelpers::GameSearch
  include Elasticsearch::Model
  include GameModelHelpers::Description, GameModelHelpers::NumberOfPlayers

  # Constants
  MANY_TAGS = [Genre, Style, Community, Award, Theme].freeze
  TAGS = [MANY_TAGS, Platform, Engine, Series, Mode].flatten.freeze
  LISTED_UNDER_TAGS = [Theme, Style, Community, Award].freeze

  # Helper Methods
  presence_with_question_mark [:number_of_players_for_display, :pricing_models_for_display, :developers, :publishers, :platforms, :game_images, :creators,
                               :games_distribution_channels, :series, :engine, :genres, :links, :released_on, :modes, :multiplayer_modes]

  # Associations
  has_many :links, as: :object_has_link
  has_many :link_types, through: :links
  has_many :games_distribution_channels, dependent: :destroy
  has_many :distribution_channels, through: :games_distribution_channels
  has_many :games_creators, dependent: :destroy
  has_many :creators, through: :games_creators
  has_many :published_creators, -> { published }, source: :creator, through: :games_creators
  has_many :creator_developers, -> { developers }, class_name: 'GamesCreator'
  has_many :developers, source: :creator, through: :creator_developers
  has_many :published_developers, -> { published }, source: :creator, through: :creator_developers
  has_many :creator_publishers, -> { publishers }, class_name: 'GamesCreator'
  has_many :publishers, source: :creator, through: :creator_publishers
  has_many :published_publishers, -> { published }, source: :creator, through: :creator_publishers
  has_many :game_images, foreign_key: 'game_id', dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :games_platforms, dependent: :destroy
  has_many :platforms, through: :games_platforms

  MANY_TAGS.each do |tag|
    has_many tag.game_join_model_as_symbol, dependent: :destroy
    has_many tag.symbol_pluralized, through: tag.game_join_model_as_symbol
  end

  belongs_to :engine, counter_cache: true
  belongs_to :series, counter_cache: true

  accepts_nested_attributes_for :game_images, allow_destroy: true
  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :games_distribution_channels, allow_destroy: true
  accepts_nested_attributes_for :games_creators, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true
  accepts_nested_attributes_for :games_platforms, allow_destroy: true

  # Scopes
  scope :published, -> { where(published: true) }
  scope :single_player, -> { where('minimum_number_of_players = 1') }
  scope :multiplayer, -> { where('maximum_number_of_players >= 2 OR competitive_play = 1 OR coop_play = 1') }
  scope :local_play, -> { where(local_play: true) }
  scope :online_play, -> { where(online_play: true) }
  scope :competitive_play, -> { where(competitive_play: true) }
  scope :coop_play, -> { where(coop_play: true) }

  # Validations
  validates :name, presence: { message: 'Please enter the name of this game.' }
  validates :name, uniqueness: { message: 'There is already a game with this name.' }
  validates :local_play, presence: { unless: :online_play, message: 'Please select Local Play, Online Play or both.' }
  validates :online_play, presence: { unless: :local_play, message: 'Please select Local Play, Online Play or both.' }
  validate :competitive_or_coop_play_for_multiplayer

  def competitive_or_coop_play_for_multiplayer
    if maximum_number_of_players? && (maximum_number_of_players > 1) && (competitive_play == false) && (coop_play == false)
      error_message = 'As the maximum number of players is more than 1, please select Competitive Play, Co-op Play or both.'
      errors.add(:competitive_play, error_message)
      errors.add(:coop_play, error_message)
    end
  end

  # Instance Methods
  def games_tags_count(tag)
    send Game.games_tags_count_column(tag)
  end

  def released_on
    if initial_release_on?
      initial_release_on
    else
      (games_distribution_channels.map(&:released_on) + games_platforms.map(&:released_on)).reject(&:nil?).sort.first
    end
  end

  def single_player
    minimum_number_of_players == 1
  end

  def multiplayer
    maximum_number_of_players.to_i >= 2 || coop_play || competitive_play
  end

  def modes
    Mode.all.select { |mode| mode if send mode.id }
  end

  def multiplayer_modes
    Mode.multiplayer_modes.select { |mode| mode if send mode.id }
  end

  def pricing_models_for_display
    pricing_models = []
    %w(free freemium free_trial donation ads pay not_available).each do |pricing_model|
      pricing_models << pricing_model.titleize if send(pricing_model)
    end
    pricing_models
  end

  def most_common_image_aspect_ratio
    game_images(&:itself).map(&:image).map(&:aspect_ratio).group_by(&:itself).values.max_by(&:size).first
  end

  # Class Methods
  class << self
    def games_tags_count_column(tag)
      "games_#{tag.lowercase.pluralize}_count"
    end
  end

  # Elastic Search Settings
  settings index: {
    number_of_shards: 1,
    number_of_replicas: 0,
    analysis: {
      filter: {
        partial_words_filter: {
          type: 'edge_ngram',
          min_gram: 1,
          max_gram: 30
        }
      },
      analyzer: {
        partial_words: {
          type: 'custom',
          tokenizer: 'standard',
          filter: %w(lowercase partial_words_filter)
        }
      }
    }
  } do
    mappings do
      indexes :name, type: 'string', analyzer: 'partial_words', search_analyzer: 'standard'
      indexes :long_description, type: 'string', analyzer: 'partial_words', search_analyzer: 'standard'
    end
  end
end
