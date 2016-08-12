describe Game do
  # Constants
  it 'knows tags' do
    GAME_TAGS.each do |tag|
      expect(Game::MANY_TAGS).to include(tag)
    end
  end

  # Validations
  it 'has a valid factory' do
    expect(build(:game)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:game, name: nil)).not_to be_valid
  end

  it 'is invalid if duplicate name' do
    game = create(:game)
    expect(build(:game, name: game.name)).not_to be_valid
  end

  # Class Methods
  it 'returns valid counts column' do
    expect(described_class.games_tags_count_column(Genre)).to eq('games_genres_count')
  end

  # Instance Methods
  it 'returns count for a tag' do
    game = create(:game)
    genre = create(:genre)
    create(:games_genre, game: game, genre: genre)
    expect(game.games_tags_count(Genre)).to eq 1
  end

  it 'knows when it was released if intial release date set' do
    test_date = Time.zone.local '2001-10-12'
    game = create(:game, initial_release_on: test_date)
    expect(game.released_on).to eq test_date
  end

  it 'knows when it was released if determining from distribution channels and platforms' do
    game = create(:game)
    early_test_date = Time.zone.local '2001-10-12'
    late_test_date = early_test_date + 1.day
    create(:games_distribution_channel, game: game, released_on: early_test_date)
    create(:games_platform, game: game, released_on: late_test_date)
    expect(game.released_on).to eq early_test_date
  end

  it 'knows if it is multiple player' do
    game = create(:game, online_play: true)
    expect(game.multiplayer_modes?).to eq true
  end

  it 'knows if it is single player only' do
    game = create(:game, :single_player_only)
    expect(game.single_player_only?).to eq true
  end

  it 'knows if it is multiplayer only' do
    game = create(:game, minimum_number_of_players: 2)
    expect(game.multiplayer_only?).to eq true
  end

  it 'knows if number of players are defined' do
    game = create(:game, maximum_number_of_players: 2)
    expect(game.number_of_players_defined?).to eq true
  end

  it 'can show number of players as numerals with a dash in between' do
    minimum_number_of_players = 1
    maximum_number_of_players = 10
    game = create(:game, minimum_number_of_players: minimum_number_of_players, maximum_number_of_players: maximum_number_of_players)
    expect(game.number_of_players_as_numerals).to eq "#{minimum_number_of_players}-#{maximum_number_of_players} players"
  end

  it 'can show number of players as a single number when there is there same number of players' do
    minimum_number_of_players = 4
    maximum_number_of_players = 4
    game = create(:game, minimum_number_of_players: minimum_number_of_players, maximum_number_of_players: maximum_number_of_players)
    expect(game.number_of_players_as_numerals).to eq "#{minimum_number_of_players} players"
  end

  it 'can show number of players for display' do
    single_player_game = create(:game, :single_player_only)
    expect(single_player_game.number_of_players_for_display).to eq 'Single-player'
    multiplayer_only_game = create(:game, :multiplayer_only)
    expect(multiplayer_only_game.number_of_players_for_display).to eq '2-10 players'
    multiplayer_only_loosely_defined_game = create(:game, :multiplayer_only_loosely_defined)
    expect(multiplayer_only_loosely_defined_game.number_of_players_for_display).to eq 'Multiplayer'
    single_player_and_multiplayer_loosely_defined = create(:game, :single_player_and_multiplayer_loosely_defined)
    expect(single_player_and_multiplayer_loosely_defined.number_of_players_for_display).to eq 'Single-player, Multiplayer'
  end

  it 'can show pricing models for display' do
    game = create(:game, free: true, freemium: true, free_trial: true, donation: true, ads: true, pay: true, not_available: true)
    expect(game.pricing_models_for_display).to eq ['Free', 'Freemium', 'Free Trial', 'Donation', 'Ads', 'Pay', 'Not Available']
  end

  it 'knows most common aspect ratio for images' do
    game = create(:game)
    common_image = create(:game_image, :size_1920x1080, game: game)
    create(:game_image, :size_1920x1080, game: game)
    uncommon_image = create(:game_image, :size_1920x1440, game: game)
    expect(game.most_common_image_aspect_ratio).to eq common_image.image.aspect_ratio
    expect(game.most_common_image_aspect_ratio).not_to eq uncommon_image.image.aspect_ratio
  end

  it 'can be created with a platform association' do
    game = build(:game)
    platform = create(:platform)
    game_platform = game.games_platforms.build(platform: platform)
    game.save
    expect(game.persisted?).to eq true
    expect(game_platform.persisted?).to eq true
  end

  it 'can be created with a creator association' do
    game = build(:game)
    creator = create(:creator)
    game_creator = game.games_creators.build(creator: creator, developer: true)
    game.save
    expect(game.persisted?).to eq true
    expect(game_creator.persisted?).to eq true
  end

  it 'can be created with a distribution channel association' do
    game = build(:game)
    distribution_channel = create(:distribution_channel)
    game_distribution_channel = game.games_distribution_channels.build(distribution_channel: distribution_channel, uri: 'http://www.test.com')
    game.save
    expect(game.persisted?).to eq true
    expect(game_distribution_channel.persisted?).to eq true
  end

  it 'can be created with a link association' do
    game = build(:game)
    link_type = create(:link_type)
    game_link = game.links.build(link_type: link_type, uri: 'http://www.test.com', description_override: '')
    game.save
    expect(game.persisted?).to eq true
    expect(game_link.persisted?).to eq true
  end
end
