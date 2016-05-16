ActiveAdmin.register Subgenre do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_subgenres_count', menu_priority: 510)
end
