module AdminGameTag
  def setup_game_tag_for_admin(games_count_column:, menu_priority: 9999, tag_games_sentence: nil)
    menu parent: 'Tags', priority: menu_priority
    setup_game_tag_listing_for_admin(games_count_column: games_count_column)
    setup_game_tag_show_for_admin(games_count_column: games_count_column)
    setup_game_tag_new_edit_for_admin(tag_games_sentence: tag_games_sentence)
  end

  def setup_game_tag_listing_for_admin(games_count_column:)
    config.sort_order = 'name_asc'

    index do
      column 'Name', sortable: :name do |tag|
        link_to tag.name, polymorphic_path([:admin, tag])
      end
      column '# of Games', sortable: games_count_column do |tag|
        tag.games.count
      end
      [:description, :created_at, :updated_at].each { |symbol| column symbol }
      actions
    end
  end

  def setup_game_tag_show_for_admin(games_count_column:)
    action_item(:new, only: :show) { link_to "New #{resource.class}", new_polymorphic_path([:admin, resource.class]) }

    show do
      attributes_table do
        row :name
        row :description
        row :created_at
        row :updated_at
      end
      panel "Games tagged as #{resource.name} (#{resource.send(games_count_column)})" do
        table_for resource.games do
          column :name do |game|
            link_to game.name, admin_game_path(game)
          end
        end
      end
      active_admin_comments
    end
  end

  def setup_game_tag_new_edit_for_admin(tag_games_sentence: nil)
    permit_params :name, :description, game_ids: []

    form do |game_tag_form|
      render partial: 'admin/admin_base_error_message', locals: { f: game_tag_form }
      resource_name = resource.class.to_s

      game_tag_form.inputs "#{resource_name} Details" do
        game_tag_form.input :name
        game_tag_form.input :description, hint: "Appears under #{resource_name.downcase} name on listing page"
      end

      game_tag_form.inputs tag_games_sentence || "Tag games with this #{resource_name.downcase}" do
        game_tag_form.input :games, as: :check_boxes, collection: Game.order(:name)
      end

      game_tag_form.actions
    end
  end
end
