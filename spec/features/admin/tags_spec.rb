GAME_TAGS.each do |tag_class|
  describe tag_class do
    tag_symbol = tag_class.to_s.downcase.to_sym
    standard_admin_tests tag_symbol

    it 'saves game association' do
      game = create :game
      visit "/admin/#{tag_class.lowercase_pluralized}/#{send(tag_symbol).id}/edit"
      check game.name
      click_button "Update #{tag_class.name}"
      expect(page).to have_content game.name
      visit "/admin/#{tag_class.lowercase_pluralized}"
      expect(page.first('td.col-of_games').text).to eq '1'
    end
  end
end
