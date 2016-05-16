require_relative 'tovgdb_spec_helper.rb'

FactoryGirl.define do
  factory :admin_user do
    email 'test@example.com'
    password 'password'
  end

  sequence :name do |sequence_number|
    "Name #{sequence_number}"
  end

  factory Game do
    name
    short_description ''
    long_description ''
    local_play true
    online_play true
    trait :no_game_image do
      # nothing special.. just no image attached
    end
    trait :game_image do
      after(:build) do |game, _eval|
        game.game_images << FactoryGirl.build(:game_image, game: game)
      end
    end
    trait :single_player_only do
      minimum_number_of_players 1
      maximum_number_of_players 1
      online_play false
      coop_play false
      competitive_play false
    end
    trait :multiplayer_only do
      minimum_number_of_players 2
      maximum_number_of_players 10
      online_play true
      coop_play true
      competitive_play true
    end
    trait :multiplayer_only_loosely_defined do
      online_play true
    end
    trait :single_player_and_multiplayer_loosely_defined do
      minimum_number_of_players 1
      online_play true
    end
  end

  factory GameImage do
    game :game
    caption ''
    image Rack::Test::UploadedFile.new('spec/support/test.png', 'image/jpg')
    trait :size_1920x1080 do
      image Rack::Test::UploadedFile.new('spec/support/test-size-1920x1080.png', 'image/jpg')
    end
    trait :size_1920x1440 do
      image Rack::Test::UploadedFile.new('spec/support/test-size-1920x1440.png', 'image/jpg')
    end
  end

  factory Creator do
    name
    description ''
    trait :logo do
      logo Rack::Test::UploadedFile.new('spec/support/test.png', 'image/jpg')
    end
  end

  factory GamesCreator do
    game
    creator
    developer true
    publisher true
  end

  [Engine, Series, GAME_TAGS].flatten.each do |tag_class|
    factory tag_class do
      name
      description ''
    end
    factory "games_#{tag_class.name.downcase}".to_sym do
      game
      tag_class.name.downcase
    end
  end

  factory Platform do
    name
    description ''
  end

  factory GamesPlatform do
    game
    platform
    released_on Time.current
  end

  factory LinkType do
    name
    game_link true
    creator_link true
    category 'website'
  end

  factory Link do
    link_type
    game
    uri 'http://test.com'
  end

  factory :game_link, class: 'Link' do
    link_type
    description_override ''
    uri 'http://test.com'
    association :object_has_link, factory: :game
  end

  factory :creator_link, class: 'Link' do
    link_type
    description_override ''
    uri 'http://test.com'
    association :object_has_link, factory: :creator
  end

  factory DistributionChannel do
    name
    description ''
    category 'where to get'
  end

  factory GamesDistributionChannel do
    game
    distribution_channel
    uri 'http://test.com'
    released_on Time.current
  end

  factory Video do
    game
    title 'New Video Game Trailer'
    platform 'YouTube'
    video_type 'Trailer'
    code 'xxx-zzz'
    trait :vimeo do
      platform 'Vimeo'
    end
  end

  factory Page do
    title 'New Page Title'
    slug '/slug'
    content ''
  end

  factory MenuItem do
    name
    menu 'Main Nav'
    uri '/'
    order '10'
  end
end
