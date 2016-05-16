[Creator, Engine, Series, GAME_TAGS].flatten.each do |test_class|
  describe test_class do
    # Validations
    it 'has a valid factory' do
      expect(build(test_class.name.downcase.to_sym)).to be_valid
    end

    it 'is invalid without a name' do
      expect(build(test_class.name.downcase.to_sym, name: nil)).not_to be_valid
    end

    it 'is invalid if duplicate name' do
      test_instance = create(test_class.name.downcase.to_sym)
      expect(build(test_class.name.downcase.to_sym, name: test_instance.name)).not_to be_valid
    end
  end
end
