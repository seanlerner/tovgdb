describe DistributionChannel do
  admin_test_setup :distribution_channel
  let_and_create! :game
  before(:each) { create(:games_distribution_channel, distribution_channel: distribution_channel, game: game) }

  admin_view_index_test
  admin_view_single_test
  admin_update_existing_test
  admin_delete_test

  it 'views single' do
    visit "/admin/distribution_channels/#{distribution_channel.id}"
    expect(page).to have_content distribution_channel.name
    expect(page).to have_content distribution_channel.name
  end

  it 'is present in games index' do
    visit admin_detailed_games_list_path
    expect(page).to have_content distribution_channel.name
  end

  it 'creates new' do
    visit '/admin/distribution_channels/new'
    fill_in 'Name', with: 'New Distribution Channel'
    select 'where to get'
    click_button 'Create Distribution Channel'
    expect(page).to have_content 'Distribution channel was successfully created.'
  end
end
