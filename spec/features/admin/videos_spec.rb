describe Video, js: true do
  admin_test_setup :video
  let_and_create :game

  it 'creates new' do
    visit edit_admin_game_path game
    click_link 'Add New Video'
    new_video_title = 'New Video'
    fill_in 'Title*', with: new_video_title
    select 'YouTube', from: 'game_videos_attributes_0_platform'
    select 'Trailer', from: 'game_videos_attributes_0_video_type'
    fill_in 'game_videos_attributes_0_code', with: 'youtube-code'
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).to have_content new_video_title
  end

  it 'updates existing' do
    different_video_title = 'Different Video'
    visit edit_admin_game_path video.game
    fill_in 'Title', with: different_video_title
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).to have_content different_video_title
  end

  it 'deletes' do
    visit edit_admin_game_path video.game
    check 'Delete'
    click_button 'Update Game'
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).not_to have_content video.title
  end

  it 'views vimeo' do
    vimeo_video = create(:video, :vimeo)
    visit admin_game_path vimeo_video.game
    expect(page.html).to include('vimeo.com')
  end
end
