describe ApplicationHelper do
  before :each do
    login_as create(:admin_user)
  end

  it 'formats website link with http properly' do
    test_link = create(:game_link, uri: 'http://www.test.com')
    visit "/admin/games/#{test_link.object_has_link_id}"
    expect(page.find('td.col-uri a')['href']).to have_content test_link.uri
  end

  it 'formats website link with https properly' do
    test_link = create(:game_link, uri: 'https://www.test.com')
    visit "/admin/games/#{test_link.object_has_link_id}"
    expect(page.find('td.col-uri a')['href']).to have_content test_link.uri
  end

  it 'formats website link without http or https properly' do
    test_link = create(:game_link, uri: 'www.test.com')
    visit "/admin/games/#{test_link.object_has_link_id}"
    expect(page.find('td.col-uri a')['href']).to have_content "http://#{test_link.uri}"
  end

  it 'formats email link with mailto properly' do
    test_link = create(:game_link, uri: 'mailto:test@test.com')
    visit "/admin/games/#{test_link.object_has_link_id}"
    expect(page.find('td.col-uri a')['href']).to have_content test_link.uri
  end

  it 'formats email link without mailto properly' do
    test_link = create(:game_link, uri: 'test@test.com')
    visit "/admin/games/#{test_link.object_has_link_id}"
    expect(page.body).to have_link(test_link.uri)
    expect(page.find('td.col-uri a')['href']).to have_content "mailto:#{test_link.uri}"
  end

  it 'links to by object name' do
    games_platform = create(:games_platform)
    visit "/games/#{games_platform.game.id}"
    expect(page).to have_link(games_platform.platform.name, href: platform_path(games_platform.platform.id))
  end
end
