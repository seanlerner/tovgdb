ActiveAdmin.register_page 'Dashboard' do
  menu priority: -200

  content do
    case current_admin_user.role
    when 'Super Admin'
      render partial: 'games_by_publication_statuses', locals:
        { publication_statuses: [:processed_complete, :processed_incomplete, :published_incomplete,
                                 :published_complete, :ready_for_processing, :processing, :undefined] }
    when 'Clerk'
      render partial: 'games_by_publication_statuses', locals: { publication_statuses: [:ready_for_processing] }
    end
  end
end
