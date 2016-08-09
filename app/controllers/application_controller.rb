class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :console if Rails.env.development?

  def access_denied(exception)
    redirect_to admin_dashboard_path, alert: exception.message
  end
end
