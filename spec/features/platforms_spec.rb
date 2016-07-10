describe Platform do
  it 'views index' do
    platform = create :platform
    visit platforms_path
    expect(page).to have_content 'Platforms'
    expect(page).to have_content platform.name
  end

  it 'views single' do
    games_platform = create :games_platform
    visit platform_path(games_platform.platform)
    expect(page).to have_content games_platform.platform.name
    expect(page).to have_content games_platform.game.name
  end
end
