describe GameHasManyTag do
  it 'can be lowercase' do
    expect(Genre.lowercase).to eq 'genre'
  end

  it 'can be lowercase' do
    expect(Genre.lowercase).to eq 'genre'
  end

  it 'can be pluralized' do
    expect(Genre.pluralized).to eq 'Genres'
  end

  it 'can be lowercase_pluralized' do
    expect(Genre.lowercase_pluralized).to eq 'genres'
  end

  it 'can be pluralized as a symbol' do
    expect(Genre.symbol_pluralized).to eq :genres
  end

  it 'knows its game join model' do
    expect(Genre.game_join_model).to eq 'games_genres'
  end

  it 'knows its game join model' do
    expect(Genre.game_join_model_as_symbol).to eq :games_genres
  end
end
