ActiveAdmin.register MenuItem do
  menu parent: 'Static Content', priority: 200

  # Listing
  config.sort_order = 'menu_asc, order_asc, name_asc'

  index do
    column :menu
    column :order
    column :name
    column :uri
    column :created_at
    column :updated_at
    actions
  end

  # Show
  action_item(:new, only: :show) do
    link_to 'New Menu Item', new_admin_menu_item_path
  end

  show do
    attributes_table do
      row :name
      row :menu
      row :uri
      row :order
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  # New / Edit
  permit_params [:name, :menu, :uri, :order]

  form do |f|
    render partial: 'admin/admin_base_error_message', locals: { f: f }

    f.inputs do
      f.input :name
      f.input :menu, collection: MenuItem::MENUS
      f.input :uri
      f.input :order
    end

    f.actions do
      if f.object.new_record?
        f.action :submit, label: 'Create Menu Item'
      else
        f.action :submit, label: 'Update Menu Item'
      end
      f.cancel_link(admin_menu_items_path)
    end
  end
end
