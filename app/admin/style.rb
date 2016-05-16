ActiveAdmin.register Style do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_styles_count', menu_priority: 600)
end
