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
end
