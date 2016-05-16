ActiveAdmin.register Community do
  extend AdminGameTag

  setup_game_tag_for_admin(games_count_column: 'games_communities_count', menu_priority: 800)
end
