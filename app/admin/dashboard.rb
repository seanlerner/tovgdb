ActiveAdmin.register_page 'Dashboard' do
  menu priority: -200
  content do
    render partial: 'dashboard'
  end
end
