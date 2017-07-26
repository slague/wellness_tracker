class Admin::DashboardController < Admin::BaseController

  def index
    @weeks = Week.order_by_created_at
  end


end
