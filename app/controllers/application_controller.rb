class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_week
    Week.last
  end
end
