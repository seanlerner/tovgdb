describe MenuItem do
  admin_test_setup :menu_item

  admin_view_index_test
  admin_view_single_test
  admin_update_existing_test
  admin_delete_test

  it 'creates new' do
    visit new_admin_menu_item_path
    fill_in 'Name', with: 'New Menu Item'
    select 'Main Nav'
    fill_in 'Uri', with: '/new_page'
    click_button 'Create Menu Item'
    expect(page).to have_content 'Menu item was successfully created.'
  end
end
