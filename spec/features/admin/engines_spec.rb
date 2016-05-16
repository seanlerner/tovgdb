describe Engine do
  standard_admin_tests :engine

  it 'saves game association' do
    game = create(:game)
    visit "/admin/engines/#{engine.id}/edit"
    check game.name
    click_button 'Update Engine'
    expect(page).to have_content game.name
    visit '/admin/engines'
    expect(page.first('td.col-of_games').text).to eq '1'
  end
end
