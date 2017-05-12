class Admin::WeeksController < ApplicationController
  def index
    @weeks = Week.all
  end

  def new
    # @weeks = []
    # 6.times do
    #   @weeks << Week.new
    # end
  end

  def create
    Week.set_weeks((params["number_of_weeks"].to_i), (params["start_date"].to_date))
  
    # if params.has_key?("week")
    #   Week.create(week_params(params["week"]))
    # else
    #   params["weeks"].each do |week|
    #     if week["start_date"] != "" || week["end_date"] != "" || week["week_number_id"] != ""
    #       Week.create(week_params(week))
    #     end
    #   end
      redirect_to admin_weeks_path

  end

  private

  def week_params(my_params)
    my_params.permit(:number_of_weeks, :start_date)
  end
end