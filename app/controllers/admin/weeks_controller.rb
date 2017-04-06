class Admin::WeeksController < ApplicationController
  def index
    @weeks = Week.all
  end

  def new
    @weeks = []
    6.times do
      @weeks << Week.new
    end
  end

  def create
    if params.has_key?("week")
      Week.create(week_params(params["week"]))
    else
      params["weeks"].each do |week|
        if week["start_date"] != "" || week["end_date"] != "" || week["week_number_id"] != ""
          Week.create(week_params(week))
        end
      end
      redirect_to admin_weeks_path
    end
  end

  private

  def week_params(my_params)
    my_params.permit(:start_date, :end_date, :week_number_id)
  end
end