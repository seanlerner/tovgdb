describe Mode do
  # Class Methods
  it 'can find by id' do
    expect(described_class.find(:multiplayer).name).to eq 'Multiplayer'
  end

  it 'can find by name' do
    expect(described_class.find_by_name('Multiplayer').id).to eq :multiplayer
  end

  it 'can find each' do
    expect(described_class.find_each.count).to eq 6
  end

  it 'knows if games exist or not for each mode type' do
    create(:game)
    expect(described_class.non_zero_count.count).to eq 2
  end

  # Instance Methods
  it 'knows games with this mode' do
    game = create(:game, :supporting_all_modes)
    described_class.all.each do |mode|
      expect(mode.games.first).to eq game
    end
  end
end
