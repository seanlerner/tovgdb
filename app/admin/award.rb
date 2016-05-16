ActiveAdmin.register Award do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_awards_count', menu_priority: 900)
end
