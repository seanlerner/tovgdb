ActiveAdmin.register Theme do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_themes_count', menu_priority: 590)
end
