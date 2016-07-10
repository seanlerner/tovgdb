class Mode
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include GameTagHelper
  extend GameTagHelper

  # Class Instance Variables
  @all = []

  # Class Methods
  class << self
    attr_reader :all

    delegate :count, to: :all

    def find(id)
      Mode.all.detect { |mode| mode.id == id.to_sym }
    end

    def find_by_name(name)
      Mode.all.detect { |mode| mode.name == name }
    end

    def find_each
      all.each
    end

    def multiplayer_modes
      all.select { |mode| mode.mode_type == :multiplayer_mode }
    end

    def non_zero_count
      all.select { |mode| mode.games.count >= 1 }
    end
  end

  attr_reader :id, :name, :description, :mode_type

  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @description = args[:description]
    @mode_type = args[:mode_type]
  end

  # Delegations
  delegate :count, to: :games

  # Instance Methods
  def games
    Game.send(id)
  end

  # Create modes
  Mode.all << new(id: :single_player,    name: 'Single Player',    description: nil, mode_type: :number_of_players)
  Mode.all << new(id: :multiplayer,      name: 'Multiplayer',      description: nil, mode_type: :number_of_players)
  Mode.all << new(id: :local_play,       name: 'Local Play',       description: nil, mode_type: :multiplayer_mode)
  Mode.all << new(id: :online_play,      name: 'Online Play',      description: nil, mode_type: :multiplayer_mode)
  Mode.all << new(id: :competitive_play, name: 'Competitive Play', description: nil, mode_type: :multiplayer_mode)
  Mode.all << new(id: :coop_play,        name: 'Co-op Play',       description: nil, mode_type: :multiplayer_mode)
end
