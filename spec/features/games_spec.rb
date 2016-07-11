describe Game do
  let_and_create! :game

  it 'views index' do
    visit games_path
    expect(page).to have_content 'Games'
    expect(page).to have_content game.name
  end

  it 'displays creator on index if creator is published' do
    published_creator = create(:creator, published: true)
    games_creator = create(:games_creator, creator: published_creator)
    visit games_path
    expect(page).to have_content games_creator.game.name
    expect(page).to have_content published_creator.name
  end

  it 'does not display creator on index if creator is unpublished' do
    unpublished_creator = create(:creator, published: false)
    games_creator = create(:games_creator, creator: unpublished_creator)
    visit games_path
    expect(page).to have_content games_creator.game.name
    expect(page).not_to have_content unpublished_creator.name
  end

  it 'views single' do
    visit game_path(game)
    expect(page).to have_content game.name
  end

  it 'views single with distribution channel with empty link' do
    distribution_channel = create(:distribution_channel)
    create(:games_distribution_channel, game: game, distribution_channel: distribution_channel, uri: '')
    visit game_path(game)
    expect(page).to have_content game.name
  end

  it 'displays creator on show if creator is published' do
    published_creator = create(:creator, published: true)
    games_creator = create(:games_creator, creator: published_creator)
    visit game_path(games_creator.game)
    expect(page).to have_content games_creator.game.name
    expect(page).to have_content published_creator.name
  end

  it 'does not display creator on show if creator is unpublished' do
    unpublished_creator = create(:creator, published: false)
    games_creator = create(:games_creator, creator: unpublished_creator)
    visit game_path(games_creator.game)
    expect(page).to have_content games_creator.game.name
    expect(page).not_to have_content unpublished_creator.name
  end
end
