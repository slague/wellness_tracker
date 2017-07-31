class Admin::WinnersController < ApplicationController

  def index
    @winners = Winner.all
  end

  def new
  end

  def show
    @winner = Winner.find(params[:id])
  end

  def create
    random_winner = User.select_weekly_winner(params[:week_id])
    
    if random_winner == nil
      flash[:danger] = "No one achieved 100% of goals this week."
      redirect_to admin_dashboard_index_path

    else
      @winner = Winner.new(user_id: random_winner.id, week_id: params[:week_id])
      if @winner.save
        redirect_to admin_winner_path(@winner)
      else
        render :new
      end
    end

  end


  private

  def winner_params
    params.permit(:user_id, :week_id)
  end
end
