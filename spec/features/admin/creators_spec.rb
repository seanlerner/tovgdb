describe Creator do
  standard_admin_tests :creator

  it 'creates new with logo' do
    visit '/admin/creators/new'
    fill_in 'Name', with: 'New Creator'
    attach_file 'creator_logo', 'spec/support/test.png'
    click_button 'Create Creator'
    expect(page).to have_content 'Creator was successfully created.'
    expect(page.find('img')['src']).to have_content 'test.png'
  end

  it 'deletes associated logo' do
    creator_with_logo = create(:creator, :logo)
    logo_file_name = creator_with_logo.logo_file_name
    visit "/admin/creators/#{creator_with_logo.id}/edit"
    expect(page.body).to have_css("img[src*='#{logo_file_name}']")
    check 'Remove Logo?'
    click_button 'Update Creator'
    expect(page).to have_content 'Creator was successfully updated.'
    expect(page.html).not_to have_css("img[src*='#{logo_file_name}']")
  end

  it 'shows game association' do
    games_creator = create(:games_creator)
    visit "/admin/creators/#{games_creator.creator.id}"
    expect(page).to have_content games_creator.game.name
  end
end
