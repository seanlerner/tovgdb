ActiveAdmin.register AdminUser do
  menu priority: 999

  permit_params :email, :password, :password_confirmation, :role

  # Listing
  index do
    column :email
    column :role
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
      f.input :role, collection: AdminUser::ROLES
    end
    f.actions
  end

  controller do
    def update
      if params[:admin_user][:password].blank? && params[:admin_user][:password_confirmation].blank?
        params[:admin_user].delete('password')
        params[:admin_user].delete('password_confirmation')
      end
      super
    end
  end
end
