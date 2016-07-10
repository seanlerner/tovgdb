describe Mode do
  MODES = [:single_player, :multiplayer, :local_play, :online_play, :competitive_play, :coop_play].freeze

  it 'views index' do
    visit modes_path
    expect(page).to have_content 'Modes'
    MODES.each do |mode|
      expect(page).to have_content described_class.find(mode).name
    end
  end

  it 'views single' do
    game = create :game, :supporting_all_modes
    MODES.each do |mode|
      visit mode_path(mode)
      expect(page).to have_content described_class.find(mode).name
      expect(page).to have_content game.name
    end
  end
end
