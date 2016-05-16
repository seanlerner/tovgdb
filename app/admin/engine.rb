ActiveAdmin.register Engine do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_count', menu_priority: 300, tag_games_sentence: 'Tag games made with this engine')
end
