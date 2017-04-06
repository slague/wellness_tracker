class Admin::WeeksController < ApplicationController
  def index
    @weeks = Week.all
  end

  def new
    @week = Week.new
  end

  def create
    @week = Week.new(week_params)
    if @week.save
      redirect_to admin_weeks_path
    else
      render :new
    end
  end

  private

  def week_params
    params.require(:week).permit(:start_date, :end_date, :week_number_id)
  end
end