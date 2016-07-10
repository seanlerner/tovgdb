describe GameHasOneTag do
  it 'knows count' do
    series = create :series
    create(:game, series: series)
    expect(series.count).to eq series.games_count
  end
end
