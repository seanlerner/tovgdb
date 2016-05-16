describe Game do
  let_and_create! :game

  it 'views index' do
    visit games_path
    expect(page).to have_content 'Games'
    expect(page).to have_content game.name
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
end
