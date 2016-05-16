def visit_page_and_check_for_name(instance)
  visit polymorphic_path(instance)
  expect(page).to have_content instance.name
end

def create_games_association_and_visit_page_and_check_for_name(tag_class, instance, game)
  create(tag_class.game_join_model.singularize, game: game, tag_class.lowercase.to_sym => instance)
  visit_page_and_check_for_name(instance)
end

GAME_TAGS.flatten.each do |tag_class|
  describe tag_class do
    let!(:instance) { create tag_class.symbol }

    it 'views index' do
      visit polymorphic_path(tag_class)
      expect(page).to have_content tag_class.name.pluralize
      expect(page).to have_content instance.name
    end

    it 'views single' do
      visit_page_and_check_for_name(instance)
    end

    it 'views single with developers' do
      game = create(:game)
      creator_1 = create(:creator)
      creator_2 = create(:creator)
      create(:games_creator, game: game, creator: creator_1, developer: true)
      create(:games_creator, game: game, creator: creator_2, developer: true)
      create_games_association_and_visit_page_and_check_for_name(tag_class, instance, game)
      expect(page).to have_content creator_1.name
      expect(page).to have_content creator_2.name
    end

    it 'views single with empty game description' do
      game = create(:game, short_description: '', long_description: '')
      create_games_association_and_visit_page_and_check_for_name(tag_class, instance, game)
    end

    it 'views single with game with no image' do
      game = create(:game, :no_game_image)
      create_games_association_and_visit_page_and_check_for_name(tag_class, instance, game)
    end
  end
end
