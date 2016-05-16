ActiveAdmin.register Series do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_count', menu_priority: 150, tag_games_sentence: 'Tag games in this series')
end
