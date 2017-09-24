class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def access_denied(exception)
    redirect_to admin_dashboard_path, alert: exception.message
  end
end
