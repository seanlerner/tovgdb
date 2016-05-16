ActiveAdmin.register AdminUser do
  menu priority: 999

  permit_params :email, :password, :password_confirmation

  # Listing
  index do
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :updated_at
    actions
  end

  # Show
  action_item(:new, only: :show) do
    link_to 'New Admin User', new_admin_admin_user_path
  end

  # New / Edit
  form do |f|
    render partial: 'admin/admin_base_error_message', locals: { f: f }

    f.inputs 'Admin Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
