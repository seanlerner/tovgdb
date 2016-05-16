describe Video do
  # Constants
  it 'has platforms' do
    %w(YouTube Vimeo).each do |platform|
      expect(Video::PLATFORMS).to include(platform)
    end
  end

  it 'has video types' do
    %w(Trailer Gameplay Demo Other).each do |video_type|
      expect(Video::VIDEO_TYPES).to include(video_type)
    end
  end

  # Validations
  it 'has a valid factory' do
    expect(build(:video)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:video, title: nil)).not_to be_valid
  end

  it 'is invalid without a platform' do
    expect(build(:video, platform: nil)).not_to be_valid
  end

  it 'is invalid without a valid platform' do
    expect(build(:video, platform: 'bad platform')).not_to be_valid
  end

  it 'is invalid without a video_type' do
    expect(build(:video, video_type: nil)).not_to be_valid
  end

  it 'is invalid without a valid video type' do
    expect(build(:video, video_type: 'bad video type')).not_to be_valid
  end

  it 'is invalid without a code' do
    expect(build(:video, code: nil)).not_to be_valid
  end
end
