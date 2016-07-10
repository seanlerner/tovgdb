describe 'the signin process' do
  let!(:admin_user) { create :admin_user }

  def sign_user_in
    visit '/admin/login'
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password
    click_button 'Login'
  end

  it 'signs me in' do
    sign_user_in
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'signs me out' do
    sign_user_in
    click_link 'Logout'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  it 'admin dashboard redirects to the login page for non-logged in visitor' do
    visit admin_dashboard_path
    expect(current_path).to eq new_admin_user_session_path
  end

  it 'does not allow clerk to view admin users' do
    login_as create(:admin_user, :clerk)
    visit admin_admin_users_path
    expect(current_path).to eq admin_dashboard_path
  end
end
