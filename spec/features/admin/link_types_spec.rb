describe LinkType do
  admin_test_setup :link_type

  admin_view_index_test
  admin_update_existing_test
  admin_delete_test

  it 'views single' do
    game_link = create(:game_link, link_type: link_type)
    creator_link = create(:creator_link, link_type: link_type)
    visit "/admin/link_types/#{link_type.id}"
    expect(page).to have_content link_type.name
    expect(page).to have_content game_link.uri
    expect(page).to have_content creator_link.uri
  end

  it 'creates new' do
    visit '/admin/link_types/new'
    fill_in 'Name', with: 'New Link Type'
    check 'link_type_game_link'
    check 'link_type_creator_link'
    select 'website'
    click_button 'Create Link Type'
    expect(page).to have_content 'Link type was successfully created.'
  end
end
