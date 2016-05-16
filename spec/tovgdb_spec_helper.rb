GAME_TAGS = [Genre, Award, Style, Community, Subgenre, Theme].freeze

def let_and_create(object)
  let(object) { create object }
end

def let_and_create!(object)
  let!(object) { create object }
end

def login_admin_user
  let_and_create! :admin_user
  before(:each) { login_as admin_user }
end

def admin_test_setup(symbol)
  login_admin_user
  let_and_create! symbol
  let!(:symbols) { symbol.to_s.pluralize }
  let(:class_name) { symbol.to_s.titleize }
  let!(:object_instance) { create symbol }
end

def standard_admin_tests(symbol)
  admin_test_setup symbol
  admin_view_index_test
  admin_view_single_test
  admin_create_new_test
  admin_update_existing_test
  admin_delete_test
end

def admin_view_index_test
  it 'views index' do
    visit "/admin/#{symbols}"
    expect(page).to have_content class_name
    expect(page).to have_content object_instance.name
  end
end

def admin_view_single_test
  it 'views single' do
    visit "/admin/#{symbols}/#{object_instance.id}"
    expect(page).to have_content object_instance.name
  end
end

def admin_create_new_test
  it 'creates new' do
    visit "/admin/#{symbols}/new"
    fill_in 'Name', with: "New #{class_name}"
    click_button "Create #{class_name}"
    expect(page).to have_content "#{class_name} was successfully created."
  end
end

def admin_update_existing_test
  it 'updates existing' do
    different_name = "Different #{class_name}"
    visit "/admin/#{symbols}/#{object_instance.id}/edit"
    fill_in 'Name', with: different_name
    click_button "Update #{class_name}"
    expect(page).to have_content "#{class_name.humanize} was successfully updated."
    expect(page).to have_content different_name
  end
end

def admin_delete_test
  it 'deletes' do
    visit "/admin/#{symbols}/#{object_instance.id}"
    click_link "Delete #{class_name}"
    expect(page).to have_content "#{class_name.humanize} was successfully destroyed."
    expect(page).to have_no_content object_instance.name
  end
end
