require 'rails_helper'

describe Game do
  admin_test_setup :game

  admin_view_index_test
  admin_view_single_test
  admin_update_existing_test
  admin_delete_test

  it 'creates new' do
    visit '/admin/games/new'
    fill_in 'Name', with: 'New Game'
    check 'Local play'
    click_button 'Create Game'
    expect(page).to have_content 'Game was successfully created.'
  end

  it 'creates new with image', js: true do
    visit '/admin/games/new'
    fill_in 'Name', with: 'New Game'
    check 'Local play'
    click_link 'Add New Image'
    attach_file 'game_game_images_attributes_0_image', 'spec/support/test.png'
    click_button 'Create Game'
    expect(page).to have_content 'Game was successfully created.'
    expect(page.find('img')['src']).to have_content 'test.png'
  end

  it 'deletes associated game image' do
    game_with_image = create(:game, :game_image)
    image_name = game_with_image.game_images.first.image_file_name
    visit "/admin/games/#{game_with_image.id}/edit"
    expect(page.body).to have_css("img[src*='#{image_name}']")
    check 'Delete'
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page.html).not_to have_css("img[src*='#{image_name}']")
  end

  GAME_TAGS.each do |tag_class|
    it "saves #{tag_class} association" do
      tag = create(tag_class.name.downcase.to_sym)
      visit "/admin/games/#{game.id}/edit"
      check tag.name
      click_button 'Update Game'
      expect(page).to have_content tag.name
      visit '/admin/games'
      expect(page.first("td.col-of_#{tag_class.name.downcase.pluralize}").text).to eq '1'
    end
  end

  [Series, Engine].each do |object_association|
    it "saves #{object_association} association" do
      tag = create(object_association.name.downcase.to_sym)
      visit "/admin/games/#{game.id}/edit"
      select tag.name, from: "game_#{object_association.name.downcase}_id"
      click_button 'Update Game'
      expect(page).to have_content tag.name
      visit '/admin/games'
      expect(page.first("td.col-#{object_association.name.downcase}").text).to eq tag.name
    end
  end

  it 'saves valid creator association', js: true do
    creator = create(:creator)
    visit "/admin/games/#{game.id}/edit"
    click_link 'Add New Creator'
    select creator.name
    check 'Developer'
    check 'Publisher'
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).to have_content creator.name
  end

  it 'does not save invalid creator association', js: true do
    create(:creator)
    visit "/admin/games/#{game.id}/edit"
    click_link 'Add New Creator'
    click_button 'Update Game'
    expect(page).to have_content 'Please select a creator.'
    expect(page).to have_content 'Please select Developer, Publisher or both.'
  end

  it 'deletes creator association', js: true do
    creator = create(:creator)
    create(:games_creator, game: game, creator: creator)
    visit "/admin/games/#{game.id}/edit"
    check 'Delete'
    click_button 'Update Game'
    expect(page).not_to have_content creator.name
  end

  it 'saves valid platform association', js: true do
    platform = create(:platform)
    visit "/admin/games/#{game.id}/edit"
    click_link 'Add New Platform'
    select platform.name
    select '2016', from: 'game_games_platforms_attributes_0_released_on_1i'
    select 'January', from: 'game_games_platforms_attributes_0_released_on_2i'
    select '1', from: 'game_games_platforms_attributes_0_released_on_3i'
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).to have_content platform.name
  end

  it 'does not saves invalid platform association', js: true do
    create(:platform)
    visit "/admin/games/#{game.id}/edit"
    click_link 'Add New Platform'
    click_button 'Update Game'
    expect(page).to have_content 'Please select a platform.'
  end

  it 'deletes platform association', js: true do
    platform = create(:platform)
    create(:games_platform, game: game, platform: platform)
    visit "/admin/games/#{game.id}/edit"
    check 'Delete'
    click_button 'Update Game'
    expect(page).not_to have_content platform.name
  end

  it 'saves valid distribution channel association', js: true do
    test_uri = 'http://test.com'
    distribution_channel = create(:distribution_channel)
    visit "/admin/games/#{game.id}/edit"
    click_link 'Add New Distribution Channel'
    select distribution_channel.name
    fill_in 'Uri', with: test_uri
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).to have_content distribution_channel.name
    expect(page).to have_content test_uri
  end

  it 'does not saves invalid distribution channel association', js: true do
    create(:distribution_channel)
    visit "/admin/games/#{game.id}/edit"
    click_link 'Add New Distribution Channel'
    click_button 'Update Game'
    expect(page).to have_content 'Please select a distribution channel.'
  end

  it 'deletes distribution channel association', js: true do
    distribution_channel = create(:distribution_channel)
    create(:games_distribution_channel, game: game, distribution_channel: distribution_channel)
    visit "/admin/games/#{game.id}/edit"
    check 'Delete'
    click_button 'Update Game'
    expect(page).not_to have_content distribution_channel.name
  end

  it 'does not save multiplayer game without coop or competitive being selected', js: true do
    visit '/admin/games/new'
    fill_in 'Name', with: 'New Game'
    check 'Local play'
    fill_in 'Maximum number of players', with: '2'
    click_button 'Create Game'
    expect(page).to have_content 'As the maximum number of players is more than 1, please select Competitive Play, Co-op Play or both.'
  end

  it 'shows published field for super_admin' do
    visit '/admin/games/new'
    expect(page.body).to have_css('input#game_published')
  end

  it 'does not show published field for clerk' do
    login_as create(:admin_user, :clerk)
    visit '/admin/games/new'
    expect(page.body).not_to have_css('input#game_published')
  end
end
