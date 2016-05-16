describe DistributionChannel do
  # Constants
  it 'has categories' do
    ['where to get', 'where to play', 'other'].each do |category|
      expect(DistributionChannel::CATEGORIES).to include(category)
    end
  end

  # Validations
  it 'has a valid factory' do
    expect(build(:distribution_channel)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:distribution_channel, name: nil)).not_to be_valid
  end

  it 'is invalid if duplicate name' do
    distribution_channel = create(:distribution_channel)
    expect(build(:distribution_channel, name: distribution_channel.name)).not_to be_valid
  end
end
