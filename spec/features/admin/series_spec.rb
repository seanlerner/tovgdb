describe Series do
  standard_admin_tests :series

  it 'saves game association' do
    game = create(:game)
    visit "/admin/series/#{series.id}/edit"
    check game.name
    click_button 'Update Series'
    expect(page).to have_content game.name
    visit '/admin/series'
    expect(page.first('td.col-of_games').text).to eq '1'
  end
end
