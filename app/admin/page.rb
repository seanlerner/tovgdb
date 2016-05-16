ActiveAdmin.register Page do
  menu parent: 'Static Content', priority: 100

  # Listing
  config.sort_order = 'title_asc'

  index do
    column :title
    column :slug
    column :created_at
    column :updated_at
    actions
  end

  # # Show
  action_item(:new, only: :show) do
    link_to 'New Page', new_admin_page_path
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  # New / Edit
  permit_params [:title, :slug, :content]

  form do |f|
    render partial: 'admin/admin_base_error_message', locals: { f: f }

    f.inputs do
      f.input :title
      f.input :slug
      f.input :content
    end

    f.actions do
      if f.object.new_record?
        f.action :submit, label: 'Create Page'
      else
        f.action :submit, label: 'Update Page'
      end
      f.cancel_link(admin_pages_path)
    end
  end
end
