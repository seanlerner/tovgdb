describe GameHasManyTag do
  it 'can be lowercase' do
    expect(Subgenre.lowercase).to eq 'subgenre'
  end

  it 'can be lowercase' do
    expect(Subgenre.lowercase).to eq 'subgenre'
  end

  it 'can be pluralized' do
    expect(Subgenre.pluralized).to eq 'Subgenres'
  end

  it 'can be lowercase_pluralized' do
    expect(Subgenre.lowercase_pluralized).to eq 'subgenres'
  end

  it 'can be pluralized as a symbol' do
    expect(Subgenre.symbol_pluralized).to eq :subgenres
  end

  it 'knows its game join model' do
    expect(Subgenre.game_join_model).to eq 'games_subgenres'
  end

  it 'knows its game join model' do
    expect(Subgenre.game_join_model_as_symbol).to eq :games_subgenres
  end
end
