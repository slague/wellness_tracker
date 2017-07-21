class Admin::WeeksController < ApplicationController
  def index
    @weeks = Week.all
  end

  def new

  end

  def create
    Week.set_weeks((params["number_of_weeks"].to_i), (params["start_date"].to_date))

      redirect_to admin_weeks_path

  end

  private

  def week_params(my_params)
    my_params.permit(:number_of_weeks, :start_date)
  end
end
