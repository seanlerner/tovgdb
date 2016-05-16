ActiveAdmin.register LinkType do
  menu priority: 300

  config.sort_order = 'name_asc'

  # Listing
  index do
    column :name, sortable: :name do |link_type|
      link_to link_type.name, admin_link_type_path(link_type)
    end
    column :game_link
    column :creator_link
    column :category
    column :created_at
    column :updated_at
    actions
  end

  # Show
  config.remove_action_item :destroy

  action_item :destroy, only: :show do
    link_to(
      'Delete Link Type', admin_link_type_path(link_type),
      method: :delete,
      data: { confirm: 'WARNING! Deleting this link type will delete all links using this link type in games and creators.
                        Are you sure you want to delete this link type?' })
  end

  action_item :new, only: :show do
    link_to 'New Link Type', new_admin_link_type_path
  end

  show do
    attributes_table do
      row :name
      row :game_link
      row :creator_link
      row :category
      row :created_at
      row :updated_at
    end

    if link_type.game_link
      panel "Games with #{link_type.name} links (#{link_type.links.games.count})" do
        table_for link_type.links.games do
          column 'Game', :object_has_link
          column :uri, :link do |link|
            link_to link.uri, properly_linked_address(link.uri)
          end
          column :description_override
        end
      end
    end

    if link_type.creator_link
      panel "Creators with #{link_type.name} links (#{link_type.links.creators.count})" do
        table_for link_type.links.creators do
          column 'Creator', :object_has_link
          column :uri, :link do |link|
            link_to link.uri, properly_linked_address(link.uri)
          end
          column :description_override
        end
      end
    end

    active_admin_comments
  end

  # New / Edit
  permit_params :name, :game_link, :creator_link, :category, :created_at, :updated_at

  form do |f|
    render partial: 'admin/admin_base_error_message', locals: { f: f }

    f.inputs do
      f.input :name
      f.input :game_link, hint: 'Check if link type can apply to games.'
      f.input :creator_link, hint: 'Check if link type can apply to creators.'
      f.input :category, collection: LinkType::CATEGORIES
    end

    f.actions do
      if f.object.new_record?
        f.action :submit, label: 'Create Link Type'
      else
        f.action :submit, label: 'Update Link Type'
      end
      f.cancel_link(admin_link_types_path)
    end
  end
end
