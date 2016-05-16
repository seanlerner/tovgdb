describe Page do
  # # Constants
  # it 'knows menus' do
  #   ['Main Nav', 'Footer Nav'].each do |menu|
  #     expect(MenuItem::MENUS).to include(menu)
  #   end
  # end

  # # Validations
  # it 'has a valid factory' do
  #   expect(build(:menu_item)).to be_valid
  # end

  # it 'is invalid without a menu' do
  #   expect(build(:menu_item, menu: nil)).not_to be_valid
  # end

  # it 'is invalid without a name' do
  #   expect(build(:menu_item, name: nil)).not_to be_valid
  # end

  # it 'is valid if duplicate name' do
  #   menu_item = create(:menu_item)
  #   expect(build(:menu_item, name: menu_item.name)).to be_valid
  # end

  # it 'is invalid without a uri' do
  #   expect(build(:menu_item, uri: nil)).not_to be_valid
  # end

  # it 'is valid without an order' do
  #   expect(build(:menu_item, order: nil)).to be_valid
  # end

  # it 'is valid with a non-numeric order' do
  #   expect(build(:menu_item, order: 'abc')).not_to be_valid
  # end
end
