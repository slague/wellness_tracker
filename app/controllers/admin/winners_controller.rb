class Admin::WeeksController < ApplicationController

  def index
    @winners = Winner.all
    # @weeks = Week.all
  end


  def new
  end

  def create
    @winner = Winner.create(winner_params)

    if @winner.save

      redirect_to admin_dashboard_path
    else
      render :new
    end

  end


  private

  def winner_params
    params.permit(:user_id, :week_id)
  end
end
