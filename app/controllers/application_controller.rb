class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_week

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_week
    today = Date.today
    Week.find_by('start_date <= ? AND end_date >= ?', today, today)
  end

  def current_admin?
    current_user && current_user.admin?
  end

end
