describe Creator do
  let_and_create! :creator

  it 'views index' do
    visit creators_path
    expect(page).to have_content 'Creators'
    expect(page).to have_content creator.name
  end

  it 'views single' do
    visit creator_path(creator)
    expect(page).to have_content creator.name
  end

  it 'displays game on show if game is published' do
    published_game = create(:game, published: true)
    games_creator = create(:games_creator, game: published_game)
    visit creator_path(games_creator.creator)
    expect(page).to have_content published_game.name
  end

  it 'does not display game on show if game is unpublished' do
    unpublished_game = create(:game, published: false)
    games_creator = create(:games_creator, game: unpublished_game)
    visit creator_path(games_creator.creator)
    expect(page).not_to have_content unpublished_game.name
  end
end
