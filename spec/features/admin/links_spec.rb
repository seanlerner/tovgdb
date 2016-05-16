describe Link, js: true do
  admin_test_setup :link_type
  let_and_create :game
  let_and_create :creator

  it 'creates new for game' do
    game_uri = 'http://test.com'
    visit edit_admin_game_path game
    click_link 'Add New Link'
    select link_type.name, from: 'game_links_attributes_0_link_type_id'
    fill_in 'Uri', with: game_uri
    fill_in 'Description override', with: 'Special Description'
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).to have_content game_uri
  end

  it 'updates existing for game' do
    game_link = create(:game_link)
    different_link = 'http://test-different.com'
    visit edit_admin_game_path game_link.object_has_link
    fill_in 'Uri', with: different_link
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).to have_content different_link
  end

  it 'deletes for game' do
    game_link = create(:game_link)
    visit edit_admin_game_path game_link.object_has_link
    check 'Delete'
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).not_to have_content game_link.uri
  end

  it 'creates new for creator' do
    creator_uri = 'http://test.com'
    visit edit_admin_creator_path creator
    click_link 'Add New Link'
    select link_type.name, from: 'creator_links_attributes_0_link_type_id'
    fill_in 'Uri', with: creator_uri
    fill_in 'Description override', with: 'Special Description'
    click_button 'Update Creator'
    expect(page).to have_content 'Creator was successfully updated.'
    expect(page).to have_content creator_uri
  end

  it 'updates existing for creator' do
    creator_link = create(:creator_link)
    different_link = 'http://test-different.com'
    visit edit_admin_creator_path creator_link.object_has_link
    fill_in 'Uri', with: different_link
    click_button 'Update Creator'
    expect(page).to have_content 'Creator was successfully updated.'
    expect(page).to have_content different_link
  end

  it 'deletes for creator' do
    creator_link = create(:creator_link)
    visit edit_admin_creator_path creator_link.object_has_link
    check 'Delete'
    click_button 'Update Creator'
    expect(page).to have_content 'Creator was successfully updated.'
    expect(page).not_to have_content creator_link.uri
  end
end
