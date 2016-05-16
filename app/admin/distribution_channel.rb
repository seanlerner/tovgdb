ActiveAdmin.register DistributionChannel do
  menu priority: 290

  config.sort_order = 'name_asc'

  # Listing
  index do
    column :name, sortable: :name do |distribution_channel|
      link_to distribution_channel.name, admin_distribution_channel_path(distribution_channel)
    end
    column :category
    column '# of Games', sortable: :games_distribution_channels_count do |distribution_channel|
      distribution_channel.games.count
    end
    column :created_at
    column :updated_at
    actions
  end

  # Show
  config.remove_action_item :destroy

  action_item :destroy, only: :show do
    link_to('Delete Distribution Channel', admin_distribution_channel_path(distribution_channel), method: :delete, data:
      { confirm: %(WARNING! Deleting this distribution channel will delete all game references to this distribution channel.
                   Are you sure you want to delete this distribution_channel?') })
  end

  action_item :new, only: :show do
    link_to 'New Distribution Channel', new_admin_distribution_channel_path
  end

  show do
    attributes_table do
      row :name
      row :description
      row :category
      row :created_at
      row :updated_at
    end

    panel "Games with #{distribution_channel.name} as a distribution channel (#{distribution_channel.games_distribution_channels.count})" do
      table_for distribution_channel.games_distribution_channels do
        column :game
        column :uri do |games_distribution_channel|
          link_to games_distribution_channel.uri, games_distribution_channel.uri
        end
      end
    end

    active_admin_comments
  end

  # New / Edit
  permit_params :name, :description, :category, :created_at, :updated_at

  form do |f|
    render partial: 'admin/admin_base_error_message', locals: { f: f }

    f.inputs do
      f.input :name
      f.input :description
      f.input :category, collection: DistributionChannel::CATEGORIES
    end

    f.actions do
      if f.object.new_record?
        f.action :submit, label: 'Create Distribution Channel'
      else
        f.action :submit, label: 'Update Distribution Channel'
      end
      f.cancel_link(admin_distribution_channels_path)
    end
  end
end
