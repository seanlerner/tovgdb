describe Page do
  login_admin_user
  let!(:test_page) { create :page }

  it 'views index' do
    visit admin_pages_path
    expect(page).to have_content 'Pages'
    expect(page).to have_content test_page.title
  end

  it 'views single' do
    visit admin_page_path test_page
    expect(page).to have_content test_page.title
  end

  it 'creates new' do
    visit new_admin_page_path
    fill_in 'Title', with: 'New Page'
    fill_in 'Slug', with: 'slug'
    click_button 'Create Page'
    expect(page).to have_content 'Page was successfully created.'
  end

  it 'updates existing' do
    different_title = 'Different Page Title'
    visit "/admin/pages/#{test_page.id}/edit"
    fill_in 'Title', with: different_title
    click_button 'Update Page'
    expect(page).to have_content 'Page was successfully updated.'
    expect(page).to have_content different_title
  end

  it 'deletes' do
    visit "/admin/pages/#{test_page.id}"
    click_link 'Delete Page'
    expect(page).to have_content 'Page was successfully destroyed.'
    expect(page).to have_no_content test_page.title
  end
end
