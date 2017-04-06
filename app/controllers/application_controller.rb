class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_week

  def current_week
    today = Date.today
    Week.where('start_date < ? AND end_date > ?', today, today)
  end
end
