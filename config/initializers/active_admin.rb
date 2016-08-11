ActiveAdmin.setup do |config|
  config.site_title = 'TOVGDB Admin'
  config.site_title_link = '/'
  config.authentication_method = :authenticate_admin_user!
  config.authorization_adapter = ActiveAdmin::CanCanAdapter
  config.on_unauthorized_access = :access_denied
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path
  config.comments_menu = false
  config.batch_actions = false
  config.localize_format = :long
  config.register_stylesheet 'tovgdb_active_admin.css'
  config.default_per_page = 10_000
  config.filters = false

  # TODO: Header Image
  # Set an optional image to be displayed for the header
  # instead of a string (overrides :site_title)
  # Note: Aim for an image that's 21px high so it fits in the header.
  # config.site_title_image = "logo.png"

  # TODO: Favicon
  # config.favicon = 'favicon.ico'

  config.namespace :admin do |admin|
    admin.build_menu do |menu|
      menu.add label: 'Static Content', priority: 400
    end
  end

  require 'concerns/admin_game_tag.rb'
end

module ActiveAdmin
  class ResourceController
    module DataAccess
      def apply_sorting(chain)
        order = params[:order]
        order ||= active_admin_config.sort_order
        orders = []
        order.present? && order.split(/\s*,\s*/).each do |fragment|
          captures = /^(?<column>[\w\_\.]+)_(?<order>desc|asc)$/.match(fragment)
          column = captures[:column]
          table = active_admin_config.resource_column_names.include?(column) ? active_admin_config.resource_table_name : nil
          table_column = (column =~ /\./) ? column : [table, active_admin_config.resource_quoted_column_name(column)].compact.join('.')
          orders << "#{table_column} #{captures[:order]}"
        end
        orders.empty? ? chain : chain.reorder(orders.shift).order(orders)
      end
    end
  end
end
