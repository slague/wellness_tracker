class Admin::DashboardController < Admin::BaseController

  def index
    @weeks = Week.all.order(:created_at)
  end


end
