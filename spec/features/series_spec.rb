describe Series do
  let_and_create! :series

  it 'views index' do
    visit series_index_path
    expect(page).to have_content 'Series'
    expect(page).to have_content series.name
  end

  it 'views single' do
    game = create(:game, series: series)
    visit series_path(series)
    expect(page).to have_content series.name
    expect(page).to have_content game.name
  end
end
