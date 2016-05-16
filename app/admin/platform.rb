ActiveAdmin.register Platform do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_platforms_count', menu_priority: 490)
end
