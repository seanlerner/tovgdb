ActiveAdmin.register Creator do
  menu priority: 200

  # Listing
  config.sort_order = 'name_asc'

  index do
    column :name, sortable: :name do |creator|
      link_to creator.name, admin_creator_path(creator)
    end
    column 'Published', sortable: :published
    column '# of Games', sortable: :games_creators_count do |creator|
      creator.games.count
    end
    column '# of Games Developed' do |creator|
      creator.games_creators.developers.count
    end
    column '# of Games Pubslihed' do |creator|
      creator.games_creators.publishers.count
    end
    column :founded_on
    column :created_at
    column :updated_at
    actions
  end

  # Show
  action_item(:new, only: :show) do
    link_to 'New Creator', new_admin_creator_path
  end

  show do
    attributes_table do
      row :name
      row :alternate_names
      row :published
      row :description
      row :created_at
      row :updated_at
      row 'Logo' do
        if creator.logo.exists?
          image_tag creator.logo.url(:medium)
        else
          "<span class='empty'>Empty</span>".html_safe
        end
      end
      row :old_raw_mediawiki_data do
        "<pre>#{creator.old_raw_mediawiki_data}</pre>".html_safe
      end
    end

    panel 'Links' do
      table_for creator.links do
        column :link_type
        column :uri do |link|
          link_to link.uri, properly_linked_address(link.uri)
        end
        column :description_override
      end
    end

    panel "Games by #{creator.name} (#{creator.games_creators_count})" do
      table_for creator.games do
        column :name do |game|
          link_to game.name, admin_game_path(game)
        end
        column :roles do |game|
          game_creator = GamesCreator.find_by(game_id: game.id, creator_id: creator.id)
          game_creator.roles.join(' & ')
        end
      end
    end

    active_admin_comments
  end

  # New / Edit
  permit_params do
    params = [:name, :alternate_names, :description,
              :logo, :remove_logo,
              game_ids: [], game_attributes:  %i[id _update _create _destroy],
              link_ids: [], links_attributes: %i[id creator_id link_type_id uri description_override _destroy]]
    params << :published if current_admin_user.role == 'Super Admin'
    params
  end

  form html: { multipart: true } do |f|
    render partial: 'admin/admin_base_error_message', locals: { f: f }

    f.inputs do
      f.input :name
      f.input :alternate_names
      f.input :published if current_admin_user.role == 'Super Admin'
      f.input :description
      if f.object.persisted? && f.object.logo.exists?
        f.input :remove_logo, as: :boolean, required: :false, label: 'Remove Logo?'
        f.input :logo, required: false, as: :file, hint: image_tag(f.object.logo.url)
      else
        f.input :logo, required: false, as: :file
      end
    end

    f.inputs 'Links' do
      f.has_many :links, heading: '', new_record: 'Add New Link', allow_destroy: true do |link|
        link.input :link_type, collection: (LinkType.where creator_link: true)
        link.input :uri, as: :string
        link.input :description_override
      end
    end

    f.inputs 'Games' do
      f.input :games, as: :check_boxes, label: ''
    end

    actions
  end
end
