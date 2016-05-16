ActiveAdmin.register Genre do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_genres_count', menu_priority: 500)
end
