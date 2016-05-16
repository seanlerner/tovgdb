describe LinkType do
  # Constants
  it 'has categories' do
    ['website', 'email', 'social media', 'other'].each do |category|
      expect(LinkType::CATEGORIES).to include(category)
    end
  end

  # Validations
  it 'has a valid factory' do
    expect(build(:link_type)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:link_type, name: nil)).not_to be_valid
  end

  it 'is invalid if duplicate name' do
    link_type = create(:link_type)
    expect(build(:link_type, name: link_type.name)).not_to be_valid
  end

  it 'is invalid if not a game or creator link' do
    expect(build(:link_type, name: 'Valid Name', game_link: nil, creator_link: nil)).not_to be_valid
  end
end
