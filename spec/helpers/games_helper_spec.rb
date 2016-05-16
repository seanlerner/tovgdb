describe GamesHelper do
  before :each do
    login_as create(:admin_user)
  end

  it 'can join developers and publishers with ampersand' do
    game = create(:game)
    developer_a = create(:games_creator, game: game)
    developer_b = create(:games_creator, game: game)
    visit game_path(game)
    expect(page).to have_content "#{developer_a.creator.name} & #{developer_b.creator.name}"
  end

  it 'can display only year specifity for a date' do
    test_date = Time.zone.local(2014, 1, 1)
    game = create(:game, initial_release_on: test_date)
    visit game_path(game)
    expect(page).to have_content test_date.year
  end

  it 'can display year and month specifity for a date' do
    test_date = Time.zone.local(2014, 2, 1)
    game = create(:game, initial_release_on: test_date)
    visit game_path(game)
    expect(page).to have_content "#{Date::MONTHNAMES[test_date.month]}, #{test_date.year}"
  end

  it 'can display year and month and day specifity for a date' do
    test_date = Time.zone.local(2014, 2, 2)
    game = create(:game, initial_release_on: test_date)
    visit game_path(game)
    expect(page).to have_content "#{Date::MONTHNAMES[test_date.month]} #{test_date.day}, #{test_date.year}"
  end
end
