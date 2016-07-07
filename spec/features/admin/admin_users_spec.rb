describe AdminUser do
  let!(:admin_user) { create :admin_user }
  before(:each) { login_as(admin_user) }

  it 'views index' do
    visit '/admin/admin_users'
    expect(page).to have_content 'Admin Users'
    expect(page).to have_content admin_user.email
  end

  it 'views single' do
    visit "/admin/admin_users/#{admin_user.id}"
    expect(page).to have_content admin_user.email
  end

  it 'creates new' do
    visit '/admin/admin_users/new'
    fill_in 'admin_user_email', with: 'new@example.com'
    fill_in 'admin_user_password', with: 'password'
    fill_in 'admin_user_password_confirmation', with: 'password'
    click_button 'Create Admin user'
    expect(page).to have_content 'Admin user was successfully created.'
  end

  it 'updates existing' do
    admin_user_to_be_updated = create(:admin_user, email: 'intial_admin_user_email@example.com')
    updated_email = 'intial_admin_user_email@example.com'
    visit "/admin/admin_users/#{admin_user_to_be_updated.id}/edit"
    fill_in 'admin_user_email', with: updated_email
    fill_in 'admin_user_password', with: 'password'
    fill_in 'admin_user_password_confirmation', with: 'password'
    click_button 'Update Admin user'
    expect(page).to have_content 'Admin user was successfully updated.'
    expect(page).to have_content updated_email
  end

  it 'updates existing without a password' do
    admin_user_to_be_updated = create(:admin_user, email: 'intial_admin_user_email@example.com')
    updated_email = 'intial_admin_user_email@example.com'
    visit "/admin/admin_users/#{admin_user_to_be_updated.id}/edit"
    fill_in 'admin_user_email', with: updated_email
    fill_in 'admin_user_password', with: ''
    fill_in 'admin_user_password_confirmation', with: ''
    click_button 'Update Admin user'
    expect(page).to have_content 'Admin user was successfully updated.'
    expect(page).to have_content updated_email
  end

  it 'does not update with non-matching passwords' do
    admin_user_to_be_updated = create(:admin_user, email: 'admin@example.com')
    visit "/admin/admin_users/#{admin_user_to_be_updated.id}/edit"
    fill_in 'admin_user_password', with: 'password'
    fill_in 'admin_user_password_confirmation', with: 'different_password'
    click_button 'Update Admin user'
    expect(page).to have_content 'Could not save AdminUser. Please correct and try again'
  end

  it 'deletes' do
    admin_user_to_be_deleted = create(:admin_user, email: 'admin_user_to_be_deleted@example.com')
    visit "/admin/admin_users/#{admin_user_to_be_deleted.id}"
    click_link 'Delete Admin User'
    expect(page).to have_content 'Admin user was successfully destroyed.'
    expect(page).to have_no_content admin_user_to_be_deleted.email
  end
end
