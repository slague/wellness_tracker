class User::GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :destroy]
  before_action :set_user, only: [:create, :update, :increment]

  def index
    if current_week
      @goals = current_user.goals.where(week_id: current_week.id).order(:created_at)
    else
      @goals = current_user.goals 
    end
  end

  def show
  end

  def new
    @goal = Goal.new
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def create
    @goal = current_user.goals.new(goal_params)
    new_total = goal_params[:total_goal_count]

    # if @goal.reasonable_total?(new_total) && @goal.save
    if @goal.save && new_total.to_i <= 7
      flash[:success] = "Goal was successfully created."
      redirect_to user_goals_path
    else
      flash.now[:danger] = "#{@goal.errors.messages.first[0]} #{@goal.errors.messages.first[1][0]}"
      render :new
    end
  end


  def update
    @goal = current_user.goals.find(params[:format])
    @goal.update(goal_params)
    new_total = goal_params[:total_goal_count]

    # if @goal.reasonable_total?(new_total) && @goal.update(goal_params)
    if new_total.to_i <= 7 && @goal.save
      flash.now[:success] = 'Goal was successfully updated.'
      redirect_to user_goals_path
    else
      flash.now[:danger] = "#{@goal.errors.messages.first[0]} #{@goal.errors.messages.first[1][0]}"
      render :edit
    end
  end

  def destroy
    @goal.destroy
    flash.now[:success] = "Goal Successfully Deleted!"
    redirect_to user_goals_path
  end

  private
    def set_user
      @user = current_user
    end

    def set_goal
      @goal = current_user.goals.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:description,
                                   :total_goal_count,
                                   :category_id).merge(week: current_week)
    end
end
